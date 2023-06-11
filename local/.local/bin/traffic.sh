#!/bin/bash

#shows speed on the specified device
###CHECKS####
host=google.com

# get the ip of that host (works with dns and /etc/hosts. In case we get  
# multiple IP addresses, we just want one of them
host_ip=$(getent ahosts "$host" | awk '{print $1; exit}')
    
# only list the interface used to reach a specific host/IP. We only want the part
# between dev and the remainder (use grep for that)
INTERFACE=$(ip route get "$host_ip" | grep -Po '(?<= dev ).+?(?= (src|proto))')

# echo "$INTERFACE  down (KiB/s)   up (KiB/s)"
while :
do
  awk '{
  if (rx) {
    printf ("%.0f KB/s\n", ($2-rx)/1024)
  } else {
    rx=$2;
  }
}' \
    <(grep $INTERFACE /proc/net/dev) \
    <(sleep 1; grep $INTERFACE /proc/net/dev)
  sleep 2;
done

