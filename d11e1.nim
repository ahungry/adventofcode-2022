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
  items: @[79, 98],
  operation: func (old: int): int = old * 19,
  test: func (x: int): bool = x mod 23 == 0,
  truthy: 2,
  falsey: 3,
  inspections: 0
)

var m1 = Monkey(
  items: @[54, 65, 75, 74],
  operation: func (old: int): int = old + 6,
  test: func (x: int): bool = x mod 19 == 0,
  truthy: 2,
  falsey: 0,
  inspections: 0
)

var m2 = Monkey(
  items: @[79, 60, 97],
  operation: func (old: int): int = old * old,
  test: func (x: int): bool = x mod 13 == 0,
  truthy: 1,
  falsey: 3,
  inspections: 0
)

var m3 = Monkey(
  items: @[74],
  operation: func (old: int): int = old + 3,
  test: func (x: int): bool = x mod 17 == 0,
  truthy: 0,
  falsey: 1,
  inspections: 0
)

var monkeys: seq[Monkey] = @[m0, m1, m2, m3]

proc monkey_throw(idx: int, worry_level: int): void =
  monkeys[idx].items.add(worry_level)

proc monkey_turn(m: Monkey): void =
  for item in m.items:
    m.inspections += 1
    var im_level: int = m.operation(item)
    var worry_level: int = int(im_level / 3)
    if m.test(worry_level):
      echo &"Truthy {m.truthy} - worry level: {worry_level}"
      monkey_throw(m.truthy, worry_level)
    else:
      echo &"Falsey {m.falsey} - worry level: {worry_level}"
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
