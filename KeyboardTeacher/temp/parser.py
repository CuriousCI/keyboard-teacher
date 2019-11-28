import json

class Key:
    def __init__(self, value, x, y, width, height, finger):
        self.value = value
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.finger = finger
        

input = open("Keys.txt")

output = "{"

for line in input:
    values = line.split()
    key = Key(values[0], int(values[1]) / 60, int(values[2]) / 60, int(values[3]) / 25, int(values[4]) / 25, values[5])
    output += json.dumps(key.__dict__) + ","

output += "}"
print(output)