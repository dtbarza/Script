#!/bin/bash
cat /etc/group | awk -F: '$4 > 0 {printf "%s: %s\n", $1, $4} $4 < 1 {printf "%s: %s\n", $1, "vacío"}' 
sleep 10
