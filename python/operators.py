# Comparison Operators
# Equals
print(10 == 50)

# Not Equals
print(10 != 50)

# We can compare strings
print("Vanilla" == "Chocolate")

# We can compare variables
x = "Vanilla"
y = "Chocolate"
print(x != y)

# Less than
print(10 < 20)

# Less than or Equals
print(10 <= 10)

# Greater than
print(10 > 20)

# Greater than or Equals
print(10 >= 10)

# Logical Operators
# And, both need to be True
print((10 > 20) and (50 > 10))

# Or, one need to be True
print((10 > 20) or (50 > 10))

# Not, inverts the comparison
print(not (10 < 50))

# Membership Operators
# In, check if a value exists in a object
ice_cream = "I love Chocolate icee cream"
print("love" in ice_cream)

# Not In, check if a value doesn't exists in a object
scoops = [1, 2, 3, 4, 5]
wanted_scoop = 8
print(wanted_scoop not in scoops)
