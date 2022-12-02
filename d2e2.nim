import std/[algorithm, strformat, strutils]

proc readMyFile(): int =
  var
    line: string
    totals: seq[int]
    elfTmp = 0

  let f = open("d2e1.txt")
  # Close the file object when you are done
  defer: f.close()

  while f.readLine(line):
    var
      x: seq[string] = line.split(" ")
      x1: string = x[0]
      x2: string = x[1]
      x3: string

    # point bonus, 1/2/3 - then 0 loss, 3 draw, 6 won
    # A = rock, B = paper, C = scissors
    # X = rock, Y = paper, Z = scissors

    # Now we know X = lose, Y = draw, Z = win
    if x1 == "A":
      if x2 == "X":
        result += 0
        x3 = "Z"

      if x2 == "Y":
        result += 3
        x3 = "X"

      if x2 == "Z":
        result += 6
        x3 = "Y"

    if x1 == "B":
      if x2 == "X":
        result += 0
        x3 = "X"

      if x2 == "Y":
        result += 3
        x3 = "Y"

      if x2 == "Z":
        result += 6
        x3 = "Z"

    if x1 == "C":
      if x2 == "X":
        result += 0
        x3 = "Y"

      if x2 == "Y":
        result += 3
        x3 = "Z"

      if x2 == "Z":
        result += 6
        x3 = "X"

    # Bonus based on played value
    if x3 == "X":
      result += 1

    if x3 == "Y":
      result += 2

    if x3 == "Z":
      result += 3


var res: int = readMyFile()
echo res
