# Capture Motion Getting started

* Ruby version => 2.6.3
* Database => Mysql

Steps to follow:
  
  * extract the zip file
  * run bundle install
  * run rake db:create
  * run rake db:migrate
  * run rake db:seed
  * run rails s

This is all to setup and run the application

# List of API's and required params:

* Register new user
  URL: /api/v1/signup
  Method: POST
  required params:
    {
      "user": {
        "app_id": "cd9bc54a7ef40322bc7526fb82b6135b5115fd62280fd88468ff3c2aef87",
        "app_secret": "694eba5d44815dad6dac12b3e74fef734fe53259887d3c7989edd034fc14",
        "name": "Your Name",
        "email": "yourEmail@domain.com",
        "password": "Your password",
        "mobile": "Your mobile number"
      }
    }

* Login into users account
  URL: /api/v1/login
  Method: POST
  required params:
    {
      "email": "yourEmail@domain.com",
      "password": "Your password",
      "app_id": "cd9bc54a7ef40322bc7526fb82b6135b5115fd62280fd88468ff3c2aef87",
      "app_secret": "694eba5d44815dad6dac12b3e74fef734fe53259887d3c7989edd034fc14"
    }

* Create new Category
  URL: /api/v1/categories
  Method: POST
  required params:
    {
      "category": {
        "name": "Nikon",
        "category_type": "Handy-36",
        "model": "2019"
      }
    }

* Show list of Categories
  URL: /api/v1/categories
  Method: GET

* Create new product
  URL: /api/v1/products
  Method: POST
  required params:
    {
      "product": {
        "name": "D3500",
        "category_id": 1,
        "description": "Hello nikon",
        "price": 53000.43,
        "make": "2019"
      }
    }

* Show list of products
  URL: /api/v1/products
  Method: GET

* Show list of product of a particular category
  URL: /api/v1/categories/:category_id/products
  Method: GET

* Add to cart
  URL: /api/v1/carts
  Method: POST
  Required params:
    {
      "product_id": 1,
      "quantity": 2
    }

* List of cart items of a particular user
  URL: /api/v1/carts
  Method: GET

# NOTE: Category and products api can only be accessible to admin user. You need to run rake db:seed it will automatically create admin user for you.
  admin user email: admin@capture_motions.com
  admin user password: admin
