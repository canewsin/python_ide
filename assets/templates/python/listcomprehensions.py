# Python 3: List comprehensions
fruits = ['Banana', 'Apple', 'Lime']
loud_fruits = [fruit.upper() for fruit in fruits]
print(loud_fruits)
#Output
# ['BANANA', 'APPLE', 'LIME']

# List and the enumerate function
print(list(enumerate(fruits)))
#Output
# [(0, 'Banana'), (1, 'Apple'), (2, 'Lime')]