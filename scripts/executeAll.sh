#!/bin/bash


# ssh Key should be used
# username@hostname
serverPC="lars@pc1"
clientPC="lars@pc87"
moonGenPC="lars@pc86"
dagPC="stratmann@DAG"



srcInterface="3"
destInterface="2"


destIPAdress="10.1.3.3"

moonGenScript="examples/l2-forward-psring-hybrid-latency-rate.lua"
#testName="rnc-psr-t1-"
testName="iperf-psr-t01-"

iperfExecuteTime="2"
dagExecuteTime=$((iperfExecuteTime + 10))
moonGenExecuteTime=$((dagExecuteTime + 10))
waitTime=$((moonGenExecuteTime))

# List from Bandwidth length to test
rateList="1 5 10" # 5 10 15 20 25 30 35"
 #10 50 100"
# List from latencies to test
latencyList="0"
# List from RingSize, how much Packages will stay in the ring
# See measurement from the paper
ringSizeList="280"

# number of similar tests
testNumber=1

# List form the MTU that should be tested
byteSizeListDAG=(1400)
byteSizeListIperf=(1.4)

iperfServerCommand="iperf3 -s"


# Cleaning
ssh $serverPC 'sudo killall iperf3' &
ssh $moonGenPC 'sudo killall MoonGen' &
ssh $clientPC 'sudo killall iperf3'&

sleep 1


moonGenMainCommand="cd MoonGen/MoonGen; sudo ./build/MoonGen $moonGenScript -d $srcInterface $destInterface -r 40 40 -l 0 0 -q 280 280"
moonGenTerminateCommand="sudo killall MoonGen"

ssh $moonGenPC $moonGenMainCommand &

sleep 5


#Initial
ssh lars@pc1 $iperfServerCommand &
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
                iperfClientCommand="iperf3 -c $destIPAdress -t $iperfExecuteTime -u -b '$r'M -l 1.4K"
                dagCommad="sudo dagsnap -s $dagExecuteTime -d0 -v -o '$testName'r$r-l$l-q$q-t$t.erf"


                #ssh $moonGenPC $moonGenMainCommand &

                #sleep 5

                ssh $dagPC $dagCommad &

                sleep 2

                ssh $clientPC $iperfClientCommand &


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
ssh -t $serverPC 'sudo killall iperf3' &
