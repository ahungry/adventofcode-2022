import std/[strformat, strutils]

proc readMyFile(): int =
  var
    line: string
    elfTmp = 0

  let f = open("d1e1.txt")
  # Close the file object when you are done
  defer: f.close()

  while f.readLine(line):
    if line == "":
      if elfTmp > result:
        result = elfTmp

      elfTmp = 0
    else:
      elfTmp += line.parseInt()


var res: int = readMyFile() # will only read the first line
echo &"Elf answer: {res}\n"
