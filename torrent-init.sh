#!/bin/bash
set -e

# Download and extract VueTorrent to the web directory
cd /config/qBittorrent
wget -O vuetorrent.zip https://github.com/VueTorrent/VueTorrent/releases/download/v2.30.0/vuetorrent.zip
unzip -o vuetorrent.zip
rm vuetorrent.zip