#!/bin/bash

walldir="$HOME/Pictures/Wallpapers/wallhaven"
mkdir -p "$walldir"

maxpage=5

tagoptions=("minimalism"  "Cyberpunk 2077"  "fantasy girl"  "digital art"  "anime"  "4K"  "nature" "League of Legends")
echo "Available tag options: "

for i in "${!tagoptions[@]}"
do
  echo "${i}." "${tagoptions[$i]}"
done

echo ""

read -p "Select a tag number: " tag

query=$(echo "${tagoptions[$tag]}" | sed 's/ /%20/g')
echo $query
echo ""

sortoptions=("date_added" "relevance" "random" "views" "favorites" "toplist")
echo "Available sorting options: "

for i in "${!sortoptions[@]}"
do
  echo "${i}." "${sortoptions[$i]}"
done

echo ""

read -p "Sort by: " sorting

sorting="${sortoptions[$sorting]}"
echo "${sorting}" 


notify-send "⬇️ Downloading wallpapers 🖼️"

for i in $(seq 1 5);
do
  curl -s https://wallhaven.cc/api/v1/search\?atleast\=1920x1080\&sorting\=$sorting\&q\=$query\&page\=$i > wall_temp.txt
  page=$(cat wall_temp.txt | jq -r '.data | .[] | .path')
  wget -nc -P $walldir $page  
done

rm wall_temp.txt
notify-send "😊 Download finish ✅"
sxiv -tp $walldir
