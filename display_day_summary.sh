#!/bin/sh
db=(/home/cyanos/projekty/kcalBot/Discord-Database-Bot/database.db)
date=$(date +"%Y-%m-%d")

#declare colors
white="\e[1;37m"
cyan="\e[1;36m"
blue="\e[1;34m"
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"

echo -en '\n'
echo -e "${green} Records from $date: ${white} "
echo -en '\n'
sqlite3 $db "select printf (' %s %.1f g %s %.1f kcal %s',\
	(select printf(fmt,name) from colors where color='cyan'),\
	sum(amount*100),\
	char(10),\
	kcal,\
	char(10))\
	from diary where day='$date'\
	group by name;"

#Display the macronutients intake for this day
values=($(sqlite3 $db "select printf ('%.2f %.2f %.2f %.2f',
	sum(kcal), sum(carbs), sum(proteins), sum(fats))
	from diary where day='$date';"))
kcal=${values[0]} 
carbs=${values[1]} 
proteins=${values[2]} 
fats=${values[3]} 

echo " ---------------------------------------"
echo -e " ${cyan}Your macronutients intake for this day:"
echo -e " ${white}kcal     :  ${blue}$kcal"
echo -e " ${white}carbs    :  ${blue}$carbs"
echo -e " ${white}proteins :  ${blue}$proteins"
echo -e " ${white}fats     :  ${blue}$fats"
echo -en '\n'
