FROM debian:stable
RUN mkdir /myapp
WORKDIR /myapp
EXPOSE 27015/tcp
EXPOSE 27015/udp
RUN groupadd -r cstrike && useradd --no-log-init -r -g cstrike cstrike
ADD hlds4linux_cspak /myapp
RUN apt-get update && \
apt-get install -y lib32gcc1 && \
rm -rf /var/lib/apt/lists/*
RUN chmod +x hlds_run && \
chmod +x hlds_amd && \
chmod +x hlds_i486 && \
chmod +x hlds_i686
RUN echo "going to change permissions" && \
chown -R cstrike /myapp/cstrike/addons/amxmodx/logs && \
echo "permissions for amxmodx/logs changed" && \
chown -R cstrike /myapp/cstrike/logs && \
echo "permissions for cstrike/logs changed" && \
chown -R cstrike /myapp/cstrike/addons/podbot/wptdefault && \
echo "allowed podbot to write visibilities tables"
RUN echo "going to change user"
USER cstrike
CMD ["bash", "-c", "./hlds_run -game cstrike +ip 0.0.0.0 +port 27015 +maxplayers 32 +map fy_iceworld +sys_ticrate 1000"]
