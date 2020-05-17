#!/bin/bash
screen -A -m -d -S hldstest ./hlds_run -game cstrike +ip 0.0.0.0 +port 27018 +maxplayers 32 +map de_dust2_long_short +sys_ticrate 1000
echo Server is started!
