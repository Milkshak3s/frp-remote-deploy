# frp-remote-deploy

Containers for deploying `fatedier/frp` in GCP, for use by k8s clusters behind NAT.

## USAGE
### CLIENT
```docker run --env FRP_SERVER_ADDR=[addr] --env FRP_SERVER_PORT=[srv port] --env FRP_LOCAL_SERVICE_ADDR=[local addr] --env FRP_LOCAL_SERVICE_PORT=[local port] --env FRP_REMOTE_PORT=[remote port] ghcr.io/milkshak3s/frpc:v1.0.0```
### SERVER - CREATE
```docker run --env GCP_PROJECT_ID=[project_id] --env DNS_A_NAME=[a record name] --env DNS_ZONE=[subdomain] --env DNS_BASE_DOMAIN=[cloud domain] --env FRP_SERVER_PORT=[srv port] -v ./sa.json:/etc/gcp-sa/service-account.json ghcr.io/milkshak3s/frps-gcp-deployer:latest```
### SERVER - DELETE
```docker run --env GCP_PROJECT_ID=[project_id] --env DNS_A_NAME=[a record name] --env DNS_ZONE=[subdomain] --env DNS_BASE_DOMAIN=[cloud domain] --env FRP_SERVER_PORT=[srv port] --env DELETE_NOT_CREATE=true -v ./sa.json:/etc/gcp-sa/service-account.json docker pull ghcr.io/milkshak3s/frps-gcp-deployer:latest```
