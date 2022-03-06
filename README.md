# CookBook App

This is a simple prototype of CookBook app. Right now it only consists of basic functionalities, and recipes are in English.

PostgreSQL database is used for this project. Database consists of 3 tables: categories, recipes, ingredients, the associations are established:
Category has_many :recipes

Recipe belongs_to :categories
Recipe has_many :ingredients

Ingredient belongs_to :recipe

This app is hosted on heroku: https://amird-cookbook.herokuapp.com/

The JSON file is huge with 10000 recipes, so I decided to reduce it to be able to host it on heroku free tier. 

Right now, this app looks better on desktop browser, and user can:

* Browse recipes using the pagination 

* View a recipe by clicking on either title, image or 'continue reading' link on index page

* Click on category, to display recipes belonging to that category (category link is displayed above title on index page, and at the bottom on show page)

* Search recipes by ingredients, search box is provided in header

* There are some recipes with category="", so I created a "Not categorized" option for such recipes


