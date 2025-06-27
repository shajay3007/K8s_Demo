https://ak-delivery04-mul.dhe.ibm.com/sdfdl/v2/sar/CM/WS/0cukv/0/Xa.2/Xb.jusyLTSp44S045Y4OVpbXFxhhgF6iuO8PZjH7X9WW2VZcYGe5xPuKabM_4k/Xc.CM/WS/0cukv/0/12.0-ACE-LINUXX64-12.0.12.11.tar.gz/Xd./Xf.LPR.D1VK/Xg.13244674/Xi.habanero/XY.habanero/XZ.nbAhKGpxB9yHxrD3RL43H1jdDI7aXPLx/12.0-ACE-LINUXX64-12.0.12.11.tar.


#!/bin/bash

echo;echo -e "\e[97m[+] I am in the HOST\e[1;31m   `hostname -i`\e[0m";echo

ARAY+=("CHANNEL" "STATUS" "CONNAME" "XMITQ" "TRIGDATA" "CURDEPTH" "RQMNAME")
printf "\u001b[41;1m\u001b[4m${ARAY[0]}%"`echo "$((32-${#ARAY[0]}))"`"s\e[0m\033[49m";
printf "\u001b[41;1m\u001b[4m${ARAY[1]}%"`echo "$((32-${#ARAY[1]}))"`"s\e[0m\033[49m";
printf "\u001b[41;1m\u001b[4m${ARAY[2]}%"`echo "$((32-${#ARAY[2]}))"`"s\e[0m\033[49m";
printf "\u001b[41;1m\u001b[4m${ARAY[3]}%"`echo "$((32-${#ARAY[3]}))"`"s\e[0m\033[49m";
printf "\u001b[41;1m\u001b[4m${ARAY[4]}%"`echo "$((32-${#ARAY[4]}))"`"s\e[0m\033[49m";
printf "\u001b[41;1m\u001b[4m${ARAY[5]}%"`echo "$((32-${#ARAY[5]}))"`"s\e[0m\033[49m";
printf "\u001b[41;1m\u001b[4m${ARAY[6]}%"`echo "$((32-${#ARAY[6]}))"`"s\e[0m\033[49m";echo
echo
for qm in ` dspmq | cut -d"(" -f2 | cut -d")" -f1 | grep -v QM_CACHE ` ;
  do
    if [[ `echo "end" | runmqsc $qm > /dev/null 2>&1 ; echo $?` -eq 0 ]]
      then
        for CHAN in `echo "DISPLAY CHANNEL(CH*)" | runmqsc $qm | cut -d "(" -f2 | cut -d ")" -f1 |grep CH_`
          do
            CONA=`echo "DISPLAY CHANNEL($CHAN)" |runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep CONNAME`
            STAT=`echo "DISPLAY CHS($CHAN)" |runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep STATUS | cut -d "(" -f2 | cut -d ")" -f1 `
            TRAQ=`echo "DISPLAY CHANNEL($CHAN)" | runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep XMITQ |cut -d "(" -f2 | cut -d ")" -f1`
            TRIG=`echo "DISPLAY QLOCAL($TRAQ) " | runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep TRIGDATA`
            CURD=`echo "DISPLAY QLOCAL($TRAQ) " | runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep CURDEPTH`
            RQMN=`echo "DISPLAY QREMOTE(*)" RQMNAME|runmqsc $qm|sed "s/( )/()/g"|awk '{print $1,"\n"$2}'|grep RQMNAME|grep -v "RQMNAME()"|sort -u|cut -d "(" -f2 | cut -d ")" -f1 `
            RQCN=`echo "DISPLAY QREMOTE(*)" RQMNAME | runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}' | grep RQMNAME | grep -v "RQMNAME()" | sort -u | wc -l`
            PORT=`echo "DISPLAY CHANNEL($CHAN)" |runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep CONNAME | cut -d "(" -f3 | cut -d ")" -f1`
            TRIV=`echo "DISPLAY QLOCAL($TRAQ) " | runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep TRIGDATA |cut -d "(" -f2 | cut -d ")" -f1`
            if [[ $STAT == "RUNNING" ]]
              then
                if [[ $RQCN -eq 2 ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue is Not Unique  ]] \e[0m" ;echo
                elif [[ $PORT -eq 1414 && $RQMN != "QMEIS_PROD_DB" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1415 && $RQMN != "QMEIS_PROD_DB_1" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1416 && $RQMN != "QMEIS_PROD_DB_2" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1417 && $RQMN != "QM_CCSID_1208" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1418 && $RQMN != "QMEIS_PROD_DB_3" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m" ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $CHAN != $TRIV ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Channel and Trigdata are Mismatched  ]] \e[0m" ;echo
                    printf "\e[91m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[97m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[91m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[97m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                else
                    echo;echo -e "\e[92m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m";echo;
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[97m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[97m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                fi

            elif [[ $STAT == "" ]]
              then
                STAT=`echo "NO_HITS"`
                if [[ $RQCN -eq 2 ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue is Not Unique  ]] \e[0m" ;echo
                elif [[ $PORT -eq 1414 && $RQMN != "QMEIS_PROD_DB" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1415 && $RQMN != "QMEIS_PROD_DB_1" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[93m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1416 && $RQMN != "QMEIS_PROD_DB_2" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1417 && $RQMN != "QM_CCSID_1208" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m"  ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[97m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $PORT -eq 1418 && $RQMN != "QMEIS_PROD_DB_3" ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Remote Queue and Listener Port are Mismatched  ]] \e[0m" ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[93m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[91m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[91m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                elif [[ $CHAN != $TRIV ]]
                  then
                    echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Channel and Trigdata are Mismatched  ]] \e[0m" ;echo
                    printf "\e[91m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[93m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[97m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[91m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[97m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                else
                    echo;echo -e "\e[92m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m";echo;
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[93m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[97m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[97m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo
                fi

            else
                STAT=`echo "DISPLAY CHS($CHAN)" |runmqsc $qm | sed "s/( )/()/g" | awk '{print $1,"\n"$2}'| grep STATUS | cut -d "(" -f2 | cut -d ")" -f1 `
                echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  Channel is in Stopped or Retrying or Binding state  ]] \e[0m" ;echo
                    printf "\e[97m$CHAN%"`echo "$((32-${#CHAN}))"`"s\e[0m";
                    printf "\e[91m$STAT%"`echo "$((32-${#STAT}))"`"s\e[0m";
                    printf "\e[97m$CONA%"`echo "$((32-${#CONA}))"`"s\e[0m";
                    printf "\e[97m$TRAQ%"`echo "$((32-${#TRAQ}))"`"s\e[0m";
                    printf "\e[97m$TRIG%"`echo "$((32-${#TRIG}))"`"s\e[0m";
                    printf "\e[97m$CURD%"`echo "$((32-${#CURD}))"`"s\e[0m";
                    printf "\e[97m$RQMN%"`echo "$((32-${#RQMN}))"`"s\e[0m";echo

             fi
        done
    else
        echo;echo -e "\e[91m[+] QUEUE MANAGER    >>>>>>>>>>>>>>>>>>    $qm\e[0m" |  tr -d "\n";echo -e "\e[93m      [[  $qm may be ended  ]] \e[0m";echo;
        fi
done
echo


