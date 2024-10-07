# Numbers
# int is a whole number
print(type(12))

# float is a fractional number
print(type(10.25))

# complex is a imaginary number
print(type(10j))

# Booleans
# bool can be True or False
print(type(True))

# String is a collection of characters
# we can use single quote
single = "Single Quote"
print(type(single))

# we can use double quote
double = "Double Quote"
print(type(double))

# or tripe quote
triple = """
The ice cream vanquished
my longing for sweets,
upon this diet I look away,
it no loger exists on this day.
"""
print(type(triple))

print(single)
print(double)
print(triple)

# substrings
a = "Hello World"

# take position 0 to 5
print(a[:5])

# take the 3 last characters
print(a[-3:])

# take the character at position 6
print(a[6])

# take the characters from position 2 to position 7
print(a[2:7])

# we can multiply strings
print(a * 3)

# Lists
# we can have list of numbers
a = [1, 2, 3]
print(a)

# we can have list of strings
a = ["Cookie", "Chocolate", "Milk"]
print(a)

# or a mix and match of types, event a list inside a list
a = ["Cookie", 3, ["Milk", "Coffee"], False]
print(a)

# we can add itens to a list with append
ice_creams = ["Cookie Dough", "Strawberry", "Chocolate"]
ice_creams.append("Salted Caramel")
print(ice_creams)

# we can change itens in a list
ice_creams[0] = "Butter Pecan"
print(ice_creams)

# we can access itens in a list trhough index
print(ice_creams[0])

# we can access itens in a nested list trhough index
nested_list = ["Cookie", 3, ["Milk", "Coffee"], False]
print(nested_list[2][0])

# Tuple
# there are similar to Lists, but can not be changed
tuple_scoops = (1, 2, 3, 2, 1)
print(type(tuple_scoops))
print(tuple_scoops)

# Sets
# there are similar to List, but can not have duplicates
# and can not be accessed trhough index
daily_pints_log = {1, 2, 2, 3, 1, 21, 33, 6}
print(type(daily_pints_log))
print(daily_pints_log)

wife_daily_pints_log = {1, 3, 5, 7, 10, 24, 33, 0}

# we can check the unique values in two sets
print(daily_pints_log | wife_daily_pints_log)

# we can check the values presents in both sets
print(daily_pints_log & wife_daily_pints_log)

# we can check the values unique for the first set
print(daily_pints_log - wife_daily_pints_log)

# we can check the values unique on each of the sets
print(daily_pints_log ^ wife_daily_pints_log)

# Dictionaries
# dictionaries are key/value pair
dict_cream = {
    "name": "Clebson Moura",
    "weekly intake": 5,
    "favorite ice creams": [
        "Chocolate",
        "Strawberry",
    ],
}

print(dict_cream)

# we can take the all the values
print(dict_cream.values())

# we can take the all the keys
print(dict_cream.keys())

# we can take the all the items
print(dict_cream.items())

# we access values by the key
print(dict_cream["name"])

# we update values by the key
dict_cream["weekly intake"] = 1

print(dict_cream["weekly intake"])

# we update the whole dictionary
dict_cream.update(
    {
        "name": "Clebson Sarmento Moura",
        "weekly intake": 2,
        "weight": 250,
    }
)

print(dict_cream)

# we delete keys from the dictionary
del dict_cream["favorite ice creams"]

print(dict_cream)
