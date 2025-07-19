#!/bin/bash
grep -E '.+[a-fA-f0-9]{32}:[a-fA-f0-9]{32}.+' "$1" > clean.txt

hashcat -m 1000 clean.txt "$2" --quiet 
hashcat -m 1000 clean.txt "$2" --show | grep -E '^[a-fA-F0-9]{32}:' > cracked.txt

declare -a usernames
declare -a passwords

while IFS=':' read -r hash password; do
	if [ ! -z "$password" ]; then
		username=$(grep "$hash" clean.txt | cut -d: -f1)
		usernames+=("$username")
		passwords+=("$password")
	fi
done < cracked.txt

if [ -f 'usernames.txt' ]; then
	rm usernames.txt
fi
if [ -f 'passwords.txt' ]; then
	rm passwords.txt
fi
if [ -f 'userpass.txt' ]; then
	rm userpass.txt
fi

rm cracked.txt

for i in "${!usernames[@]}"; do
	echo "${usernames[i]}" >> usernames.txt 
	echo "${passwords[i]}" >> passwords.txt
	echo "${usernames[i]}:${passwords[i]}" >> userpass.txt
done

