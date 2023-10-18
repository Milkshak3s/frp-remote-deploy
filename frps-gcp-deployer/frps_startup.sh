# an env var export is added to the top of this file during container runtime! see: deploy_frps_gcp.sh
# PORT=7000
wget -O /tmp/frp_0.52.1_linux_amd64.tar.gz https://github.com/fatedier/frp/releases/download/v0.52.1/frp_0.52.1_linux_amd64.tar.gz
tar -xf /tmp/frp_0.52.1_linux_amd64.tar.gz -C /tmp/
echo "bindPort = ${PORT}" > /tmp/frp_0.52.1_linux_amd64/frps.toml

/tmp/frp_0.52.1_linux_amd64/frps -c /tmp/frp_0.52.1_linux_amd64/frps.toml
