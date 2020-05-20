# Installation
git clone and docker-compose up

# Networks
If you are using VirtualBox use Bridge network. If you use NAT it will not work, even if you use forwarding on VBox setting both UDP/TCP port 27015.

# Passwords
Change Rcon_password no config/server.cfg and AMX admin pass on config/amxmodx_config/users.ini

# Bots
PodBot is installed. It works only on a predifined number of maps.

# Config
Relevant config is on config folder. If you want to change other file that it is not in the config folder, or install plugins, you'll need to re-build docker image (```docker-compose build```) and re-create the container (```docker-compose stop cs && docker-compose rm -f cs && docker-compose up```)

# Known issues
- Not sure why, but Steam client can't download the maps. If they already have the maps, it works, but if they don't it fails (even if the maps are exactly the same one that are downloaded from other servers by steam clients). Non-steam clients work fine.
- When there are bots on the server, ```allow_spectators``` setting is ignored. Even if it is 1, you can't spectate.

