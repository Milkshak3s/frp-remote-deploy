#!/bin/bash

# Must set:
# GCP_PROJECT_ID, DNS_A_NAME, DNS_ZONE, DNS_BASE_DOMAIN, FRP_SERVER_PORT, DELETE_NOT_CREATE=false
# and some GCP credentials at /etc/gcp-sa/service-account.json
gcloud auth activate-service-account --key-file /etc/gcp-sa/service-account.json

gcloud config set project $GCP_PROJECT_ID
gcloud config set compute/region us-west1
gcloud config set compute/zone us-west1-b

INSTANCE_NAME="frps-${DNS_A_NAME}"
DNS_FULL_NAME="${DNS_A_NAME}.${DNS_ZONE}.${DNS_BASE_DOMAIN}" # remember the trailing "." when using!

# defaults to create if $DELETE_NOT_CREATE is not set, or is anything other than "true" case sensitive
echo $DELETE_NOT_CREATE
if [ $DELETE_NOT_CREATE == 'true' ]
then
    echo "[i] DELETE_NOT_CREATE is set, deleting compute instance with name: ${INSTANCE_NAME}"
    gcloud compute instances delete ${INSTANCE_NAME}
    echo "[i] Deleting DNS record with name: ${DNS_FULL_NAME}."
    gcloud dns record-sets delete ${DNS_FULL_NAME}. --type=A --zone=${DNS_ZONE}
else
    echo "[i] Creating compute instance with name: ${INSTANCE_NAME}"
    echo "PORT=${FRP_SERVER_PORT}" | cat - /run/frps_startup.sh > /run/temp && mv /run/temp /run/frps_startup.sh
    STARTUP_SCRIPT=`cat /run/frps_startup.sh | base64 -w 0`
    gcloud compute instances create ${INSTANCE_NAME} \
        --image-family=debian-12 \
        --image-project=debian-cloud \
        --machine-type=e2-micro \
        --network-tier=STANDARD \
        --no-service-account \
        --no-scopes \
        --metadata=startup-script="echo ${STARTUP_SCRIPT} | base64 -d | bash &"

    PROXY_IP=`gcloud compute instances describe ${INSTANCE_NAME} --format="value(networkInterfaces[0].accessConfigs[0].natIP)"`
    echo "[i] Creating DNS record with name: ${DNS_FULL_NAME}."
    gcloud dns record-sets create ${DNS_FULL_NAME}. --rrdatas=${PROXY_IP} --type=A --ttl=60 --zone=${DNS_ZONE}
fi
