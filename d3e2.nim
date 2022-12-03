import std/[algorithm, strformat, strutils, sequtils, math]

const points = ".abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

proc readMyFile(): seq[char] =
  var line1, line2, line3: string

  let f = open("d3e1.txt")
  defer: f.close()

  while f.readLine(line1) and f.readLine(line2) and f.readLine(line3):
    for c in line1:
      if c in line2 and c in line3:
        result.add(c)
        break


let res = readMyFile()
echo res
echo res.mapIt(points.find($ it)).sum()
