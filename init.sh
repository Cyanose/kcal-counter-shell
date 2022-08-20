#!/bin/sh

if [ -f ./database.db ]; then 
	sqlite3 database.db "DELETE FROM diary;"
else
	sqlite3 database.db "CREATE TABLE food (record INTEGER PRIMARY KEY AUTOINCREMENT, \
						name text, \
						kcal REAL DEFAULT 0, \
						carbs REAL DEFAULT 0, \
						proteins REAL DEFAULT 0, \
						fats REAL DEFAULT 0);"

	sqlite3 database.db "CREATE TABLE diary (record INTEGER PRIMARY KEY AUTOINCREMENT, \
						 day TEXT, \
						 amount REAL, \
						 name TEXT, \
						 kcal REAL, \
						 carbs REAL, \
						 proteins REAL, \
						 fats REAL);"

	sqlite3 database.db "CREATE TABLE food_servings (own_record INTEGER PRIMARY KEY AUTOINCREMENT, \
							 reference_record INTEGER, \
							 serving_name TEXT, \
							 serving_size REAL DEFAULT 0, \
							 FOREIGN KEY(reference_record) REFERENCES food(record));"

	sqlite3 database.db "CREATE TABLE colors (color TEXT, n INT, fmt TEXT);"
fi
