#!/bin/bash
sed -i 's@FRP_SERVER_ADDR@'"$FRP_SERVER_ADDR"'@' /frp_0.52.1_linux_amd64/frpc.toml
sed -i 's@FRP_SERVER_PORT@'"$FRP_SERVER_PORT"'@' /frp_0.52.1_linux_amd64/frpc.toml
sed -i 's@FRP_LOCAL_SERVICE_ADDR@'"$FRP_LOCAL_SERVICE_ADDR"'@' /frp_0.52.1_linux_amd64/frpc.toml
sed -i 's@FRP_LOCAL_SERVICE_PORT@'"$FRP_LOCAL_SERVICE_PORT"'@' /frp_0.52.1_linux_amd64/frpc.toml
sed -i 's@FRP_REMOTE_PORT@'"$FRP_REMOTE_PORT"'@' /frp_0.52.1_linux_amd64/frpc.toml
cat /frp_0.52.1_linux_amd64/frpc.toml
/frp_0.52.1_linux_amd64/frpc -c /frp_0.52.1_linux_amd64/frpc.toml
