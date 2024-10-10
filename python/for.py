integers = [1, 2, 3, 4, 5]

for number in integers:
    print(number)

ice_cream_dict = {
    "name": "Alex Freberg",
    "weekly intake": 5,
    "favorite ice cream": [
        "Chocolate",
        "Strawberry",
    ],
}

for key, value in ice_cream_dict.items():
    print(key, "=>", value)

flavors = ["Vanilla", "Chocolate", "Pistachio"]
toppings = ["Hot fudge", "Oreos", "Marshmallows"]

for flavor in flavors:
    for topping in toppings:
        print(flavor, "topped with", topping)
