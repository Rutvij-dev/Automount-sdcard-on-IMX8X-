####################################################
# Author: Rutvij Trivedi                           #
# i.mx8x - NXP imx8x                               #
# Change the permission , make a service,          #
# trigger on udev rules to auto mount sd card      #
####################################################

#!/bin/bash 
if [ "$1" == "-d" -o "$1" == "--debug" ]; then
	debug=1
	debug_head="[SD_DETECT]"
	debug_path="/home/root/data/data/debug/sdDetect.log"
fi

debug_print() {
	if [[ $debug -eq 1 ]]; then
		echo "${debug_head} ${1}" >> $debug_path
	fi
}

ret=0
check_error() {
	ret=$?
	if [[ $ret -ne 0 ]]; then
		dbg="Command failed to execute"
		debug_print "${dbg}"
#		exit $ret
	fi
}


# Detect Device Name
sleep 1
sdPaths=($(find /dev -name "mmcblk1p[0-9]"))
sdPath="${sdPaths[0]}" 
echo "$sdPath"
dbg="SD Card Connected at $sdPath"
debug_print "${dbg}"


# Make mount point for SD Card
if [ ! -z "$sdPath" ]; then
	if [ ! -d "/home/root/sdCard" ]; then
		mkdir /home/root/sdCard
	fi
	echo "Mounting sd card"
	sudo mount $sdPath /home/root/sdCard;
	sync ;
	sleep 1
fi
exit 0
