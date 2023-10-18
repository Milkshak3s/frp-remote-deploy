# Must set:
# FRP_SERVER_ADDR, FRP_SERVER_PORT, FRP_LOCAL_SERVICE_ADDR, FRP_LOCAL_SERVICE_PORT, FRP_REMOTE_PORT
FROM debian

RUN apt update && apt install -y wget

RUN wget https://github.com/fatedier/frp/releases/download/v0.52.1/frp_0.52.1_linux_amd64.tar.gz
RUN tar -xf frp_0.52.1_linux_amd64.tar.gz

COPY ./run_frpc.sh ./run_frpc.sh
RUN chmod +x ./run_frpc.sh
COPY ./frpc.toml /frp_0.52.1_linux_amd64/frpc.toml

ENTRYPOINT ["./run_frpc.sh"]
