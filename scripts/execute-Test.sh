#!/bin/bash


# ssh Key should be used
# username@hostname
serverPC="lars@130.75.73.140"
clientPC="lars@130.75.73.226"
moonGenPC="lars@130.75.73.225"
dagPC="stratmann@130.75.73.131"


downlink=true
testNumber="10"

destIPAdress="10.1.3.2"

moonGenScript="examples/l2-forward-psring-hybrid-latency-rate-lte.lua"

if ${downlink}
then
    # Downlink
    srcInterface="3"
    destInterface="2"
    testName="rnc-psr-downlink-t$testNumber-"

else
    # Uplink
    srcInterface="2"
    destInterface="3"
    testName="rnc-psr-uplink-t$testNumber-"
fi

iperfExecuteTime="4"
dagExecuteTime=$((iperfExecuteTime + 5))
moonGenExecuteTime=$((dagExecuteTime + 5))
#waitTime=$((moonGenExecuteTime))
waitTime=$((dagExecuteTime))

# List from Bandwidth length to test
rateList="1 5 10 15 20 25 30 35 40 45 50"
 #10 50 100"
# List from latencies to test
latencyList="10"
# List from RingSize, how much Packages will stay in the ring
# See measurement from the paper
ringSizeList="280"

# number of similar tests
testNumber=10

# List form the MTU that should be tested
byteSizeListDAG=(1400)
byteSizeListIperf=(1.4)

#serverCommand="iperf3 -s"
serverCommand="./rnc/rude/crude/crude"

# Cleaning
#ssh $serverPC 'sudo killall iperf3' &
ssh $serverPC 'sudo killall crude' &
ssh $moonGenPC 'sudo killall MoonGen' &
#ssh $clientPC 'sudo killall iperf3'&
ssh $clientPC 'sudo killall rude' &


sleep 1


moonGenMainCommand="cd MoonGen/MoonGen; sudo ./build/MoonGen $moonGenScript -d $srcInterface $destInterface -r 40 35 -l 30 10 -q 350 1100 --short_DRX_cycle_length 8 --long_DRX_cycle_length 12 --active_time 1"
moonGenTerminateCommand="sudo killall MoonGen"

ssh $moonGenPC $moonGenMainCommand &

sleep 5


#Initial
ssh $serverPC $serverCommand &
sleep 1

for r in $rateList;
do
    for l in $latencyList;
    do
        for q in $ringSizeList;
        do
            t=0

            echo "$testName-r$r-l$l-q$q"

            while [ $t -lt $testNumber ]
            do
                #for (( i=0; i<${#byteSizeListDAG[@]}; i++ ));
                #do
                #echo "$testName-r$r-l$l-q$q"

                #moonGenMainCommand="cd MoonGen/MoonGen; sudo ./build/MoonGen $moonGenScript -d $srcInterface $destInterface -r 40 40 -l $l $l -q $q $q"

                #moonGenTerminateCommand="sudo killall MoonGen"
                #clientCommand="iperf3 -c $destIPAdress -t $iperfExecuteTime -u -b '$r'M -l 1.4K"
                clientCommand="./MoonGen/rude/rude/rude -s MoonGen/rude/udp-1400-'$r'Mbps-4sec.cfg"
                #dagCommand="sudo dagsnap -s $dagExecuteTime -d0 -v -o '$testName'r$r-l$l-q$q-t$t.erf"
                dagCommand="sudo dagsnap -s $dagExecuteTime -d0 -v -o '$testName'r$r-t$t.erf"

                helperCommand="ssh $dagPC $dagCommand &"


                #ssh $moonGenPC $moonGenMainCommand &

                #sleep 5

                ssh $clientPC $helperCommand &

                sleep 2

                ssh $clientPC $clientCommand &


                sleep $waitTime

                #ssh $moonGenPC $moonGenTerminateCommand &

                #sleep 5
                #done
                true $((t++))
            done
        done
    done
done
ssh $moonGenPC $moonGenTerminateCommand &
#ssh -t $serverPC 'sudo killall iperf3' &
ssh -t $serverPC 'sudo killall crude' &