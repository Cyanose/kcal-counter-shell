#!/bin/sh
db=(/home/cyanos/projekty/kcalBot/Discord-Database-Bot/database.db)
today=$(date +"%Y-%m-%d")

#define_colors
white="\e[1;37m"
cyan="\e[1;36m"
blue="\e[1;34m"
red="\e[1;31m"
green="\e[1;32m"

#get_input
name=$(sqlite3 $db "select printf(\"%!10s               %s\",kcal || ' kcal',name) from food;" | rofi -dmenu -p "               CHOOSE PRODUCT:


kcal/100g                    nazwa: " -l 15 | awk '{print $3}' )

amount=$(sqlite3 $db "select printf('%.2f               %s', serving_size, serving_name) from food_servings where reference_record=(select record from food where name='$name');" | rofi -dmenu -p "enter amount [for example: 1.6]:" | awk '{print $1}')

#process_data
values=($(sqlite3 $db "select printf('%.2f %.2f %.2f %.2f',
	kcal*$amount,carbs*$amount, proteins*$amount, fats*$amount)
	from food where name='$name';" 2>/dev/null))

kcal=${values[0]}
carbs=${values[1]}
proteins=${values[2]}
fats=${values[3]}

#insert_data_into_diary
sqlite3 $db "insert into diary (day,amount,name,kcal,carbs,proteins,fats) values('${today}',$amount,'${name}',$kcal,$carbs,$proteins,$fats);" 2>/dev/null 
exit_status=`echo $?`

#get_data_for_summary
values=($(sqlite3 $db "select printf ('%.2f %.2f %.2f %.2f',
	sum(kcal), sum(carbs), sum(proteins), sum(fats))
	from diary where day='$today';"))
kcal=${values[0]} 
carbs=${values[1]} 
proteins=${values[2]} 
fats=${values[3]} 

#print summary
if [ $exit_status -eq 0 ]; then
	echo -en '\n'
	echo -e "${green} $(echo $name | sed "s/_/ /g") successfully added ${blue}"
else
	echo -en '\n'
	echo -e "${red} failed to add food${blue}"
fi

echo " ---------------------------------------"
echo -e " ${cyan}Your macronutients intake for this day:"
echo -e " ${white}kcal     : ${blue}$kcal"
echo -e " ${white}carbs    : ${blue}$carbs"
echo -e " ${white}proteins : ${blue}$proteins"
echo -e " ${white}fats     : ${blue}$fats"
echo -en '\n'
