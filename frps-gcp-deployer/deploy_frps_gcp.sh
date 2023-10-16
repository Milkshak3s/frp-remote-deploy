#!/bin/bash

# Must set:
# GCP_PROJECT_ID, DNS_NAME, FRP_SERVER_PORT
gcloud auth activate-service-account --key-file /etc/gcp-sa/service-account.json

gcloud config set project $GCP_PROJECT_ID
gcloud config set compute/region us-west1
gcloud config set compute/zone us-west1-b

echo "PORT=${FRP_SERVER_PORT}" | cat - frps_startup.sh > temp && mv temp frps_startup.sh
STARTUP_SCRIPT=`cat frps_startup.sh`
gcloud compute instances create frps-${DNS_NAME} \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --machine-type=e2-micro \
    --metadata=startup-script=${STARTUP_SCRIPT}

