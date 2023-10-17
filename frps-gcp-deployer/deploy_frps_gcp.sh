#!/bin/bash

# Must set:
# GCP_PROJECT_ID, DNS_A_NAME, DNS_ZONE, DNS_BASE_DOMAIN, FRP_SERVER_PORT
gcloud auth activate-service-account --key-file /etc/gcp-sa/service-account.json

gcloud config set project $GCP_PROJECT_ID
gcloud config set compute/region us-west1
gcloud config set compute/zone us-west1-b

echo "PORT=${FRP_SERVER_PORT}" | cat - frps_startup.sh > temp && mv temp frps_startup.sh
STARTUP_SCRIPT=`cat frps_startup.sh`
INSTANCE_NAME="frps-${DNS_A_NAME}"
gcloud compute instances create ${INSTANCE_NAME} \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --machine-type=e2-micro \
    --network-tier=STANDARD \
    --metadata=startup-script=${STARTUP_SCRIPT}

PROXY_IP=`gcloud compute instances describe ${INSTANCE_NAME} --format="value(networkInterfaces[0].accessConfigs[0].natIP)"`
DNS_FULL_NAME="${DNS_ZONE}.${DNS_BASE_DOMAIN}"
gcloud dns record-sets create ${DNS_A_NAME}.${DNS_FULL_NAME}. --rrdatas=${PROXY_IP} --type=A --ttl=60 --zone=${DNS_ZONE}
