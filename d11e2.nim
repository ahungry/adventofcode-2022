import std/[algorithm, bitops, math, strformat, strutils]

# Brainstorm note - all the divisors in mod are prime numbers

type
  Item = ref object of RootObj
    base: int
    nums: seq[int]
    plus: seq[seq[int]]
    squares: int
    overflow: bool

  Monkey = ref object of RootObj
    items: seq[Item]
    op: char
    operation: proc (old: Item): void
    test: proc (x: Item): bool
    truthy: int
    falsey: int
    inspections: int

const BASE_MAX = 10000
const MODULO_MAX = 200

# So, each addition needs to be multiplied by each product that
# comes after it, but we need the rolling modulos for this to work
# Also, if we do a plus that is less than our largest expected modulo,
# we need to borrow from the base number
proc item_add(m: Item, n: int): void =
  if m.overflow or m.base + n > BASE_MAX:
    m.overflow = true
    if n < MODULO_MAX:
      m.plus.add(@[MODULO_MAX])
      m.base -= (MODULO_MAX - n)
    else:
      m.plus.add(@[n])
  else:
    m.base += n

proc item_multiplier(m: Item, n: int): void =
  if m.overflow or m.base * n > BASE_MAX:
    m.overflow = true
    m.nums.add(n)
    for i,v in m.plus:
      m.plus[i].add(n)
  else:
    m.base *= n

# All this only works if the divisor is smaller than our number checks
proc item_divisible_by(m: Item, n: int): bool =
  var modn = n

  # For each time we squared the set, we need to sqrt the mod
  # if m.squares > 0:
  #   for i in 1..(m.squares + 1):
  #     let tmp = sqrt(float(n))
  #     if tmp == float(int(tmp)):
  #       modn = int(sqrt(float(n)))

  if modn > MODULO_MAX:
    echo &"ERR: {modn} modulo exceeds {MODULO_MAX} - results will be bad."

  var x = m.base mod modn

  for y in m.nums:
    x = (x * y) mod modn

  # We defer products against the pluses
  for y in m.plus:
    for z in y:
      x = (x * z) mod modn

  return x == 0

proc item_square(m: Item): void =
  if m.overflow or m.base ^ 2 > BASE_MAX:
    m.overflow = true
    var
      nums: seq[int] = @[]
      pluses: seq[seq[int]] = @[]

    for n in m.nums:
      nums.add(n)

    for n in m.plus:
      pluses.add(n)

    for n in nums:
      m.nums.add(n)

    for n in pluses:
      m.plus.add(n)

    m.nums.add(m.base)
  else:
    m.base = m.base ^ 2

# # # This "works", but multiplying each addition by a product could overflow fast...
# var i = Item(base: 2, overflow: false)
# i.item_add(1)
# i.item_multiplier(3)
# i.item_square()
# i.item_square()
# i.item_square()
# i.item_square()
# echo i.base
# echo i.nums
# echo i.plus
# echo i.item_divisible_by(3)
# echo i.item_divisible_by(9)
# echo i.item_divisible_by(81)
# echo i.item_divisible_by(17)

var m0 = Monkey(
  items: @[Item(base: 79), Item(base: 98)],
  operation: proc (old: Item): void = old.item_multiplier(19),
  test: proc (x: Item): bool = x.item_divisible_by(23),
  truthy: 2,
  falsey: 3,
  inspections: 0
)

var m1 = Monkey(
  items: @[Item(base: 54), Item(base: 65), Item(base: 75), Item(base: 74)],
  operation: proc (old: Item): void = old.item_add(6),
  test: proc (x: Item): bool = x.item_divisible_by(19),
  truthy: 2,
  falsey: 0,
  inspections: 0
)

var m2 = Monkey(
  items: @[Item(base: 79), Item(base: 60), Item(base: 97)],
  operation: proc (old: Item): void = old.item_square(),
  test: proc (x: Item): bool = x.item_divisible_by(13),
  truthy: 1,
  falsey: 3,
  inspections: 0
)

var m3 = Monkey(
  items: @[Item(base: 74)],
  operation: proc (old: Item): void = old.item_add(3),
  test: proc (x: Item): bool = x.item_divisible_by(17),
  truthy: 0,
  falsey: 1,
  inspections: 0
)

var monkeys: seq[Monkey] = @[m0, m1, m2, m3]

proc monkey_throw(idx: int, item: Item): void =
  monkeys[idx].items.add(item)

proc monkey_turn(m: Monkey): void =
  for item in m.items:
    m.inspections += 1
    m.operation(item)
    if m.test(item):
      monkey_throw(m.truthy, item)
    else:
      monkey_throw(m.falsey, item)
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
