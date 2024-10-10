number = 0

# basic while loop
while number < 5:
    print(number)
    number += 1

number = 0

# we can use break to stop the loop
while number < 5:
    print(number)
    if number == 3:
        break
    number += 1

number = 0

# we can use else to run code after the loop
# only runs if there isn't a break statment met
while number < 5:
    print(number)
    number += 1
else:
    print("No longer < 5")

number = 0

# we can use continue to skip an interation
while number < 5:
    number += 1
    if number == 3:
        continue
    print(number)
