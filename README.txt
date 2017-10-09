System cart API's


1. Register User
	POST localhost:3000/api/v1/users/sign_up

	params
		email
		password
		password_confirmation

	Success Response:
		200 OK
		{
			message: 'Thank you for registration, please sign in to continue'
		}

	Error Response:
		422 unprocessable entity


2. Sign in user
	POST localhost:3000/api/v1/users/sign_in

	params
		email
		passowrd

	Success Response:
		200 OK
		Return user with email and auth token

	Error Response:
		422 unprocessable entity
		{
			message: 'Could not set auth token'
		}

		404 not found
		{
			message: 'User not found'
		}

		403 access forbidden
		{
			message: 'User credentails are not valid'
		}


3. Sign out user
	DELETE localhost:3000/api/v1/users/sign_out

	Success Response:
		200 OK
		{
			message: 'sign out successfully'
		}

	Error Response:
		422 unprocessable entity
		{
			message: 'Sorry, could not sign out'
		}

4. Get List of all the products
	GET localhost:3000/api/v1/products

	Success Response:
		200 OK
		Return All the products with details
		[
	    {
	        "name": "product-1",
	        "price": "30.0",
	        "quantity": 20
	    },
	    {
	        "name": "product-2",
	        "price": "20.0",
	        "quantity": 50
	    }
		]

		204 no content
		return if no products available in list


5. To add product to cart
	POST localhost:3000/api/v1/cart_items

	params : 
		provider_id

	Success response :
		200 OK
		Return the cart with product added
		{
		    "id": 1,
		    "cart_items": [
		        {
		            "id": 1,
		            "quantity": 1,
		            "product_name": "product-1",
		            "price": "30.0",
		            "total_price": "30.0"
		        }
		    ],
		    "user_email": "user@gmail.com",
		    "total_amount": "30.0"
		}

	Error Response :
		404 not found
		{
		"message": "Product not found" 
		}


6. Update quantity of the cart item.
	PUT localhost:3000/api/v1/cart_items/:id

	params:
		quantity

	Success Response:
		200 OK
		Return cart with updated quantity of cart item
		{
	    "id": 3,
	    "cart_items": [
	        {
	            "id": 6,
	            "quantity": 10,
	            "product_name": "product-1",
	            "price": "30.0",
	            "total_price": "300.0"
	        }
	    ],
	    "user_email": "user@gmail.com",
	    "total_amount": "300.0"
		}

	Error Response:
		404 Not found
		{
			message: 'Cart item not found'
		}

		422 unprocessable entity
		{
			message: 'sorry, could not update cart item quantity'
		}


7. Remove cart item from cart
	DELETE localhost:3000/api/v1/cart_items/:id

	Success Response :
		200 OK
		Return cart with other cart items
		{
	    "id": 3,
	    "cart_items": [
	        {
	            "id": 6,
	            "quantity": 10,
	            "product_name": "product-1",
	            "price": "30.0",
	            "total_price": "300.0"
	        }
	    ],
	    "user_email": "user@gmail.com",
	    "total_amount": "300.0"
		}

	Error Response:
		404 Not found
		{
			message: 'Cart item not found'
		}

		422 unprocessable entity
		{
			message: 'Sorry, could not removed cart item from cart'
		}


8. Get cart info
	GET localhost:3000/api/v1/carts/:id

	Success Response:
		200 OK
		Return cart with details of items
		{
	    "id": 3,
	    "cart_items": [
	        {
	            "id": 6,
	            "quantity": 10,
	            "product_name": "product-1",
	            "price": "30.0",
	            "total_price": "300.0"
	        }
	    ],
	    "user_email": "user@gmail.com",
	    "total_amount": "300.0"
		}

9. Get Cart system info
	GET localhost:3000/api/v1/carts

	Success Response:
		200 OK
		Return details of all the items added in the cart


10. Get order details
	GET localhost:3000/api/v1/orders

	Success Response:
		200 OK
		Return all orders of the user
		[
	    {
	        "id": 1,
	        "order_items": [
	            {
	                "id": 1,
	                "quantity": 1,
	                "product_name": "product-1",
	                "price": "30.0",
	                "total_price": "10.0"
	            },
	            {
	                "id": 2,
	                "quantity": 3,
	                "product_name": "product-2",
	                "price": "20.0",
	                "total_price": "60.0"
	            }
	        ],
	        "total_amount": "70.0"
	    },
	    {
	        "id": 2,
	        "order_items": [
	            {
	                "id": 3,
	                "quantity": 6,
	                "product_name": "product-1",
	                "price": "30.0",
	                "total_price": "180.0"
	            }
	        ],
	        "total_amount": "180.0"
	    }
	]

11. Create order
	POST localhost:3000/api/v1/orders

	Success Response:
		200 OK
		Create order from cart items
		{
			message: 'Thanks, your order placed successfully'
		}

		422 unprocessable entity
		{
			message: 'Sorry, could not place order'
		} 