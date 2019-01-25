SRV_IP="10.0.1.3"
SRV_PORT="2300"
SRV_HOST="inetlab-05"

CLI_IP="10.0.1.1"
CLI_HOST="inetlab-03"
CLI_PARAMS="-serverAddr=${SRV_IP}:${SRV_PORT} -frameDelay=${CLI_PACING} -frameBufferLength=${CLI_BUFFLEN} -inFile=${INPUT_VIDEO} -pipe"
##curl --interface eth0

BRIDGE_HOST="inetlab-04"
BRIDGE_SRV_IF="enp132s0f1np1" 
BRIDGE_CLI_IF="enp132s0f0np0"
