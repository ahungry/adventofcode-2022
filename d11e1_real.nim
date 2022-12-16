import std/[algorithm, bitops, math, strformat, strutils]

type
  Monkey = ref object of RootObj
    items: seq[int]
    operation: proc (old: int): int
    test: proc (x: int): bool
    truthy: int
    falsey: int
    inspections: int

var m0 = Monkey(
  items: @[83, 88, 96, 79, 86, 88, 70],
  operation: func (old: int): int = old * 5,
  test: func (x: int): bool = x mod 11 == 0,
  truthy: 2,
  falsey: 3,
  inspections: 0
)

var m1 = Monkey(
  items: @[59, 63, 98, 85, 68, 72],
  operation: func (old: int): int = old * 11,
  test: func (x: int): bool = x mod 5 == 0,
  truthy: 4,
  falsey: 0,
  inspections: 0
)

var m2 = Monkey(
  items: @[90, 79, 97, 52, 90, 94, 71, 70],
  operation: func (old: int): int = old + 2,
  test: func (x: int): bool = x mod 19 == 0,
  truthy: 5,
  falsey: 6,
  inspections: 0
)

var m3 = Monkey(
  items: @[97, 55, 62],
  operation: func (old: int): int = old + 5,
  test: func (x: int): bool = x mod 13 == 0,
  truthy: 2,
  falsey: 6,
  inspections: 0
)

var m4 = Monkey(
  items: @[74, 54, 94, 76],
  operation: func (old: int): int = old * old,
  test: func (x: int): bool = x mod 7 == 0,
  truthy: 0,
  falsey: 3,
  inspections: 0
)

var m5 = Monkey(
  items: @[58],
  operation: func (old: int): int = old + 4,
  test: func (x: int): bool = x mod 17 == 0,
  truthy: 7,
  falsey: 1,
  inspections: 0
)

var m6 = Monkey(
  items: @[66, 63],
  operation: func (old: int): int = old + 6,
  test: func (x: int): bool = x mod 2 == 0,
  truthy: 7,
  falsey: 5,
  inspections: 0
)

var m7 = Monkey(
  items: @[56, 56, 90, 96, 68],
  operation: func (old: int): int = old + 7,
  test: func (x: int): bool = x mod 3 == 0,
  truthy: 4,
  falsey: 1,
  inspections: 0
)


var monkeys: seq[Monkey] = @[m0, m1, m2, m3, m4, m5, m6, m7]

proc monkey_throw(idx: int, worry_level: int): void =
  monkeys[idx].items.add(worry_level)

proc monkey_turn(m: Monkey): void =
  for item in m.items:
    m.inspections += 1
    var im_level: int = m.operation(item)
    var worry_level: int = int(im_level / 3)
    if m.test(worry_level):
      #echo &"Truthy {m.truthy} - worry level: {worry_level}"
      monkey_throw(m.truthy, worry_level)
    else:
      #echo &"Falsey {m.falsey} - worry level: {worry_level}"
      monkey_throw(m.falsey, worry_level)
  m.items = @[]

proc monkey_round(): void =
  for k,v in monkeys:
    monkey_turn(monkeys[k])

for i in 1..20:
  monkey_round()

echo m0.inspections
echo m1.inspections
echo m2.inspections
echo m3.inspections
echo m4.inspections
echo m5.inspections
echo m6.inspections
echo m7.inspections
