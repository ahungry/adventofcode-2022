import std/[algorithm, strformat, strutils, sequtils, math]

const points = ".abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

proc readMyFile(): int =
  var
    line: string

  let f = open("d3e1.txt")
  defer: f.close()

  while f.readLine(line):
    var
      left = line[0..(line.len/2).int - 1]
      right = line[(line.len/2).int..(line.len) - 1]
      both: seq[char]

    for c in left:
      if c in right and not (c in both):
        both.add(c)

    result += both.mapIt(points.find($ it)).sum()

let res = readMyFile()
echo res
