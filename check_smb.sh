#!/bin/bash

nmap -p 139,445 --open -iL "$1" -oG - | awk '/139\/open/ || /445\/open/ {print $2}' | sort -u > smb.txt

nmap -p 139,445 --script smb-vuln-* -iL smb.txt
