#!/bin/sh
db=(./database.db)
today=$(date +"%Y-%m-%d")
#declare colors
white="\e[1;37m"
cyan="\e[1;36m"
blue="\e[1;34m"
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"

choice=$(sqlite3 $db "select printf('%i %s %ig', record, name, amount*100) from diary where day = '$today';" | rofi -dmenu -p "select record: " -l 25) 
record=$(echo $choice | awk '{printf $1}')
sqlite3 $db "delete from diary where record = $record;" 2>/dev/null
exit_status=$?

echo -en '\n'
if [ $exit_status -eq 0 ]; then
	echo -e "${green} `printf '%s %s\n' $(echo $choice | awk '{printf $2}') 'was successfully deleted.'` ${white}"
else
	echo -e "${red} failed to delete any food${white}"
fi

#Display the macronutients intake for this day
values=($(sqlite3 $db "select printf ('%.2f %.2f %.2f %.2f',
	sum(kcal), sum(carbs), sum(proteins), sum(fats))
	from diary where day='$today';"))
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
