#!/usr/bin/env ruby

require 'rx'

# Using a seed for the accumulate
source = Rx::Observable.range(1, 10).aggregate(1) { |acc, x|
  acc * x
}

subscription = source.subscribe(
  lambda { |x| puts 'Next: ' + x.to_s },
  lambda { |e| puts 'Error: ' + e.to_s },
  lambda { puts 'Completed' })

# => Next: 3628800
# => Completed

# Without a seed
source = Rx::Observable.range(1, 10).aggregate { |acc, x|
  acc + x
}

subscription = source.subscribe(
  lambda { |x| puts 'Next: ' + x.to_s },
  lambda { |e| puts 'Error: ' + e },
  lambda { puts 'Completed' }
)

# => Next: 55
# => Completed
