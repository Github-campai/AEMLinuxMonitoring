#!/bin/bash

#Vanuit AEM wordt de variabele $CHECK direct ingevuld met de argumenten opgegeven op de webpage

OS=$(cat /etc/os-release | awk -F= '/^NAME/{print $2}' | sed 's/\"//g') #Controleer welke OS er wordt gebruikt
KERNEL=$(cat /etc/os-release | awk -F= '/^ID_LIKE/{print $2}' | sed 's/\"//g') #Controleer welke distrobutie wordt gebruikt
CMNDUTE="I= Kan commando niet uitvoeren, juiste distro?" #Wanneer het commando niet uitgevoerd kan worden door een distrobutie error wordt dat weergegeven.
LOGDIR="/var/log/aem/" #Locatie van de logfiles voor de script
LOGFILE="monitorscript.log" #Locatie van de logfile vanuit variabele $LOGDIR
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S -"` #1970-01-01 00:00:00 -
USER=$(whoami) #Wie ben ik (bijv. door wie wordt het script gerund)
HOSTNAME="$HOSTNAME" #Zet hostname van de host in als variabele
[ ! -d "$LOGDIR" ] && mkdir -p "$LOGDIR" #check of de logfiles locatie bestaat, zo niet, maken we de map aan.
echo "$TIMESTAMP Script geïnitieerd als user '"$USER"' met argument '"$CHECK"'" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile

