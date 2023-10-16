wget https://github.com/fatedier/frp/releases/download/v0.52.1/frp_0.52.1_linux_amd64.tar.gz
tar -xf frp_0.52.1_linux_amd64.tar.gz
echo "bindPort = ${PORT}" > /frp_0.52.1_linux_amd64/frps.toml

/frp_0.52.1_linux_amd64/frps -c /frp_0.52.1_linux_amd64/frps.toml
