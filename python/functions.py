# basic function definition
def first_func():
    print("We did it!")


first_func()


# with argument
def number_square(number):
    print(number**2)


number_square(5)


# with multiple arguments
def number_to_power(number, power):
    print(number**power)


number_to_power(5, 3)

# we can also pass arguments by name
number_to_power(power=2, number=10)


# arbitary arguments (*args)
# when we are not sure how many arguments will be passed to the function
def sum_all(*args):
    sum = 0
    for i in args:
        sum += i
    print(sum)


numbers_to_sum = (1, 2, 3, 4, 5)
sum_all(*numbers_to_sum)


# arbitary keyword arguments (**kwargs)
def number_kwarg(**number):
    print(
        "My number is {}, and my other number is {}".format(
            number["num"], number["othe_num"]
        )
    )


number_kwarg(num=5, othe_num=10)
