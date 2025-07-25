#!/bin/bash

mkdir -p ~/tools
cd ~/tools/

mkdir -p ~/tools/peas

git clone https://github.com/ShutdownRepo/targetedKerberoast.git
curl -s https://api.github.com/repos/peass-ng/PEASS-ng/releases/latest \
	| grep "browser_download_url.*linpeas.sh" \
	| cut -d: -f 2,3 \
	| tr -d ' "' \
	| wget -qi - -O ~/tools/peas/linpeas.sh
curl -s https://api.github.com/repos/peass-ng/PEASS-ng/releases/latest \
	| grep "browser_download_url.*winPEASx64.exe" \
	| cut -d: -f 2,3 \
	| tr -d ' "' \
	| wget -qi - -O ~/tools/peas/winPEASx64.exe
