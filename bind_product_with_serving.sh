#!/bin/sh
db=(/home/cyanos/projekty/kcalBot/Discord-Database-Bot/database.db)

#define_colors
white="\e[1;37m"
cyan="\e[1;36m"
blue="\e[1;34m"
red="\e[1;31m"
green="\e[1;32m"

#get_input
food_name=$(sqlite3 $db "select printf(\"%!10s               %s\",kcal || ' kcal',name) from food;" | rofi -dmenu -p "               CHOOSE PRODUCT:


kcal/100g                    nazwa: " -l 15 | awk '{print $3}' )

serving_name=$(echo "" | rofi -dmenu -p "ENTER SERVING NAME: 
[for example: 1sztuka]")

serving_size=$(echo "" | rofi -dmenu -p "ENTER SERVING SIZE:
[for example: 1.6]")

sqlite3 $db "insert into food_servings (reference_record, serving_name, serving_size) values( \
	(select record from food where name='$food_name'),'$serving_name',$serving_size);"
