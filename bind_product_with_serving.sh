#!/bin/sh
db=(./database.db)

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
	(select record from food where name='$food_name'),'$serving_name',$serving_size);" 2>/dev/null
exit_status=`echo $?`

	echo -en '\n'

if [ $exit_status -eq 0 ]; then
	echo -e "${green} successfully added serving for $(echo $food_name | sed "s/_/ /g")${blue}"
else
	echo -e "${red} failed to add serving${blue}"
fi

	echo -en '\n'
