FROM google/cloud-sdk:402.0.0-alpine

COPY . /run
RUN chmod +x /run/deploy_frps_gcp.sh

ENTRYPOINT ["/run/deploy_frps_gcp.sh"]