#!/bin/sh
db=(../Discord-Database-Bot/database.db)
echo "Enter in the product name: "
read name
echo "Enter in kcal per 100g: "
read kcal
echo "Enter in fats per 100g: "
read fats
echo "Enter in carbs per 100g: "
read carbs
echo "Enter in proteins per 100g: "
read proteins
sqlite3 $db "insert into food (name, kcal, carbs, proteins, fats) VALUES ('$name', $kcal, $carbs, $proteins, $fats);"
