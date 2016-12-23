
# this can be IP address or FQDN
IP="baiduxxcxxs.com"

# totalFailCount is totally continous fails count.
totalFailCount=0

# if totalFailCount  greater than beepTimes
beepTimes=2

# if totalFailCount greater than maxFails, the test program will exit.
maxFails=4

# log file name 
logFile=ping.log

function beep() {
	echo -en '\007'
}

echo "" >> $logFile
echo "start ping test, ping $IP, `date`" >> $logFile

while [[ true ]]; do
	if ping $IP -n 1; then
		let totalFailCount=0
		echo "ok"
	else
		let totalFailCount=$totalFailCount+1
	fi

	if [ $totalFailCount -gt "$beepTimes" ]; then 
		beep
	fi

	if [ $totalFailCount -gt "$maxFails" ]; then 

		echo "ping $IP filed more then $maxFails times. `date`" >> $logFile
		# err print
		echo `ping $IP` >> $logFile
		exit 1
	fi

done

echo "end ping test, ping $IP, `date`" >> $logFile
