
import re

#open file and read all rows
with open("fhv_tripdata_2020-01.csv") as f:
    rows = f.read().splitlines()

# create a pattern and find the csv separator
p = re.compile("[^,;\t|]+")
sep = re.sub(p, "",rows[0])[0]
items = len(rows[0].split(sep))

# find rows that don't have exactly items as the header.
# these are the errors
for i in range (len(rows)):
    l = len(rows[i].split(sep))
    if l != items:
        print(i, rows[i])

