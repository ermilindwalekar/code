#!/usr/bin/env ruby19 -wKU

r = rand(100)
a = [*1..100]
m = a - [r]

p a.reduce(:+) - m.reduce(:+)
