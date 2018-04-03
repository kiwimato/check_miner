#!/bin/bash
# API link where we can get the data about the miner
# http://5b75d5.ethosdistro.com

#API_LINK="http://musicoin.nomnom.technology/api/accounts/0xe5b11910e14421d4fec22a6cbfae2d8bb2f31d25"
#STATSLINK="http://musicoin.nomnom.technology/#/account/0xe5b11910e14421d4fec22a6cbfae2d8bb2f31d25"
API_LINK="http://music.minerpool.net/api/accounts/0xe5b11910e14421d4fec22a6cbfae2d8bb2f31d25"
STATSLINK="http://music.minerpool.net/#/account/0xe5b11910e14421d4fec22a6cbfae2d8bb2f31d25"
ETHOS_LINK="http://5b75d5.ethosdistro.com/graphs/?rig=522b2e&type=fanrpm"

# e-mails to notify in case it's down
MAILTO="dub2sauce@gmail.com"
CCMAILTO="groza.vlad.mircea@gmail.com"
BODY="\n - $STATSLINK \n - rig panel: http://5b75d5.ethosdistro.com \n\n Have a nice one! ;)"


while [ 0 ];do
  curl -ks $API_LINK  | grep -q 'workersOnline":1' >> /tmp/debug.miner.log 2>&1
  if [ $? -ne 0 ];then
#    [[ ! -f /tmp/.fan ]] && echo -e "Alert,\n one or more FANs appear to be down $(date) \n $BODY" | mail -s 'One or more fans appear to be down' -c $CCMAILTO $MAILTO && echo "Fan down $(date)" >> /var/log/elastatus.log && 
    [[ ! -f /tmp/.down ]] && echo -e "Alert,\n Ella miner is DOWN $(date) \n $BODY" | mail -s "Ella miner is DOWN" -c $CCMAILTO $MAILTO && echo "Alert, Ella miner is down $(date) " >> /var/log/elastatus.log && touch /tmp/.down && echo "Miner is down $(date)"
  else
   [[ -f /tmp/.down ]] && rm -rf /tmp/.down &&  echo -e "Alert,\n Ella miner is UP $(date) \n $BODY" | mail -s "Ella miner is UP" $MAILTO -c $CCMAILTO && echo "Alert, Ella miner is UP $(date) " >> /var/log/elastatus.log && echo -n "Miner is UP $(date)"
  fi

# Check fan speed
#  curl -ks "$ETHOS_LINK" | grep "$( date +%s | cut -c 1-7 )"  | egrep -q "( [0-9][0-9][0-9]]| [0-9][0-9]]| [0-9]])"
#  if [ $? -eq 0 ];then
#    [[ ! -f /tmp/.fan ]] && touch /tmp/.fan && echo -e "Alert,\n one or more FANs appear to be down $(date) \n $BODY" | mail -s 'One or more fans appear to be down' -c $CCMAILTO $MAILTO && echo "Fan down $(date)" >> /var/log/elastatus.log && echo "Fan down $(date)"
#  else
#    [[ -f /tmp/.fan ]] && rm -rf /tmp/.fan &&  echo -e "Alert,\n FANs are UP $(date) \n $BODY" | mail -s "FANs are up again" -c $CCMAILTO $MAILTO && echo "Fans up$(date)" >> /var/log/elastatus.log && echo "Fan up $(date)"
#  fi
#  sleep 180
done
