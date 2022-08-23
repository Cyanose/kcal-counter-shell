#!/bin/sh
db=(./database.db)

#define_colors
white="\e[1;37m"
cyan="\e[1;36m"
blue="\e[1;34m"
red="\e[1;31m"
green="\e[1;32m"

#use underscore_case BECAUSE it's better!
name=$(echo "" | rofi -dmenu -p "ENTER PRODUCT_NAME: 
[for example: frytki_kfc]")

kcal=$(echo "" | rofi -dmenu -p "ENTER KCAL /100g:
[for example: 389]")

fats=$(echo "" | rofi -dmenu -p "ENTER FATS /100g:
[for example: 8.2]")

carbs=$(echo "" | rofi -dmenu -p "ENTER CARBS /100g:
[for example: 66.2]")

proteins=$(echo "" | rofi -dmenu -p "ENTER PROTEINS /100g:
[for example: 9.8]")

sqlite3 $db "insert into food (name, kcal, carbs, proteins, fats) VALUES ('$name', $kcal, $carbs, $proteins, $fats);" 2>/dev/null
exit_status=`echo $?`

	echo -en '\n'

if [ $exit_status -eq 0 ]; then
	echo -e "${green} $(echo $name | sed "s/_/ /g") successfully added ${blue}"
else
	echo -e "${red} failed to add food${blue}"
fi

	echo -en '\n'
