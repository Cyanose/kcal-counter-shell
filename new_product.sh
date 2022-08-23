#!/bin/sh
db=(./database.db)

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

sqlite3 $db "insert into food (name, kcal, carbs, proteins, fats) VALUES ('$name', $kcal, $carbs, $proteins, $fats);"
