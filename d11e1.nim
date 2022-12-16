import std/[algorithm, math, strformat, strutils]

type
  Monkey = object of RootObj
    items: seq[int]
    operation: proc (old: int): int
    test: proc (x: int): bool
    truthy: int
    falsey: int

var m0 = Monkey(
  items: @[79, 98],
  operation: func (old: int): int = old * 19,
  test: func (x: int): bool = x mod 23 == 0,
  truthy: 2,
  falsey: 3
)

var m1 = Monkey(
  items: @[54, 65, 75, 74],
  operation: func (old: int): int = old + 6,
  test: func (x: int): bool = x mod 19 == 0,
  truthy: 2,
  falsey: 0
)

var m2 = Monkey(
  items: @[79, 60, 97],
  operation: func (old: int): int = old * old,
  test: func (x: int): bool = x mod 13 == 0,
  truthy: 1,
  falsey: 3
)

var m3 = Monkey(
  items: @[74],
  operation: func (old: int): int = old + 7,
  test: func (x: int): bool = x mod 17 == 0,
  truthy: 0,
  falsey: 1
)

var monkeys: seq[Monkey] = @[m0, m1, m2, m3]

proc monkey_turn(m: Monkey): void =
  for item in m.items:
    var worry_level: int = int(m.operation(item) / 3)
    if m.test(worry_level):
      echo &"Truthy {m.truthy} - worry level: {worry_level}"
    else:
      echo &"Falsey {m.falsey} - worry level: {worry_level}"

monkey_turn(m0)
