import std/[algorithm, strformat, strutils]

proc readMyFile(): seq[int] =
  var
    line: string
    totals: seq[int]
    elfTmp = 0

  let f = open("d1e1.txt")
  # Close the file object when you are done
  defer: f.close()

  while f.readLine(line):
    if line == "":
      totals.add(elfTmp)
      elfTmp = 0
    else:
      elfTmp += line.parseInt()

  totals


var res: seq[int] = readMyFile()
res.sort(Descending)
echo &"Elf answer: {res[0] + res[1] + res[2]}\n"