if [[ $# -eq 1 ]] ; then
    CHECK=""
    CHECK=$1
fi

# Check Updates
if [ "$CHECK" = "updates" ]; then
    if [ "$KERNEL" = "rhel fedora" ]; then
        PACKAGESUPD=$(yum list updates | wc -l)
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $PACKAGESUPD updates beschikbaar"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $PACKAGESUPD updates beschikbaar" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    elif [ "$KERNEL" = "debian" ]; then
        PACKAGESUPD=$(/usr/lib/update-notifier/apt-check --human-readable | awk 'NR==1{print $1}')
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $PACKAGESUPD updates beschikbaar"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $PACKAGESUPD updates beschikbaar" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Check TCP Sockets
elif [ "$CHECK" = "tcpsockets" ]; then
    if [ "$KERNEL" = "rhel fedora" ]; then
        TCPSOCKETS=$(ss -s | awk 'NR==1{print $2}')
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $TCPSOCKETS Sockets in gebruik"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $TCPSOCKETS in gebruik" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    elif [ "$KERNEL" = "debian" ]; then
        TCPSOCKETS=$(ss -s | awk 'NR==1{print $2}')
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $TCPSOCKETS Sockets in gebruik"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $TCPSOCKETS in gebruik" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Check Zombie Processes
elif [ "$CHECK" = "zombie" ]; then
    if [ "$KERNEL" = "rhel fedora" ]; then
        ZOMBIE=$(ps aux | grep 'Z' |tail -n +3 | wc -l)
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $ZOMBIE Zombie processen"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $ZOMBIE Zombie processen" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    elif [ "$KERNEL" = "debian" ]; then
        ZOMBIE=$(ps aux | grep 'Z' |tail -n +3 | wc -l)
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $ZOMBIE Zombie Processen"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $ZOMBIE Zombie processen" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Check Number Of Processes
elif [ "$CHECK" = "process" ]; then
    if [ "$KERNEL" = "rhel fedora" ]; then
        PROCESS=$(ps aux | wc -l)
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $PROCESS Processen"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $PROCESS processen" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    elif [ "$KERNEL" = "debian" ]; then
        PROCESS=$(ps aux | wc -l)
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $PROCESS Processen"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $PROCESS processen" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Average Load last 5 minutes
elif [ "$CHECK" = "load5min" ]; then
    if [ "$KERNEL" = "rhel fedora" ]; then
        LOAD=$(cat /proc/loadavg | awk '{print $2}')
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $LOAD Load"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $LOAD Load afgelopen 5 minuten" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    elif [ "$KERNEL" = "debian" ]; then
        LOAD=$(cat /proc/loadavg | awk '{print $2}')
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $LOAD Load"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $LOAD Load afgelopen 5 minuten" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Check MySQL slave count
elif [ "$CHECK" = "mysqlslave" ]; then
    if [ "$KERNEL" = "rhel fedora" ]; then
        MYSQLSLAVE=$(mysql -u root -e "SHOW SLAVE HOSTS;" | tail -n +2 | wc -l)
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $MYSQLSLAVE Slaves"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $MYSQLSLAVE Slaves" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    elif [ "$KERNEL" = "debian" ]; then
        MYSQLSLAVE=$(mysql -u root -e "SHOW SLAVE HOSTS;" | tail -n +2 | wc -l)
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= $MYSQLSLAVE Slaves"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: $MYSQLSLAVE Slaves" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 0 #Geef aan AEM door dat er geen fouten zijn
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Free Swap
elif [ "$CHECK" = "swap" ]; then
    SWAP=$(swapon --show | tail -n +2 | wc -l)
    if [ $SWAP -gt 0 ]; then
        if [ "$KERNEL" = "rhel fedora" ]; then
            SWAPFREE=$(grep SwapFree /proc/meminfo | awk '{print $2/1024/1024 " GB"}')
            echo "<-Start Result->" #Begin AEM resultaat
            echo "I= $SWAPFREE swap vrij"
            echo "<-End Result->" #Eindig AEM resultaat
            echo "$TIMESTAMP Resultaat: $SWAPFREE Swap vrij" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
            exit 0 #Geef aan AEM door dat er geen fouten zijn
        elif [ "$KERNEL" = "debian" ]; then
            SWAPFREE=$(grep SwapFree /proc/meminfo | awk '{print $2/1024/1024 " GB"}')
            echo "<-Start Result->" #Begin AEM resultaat
            echo "I= $SWAPFREE swap vrij"
            echo "<-End Result->" #Eindig AEM resultaat
            echo "$TIMESTAMP Resultaat: $SWAPFREE Swap vrij" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
            exit 0 #Geef aan AEM door dat er geen fouten zijn
        fi
    elif [ $SWAP -eq 0 ]; then
        echo "<-Start Result->" #Begin AEM resultaat
        echo "I= Swap niet enabled"
        echo "<-End Result->" #Eindig AEM resultaat
        echo "$TIMESTAMP Resultaat: Swap niet enabled (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
        exit 1 #Geef aan AEM door dat er geen fouten zijn
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Check opgegeven Service d.m.v. SERVICE:(servicename)
elif [[ $CHECK =~ SERVICE ]]; then #Checken of de argument "SERVICE" bevat
    SERVICE=$(sed 's/SERVICE://g' <<< $CHECK) #SERVICE: verwijderen zodat alleen de service naam overblijft.
    if [ "$KERNEL" = "rhel fedora" ]; then
        STATUS="$(systemctl status $SERVICE | grep Active | awk '{print $2}')"
            if [ "${STATUS}" = "active" ]; then
                echo "<-Start Result->" #Begin AEM resultaat
                echo "I= $SERVICE is actief"
                echo "<-End Result->" #Eindig AEM resultaat
                echo "$TIMESTAMP Resultaat: $SERVICE is actief" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                exit 0 #Geef aan AEM door dat er geen fouten zijn
            else
                echo "<-Start Result->" #Begin AEM resultaat
                echo "I= $SERVICE is niet actief"
                echo "<-End Result->" #Eindig AEM resultaat
                echo "$TIMESTAMP Resultaat: $SERVICE is niet actief (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                exit 1 #Geef aan AEM door dat er een error is op zijn request
            fi
    elif [ "$KERNEL" = "debian" ]; then
        STATUS="$(systemctl is-active $SERVICE)"
            if [ "${STATUS}" = "active" ]; then
                echo "<-Start Result->" #Begin AEM resultaat
                echo "I= $SERVICE is actief"
                echo "<-End Result->" #Eindig AEM resultaat
                echo "$TIMESTAMP Resultaat: $SERVICE is actief" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                exit 0 #Geef aan AEM door dat er geen fouten zijn
            else
                echo "<-Start Result->" #Begin AEM resultaat
                echo "I= $SERVICE is niet actief"
                echo "<-End Result->" #Eindig AEM resultaat
                echo "$TIMESTAMP Resultaat: $SERVICE is niet actief (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                exit 1 #Geef aan AEM door dat er een error is op zijn request
            fi
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
#Check Gluster d.m.v. GLUSTER:(commando)
elif [[ $CHECK =~ GLUSTER ]]; then #Checken of de argument "GLUSTER" bevat
    GLUSTER=$(echo $CHECK | awk -F: '{print $2}') #Checken wat het argument is (nodes,split,throughput)
    VOLUME=$(echo $CHECK | awk -F: '{print $3}') #In geval van throughput, wordt hiervandaan de volume naam gehaald
    if [ "$KERNEL" = "rhel fedora" ]; then
        if [ "$GLUSTER" == "nodes" ]; then #Als het argument "nodes" is, ga hier verder
            if [ "$GLUSTER" == "nodes" ]; then
                NODES="$(gluster peer status | grep '(Connected)' | wc | awk '{print $1}')"
                if [ -z "$NODES" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan nodes niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan nodes niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                elif [ "$NODES" -le "1" ]; then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $NODES Node verbonden"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $NODES verbonden" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er geen fouten zijn
                elif [ "$NODES" -ge "2" ]; then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $NODES Nodes verbonden"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $NODES verbonden" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
        if [ "$GLUSTER" == "split" ]; then #Als het argument "split" is, ga hier verder
            if [ "$GLUSTER" == "split" ]; then
                SPLIT="$(gluster volume heal $VOLUME info split-brain  | grep -A2 $HOSTNAME | grep split-brain | cut -d ' ' -f 6)"
                if [ -z "$SPLIT" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan niet ophalen of er files in Split-Brain zijn"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan niet ophalen of er files in Split-Brain zijn (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $SPLIT files in Split-Brain"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $SPLIT files in Split-Brain" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
        if [ "$GLUSTER" == "throughput" ]; then #Als het argument "throughput" is, ga hier verder
            if [ "$GLUSTER" == "throughput" ]; then
                THROUGHPUT="$(gluster volume top $VOLUME read-perf bs 2014 count 1024 | grep -A1 $HOSTNAME | grep Throughput | cut -d ' ' -f 2)"
                if [ -z "$THROUGHPUT" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan throughput niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan throughput niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $THROUGHPUT Mb/s throughput op $HOSTNAME"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $THROUGHPUT Mb/s throughput op $HOSTNAME" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
    elif [ "$KERNEL" = "debian" ]; then
        if [ "$GLUSTER" == "nodes" ]; then #Als het argument "nodes" is, ga hier verder
            if [ "$GLUSTER" == "nodes" ]; then
                NODES="$(gluster peer status | grep '(Connected)' | wc | awk '{print $1}')"
                if [ -z "$NODES" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan nodes niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan nodes niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                elif [ "$NODES" -le "1" ]; then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $NODES Node(s) verbonden"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $NODES verbonden (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er geen fouten zijn
                elif [ "$NODES" -ge "2" ]; then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $NODES Nodes verbonden"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $NODES verbonden" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
        if [ "$GLUSTER" == "split" ]; then #Als het argument "split" is, ga hier verder
            if [ "$GLUSTER" == "split" ]; then
                SPLIT="$(gluster volume heal $VOLUME info split-brain  | grep -A2 $HOSTNAME | grep split-brain | cut -d ' ' -f 6)"
                if [ -z "$SPLIT" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan niet ophalen of er files in Split-Brain zijn"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan niet ophalen of er files in Split-Brain zijn (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $SPLIT files in Split-Brain"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $SPLIT files in Split-Brain" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
        if [ "$GLUSTER" == "throughput" ]; then #Als het argument "throughput" is, ga hier verder
            if [ "$GLUSTER" == "throughput" ]; then
                THROUGHPUT="$(gluster volume top $VOLUME read-perf bs 2014 count 1024 | grep -A1 $HOSTNAME | grep Throughput | cut -d ' ' -f 2)"
                if [ -z "$THROUGHPUT" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan throughput niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan throughput niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $THROUGHPUT Mb/s throughput op $HOSTNAME"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $THROUGHPUT Mb/s throughput op $HOSTNAME" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
    elif [[ $CHECK =~ REDIS ]]; then #Checken of de argument "GLUSTER" bevat
        REDIS=$(echo $CHECK | awk -F: '{print $2}') #Checken wat het argument is (nodes,split,throughput)
     if [ "$KERNEL" = "debian" ]; then
        if [ "$REDIS" == "ROLE" ]; then #Als het argument "split" is, ga hier verder
            if [ "$REDIS" == "ROLE" ]; then

                if [ -z "$ROLE" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    count=1
                    for ports in $( ps aux | grep redis-server | grep cluster | cut -d ':' -f 4 | cut -c 1-4 ); do
                        eval "var$count=$ports";
                        count=$((count+1));
                        CURRENT=${ports[@]}
                        STATUS=$(redis-cli -p $CURRENT INFO | grep role | cut -d ':' -f2)
                        OUTPUT=${CURRENT}=${STATUS}
                        printf "Port:$OUTPUT"
                    printf "\n"
                    done
                    echo "<-End Result->" #Eindig AEM resultaat
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan nodes/masters niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan throughput niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                fi
            fi
        fi
        if [ "$GLUSTER" == "throughput" ]; then #Als het argument "throughput" is, ga hier verder
            if [ "$GLUSTER" == "throughput" ]; then
                THROUGHPUT="$(gluster volume top $VOLUME read-perf bs 2014 count 1024 | grep -A1 $HOSTNAME | grep Throughput | cut -d ' ' -f 2)"
                if [ -z "$THROUGHPUT" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan throughput niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan throughput niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $THROUGHPUT Mb/s throughput op $HOSTNAME"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $THROUGHPUT Mb/s throughput op $HOSTNAME" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
    elif [ "$KERNEL" = "rhel fedora" ]; then
        if [ "$GLUSTER" == "nodes" ]; then #Als het argument "nodes" is, ga hier verder
            if [ "$GLUSTER" == "nodes" ]; then
                NODES="$(gluster peer status | grep '(Connected)' | wc | awk '{print $1}')"
                if [ -z "$NODES" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan nodes niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan nodes niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                elif [ "$NODES" -le "1" ]; then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $NODES Node(s) verbonden"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $NODES verbonden (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er geen fouten zijn
                elif [ "$NODES" -ge "2" ]; then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $NODES Nodes verbonden"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $NODES verbonden" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
        if [ "$GLUSTER" == "split" ]; then #Als het argument "split" is, ga hier verder
            if [ "$GLUSTER" == "split" ]; then
                SPLIT="$(gluster volume heal $VOLUME info split-brain  | grep -A2 $HOSTNAME | grep split-brain | cut -d ' ' -f 6)"
                if [ -z "$SPLIT" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan niet ophalen of er files in Split-Brain zijn"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan niet ophalen of er files in Split-Brain zijn (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $SPLIT files in Split-Brain"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $SPLIT files in Split-Brain" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
        if [ "$GLUSTER" == "throughput" ]; then #Als het argument "throughput" is, ga hier verder
            if [ "$GLUSTER" == "throughput" ]; then
                THROUGHPUT="$(gluster volume top $VOLUME read-perf bs 2014 count 1024 | grep -A1 $HOSTNAME | grep Throughput | cut -d ' ' -f 2)"
                if [ -z "$THROUGHPUT" ];
                then
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= Kan throughput niet ophalen"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: Kan throughput niet ophalen (exit code 1)" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 1 #Geef aan AEM door dat er een error is op zijn request
                else
                    echo "<-Start Result->" #Begin AEM resultaat
                    echo "I= $THROUGHPUT Mb/s throughput op $HOSTNAME"
                    echo "<-End Result->" #Eindig AEM resultaat
                    echo "$TIMESTAMP Resultaat: $THROUGHPUT Mb/s throughput op $HOSTNAME" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
                    exit 0 #Geef aan AEM door dat er geen fouten zijn
                fi
            fi
        fi
    else
        echo "<-Start Result->" #Begin AEM resultaat
        echo "$CMNDUTE"
        echo "<-End Result->" #Eindig AEM resultaat
        exit 1 #Geef aan AEM door dat er een error is op zijn request
fi
else
    echo "<-Start Result->" #Begin AEM resultaat
    echo "Geen juiste check opgegeven"
    echo "<-End Result->" #Eindig AEM resultaat
    echo "$TIMESTAMP Geen juiste check opgegeven" >> $LOGDIR$LOGFILE # Schrijf uitkomst ook naar logfile
    exit 1 #Geef aan AEM door dat er een error is op zijn request

fi