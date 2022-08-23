# kcal-counter-shell
A minimal set of simple shell scripts to utilize macronutrients tracking in your own sqlite database. The only dependencies are sqlite3 and rofi.

### Database structure:
![Zrzut ekranu z 2022-08-20 13-04-13](https://user-images.githubusercontent.com/85220613/185743286-95b046e1-c246-44ce-a648-6f6d9de01eda.png)

There are 2 main tables:

* **Food** - Table that contains the macronutrients reference per 100g of product.

* **diary** - Table that contains all food entries, everything that you have consumed through the day.

Additionaly there is:

* **food_servings** - Table that contains the reference to Food products, storing informations about size and name of particular serving (for example one bar of snickers)

And funny table: **colors** that was created just to color enhance the output.

### Usage:

Just run `init.sh` script first in order to set up the database

I'm too lazy to create one huge script to implement all interactions with database, so I splitted them into 5 small ones. Use them separately.

In order to add new product to your database, run `./new_product.sh` and enter values per 100g of product, and then if you want to bind the existing product with the serving run `./bind_product_with_serving.sh`

### Presentation:

**add**

[Nagranie ekranu z 20.08.2022 13:21:33.webm](https://user-images.githubusercontent.com/85220613/185743741-22c09ad3-4ed5-4049-a4a2-ca400164a55c.webm)

**delete_record**

[Nagranie ekranu z 20.08.2022 13:23:00.webm](https://user-images.githubusercontent.com/85220613/185743785-693f33c6-dee2-4f91-a492-3b1d53d76104.webm)

**summary**

![Zrzut ekranu z 2022-08-20 13-25-28](https://user-images.githubusercontent.com/85220613/185743835-33ae2bb1-efa5-4cc6-903e-1c4c3988d46c.png)
