require 'benchmark'

def linear_search diamonds, my_diamond
  # comparisons = 0
  diamonds.each do |diamond|
    if diamond == my_diamond
      puts "Found it! #{my_diamond}"
      return true 
    # else
      # comparisons += 1
    end
    # puts "Comparison #{comparisons}, diamond of diameter #{diamond}"
  end
  puts "Homey! your diamond ain't here"
  return false
end


def binary_search diamonds, my_diamond
  sorted_diamonds = diamonds.sort
  lower_bound   = 0
  upper_bound   = diamonds.size
  # comparisons   = 0

  while lower_bound <= upper_bound
    mid_point = ((lower_bound + upper_bound) / 2).floor
    # p diamonds.slice(lower_bound..upper_bound)
    if my_diamond < sorted_diamonds[mid_point]
      upper_bound = mid_point - 1
      # comparisons += 1
      # puts
    elsif my_diamond > sorted_diamonds[mid_point]
      lower_bound = mid_point + 1
      # comparisons += 1
      # puts
    else
      puts "Found it! #{my_diamond}"
      return true
    end
    # puts "Comparison #{comparisons}"
  end
  puts "Homey! your diamond ain't here"
  return false
end

diamonds = [] #my bowl of diamonds

# 10000000.times do 
1_000_0000.times do 
  diamonds << rand(1..1_000_000) #make an diamond with a random diameter
end
diamonds << 1_000_001

my_diamond = rand(1_000_001) #set my_diamond diameter to compare to

# puts "Linear Search"
# puts Benchmark.measure { linear_search(diamonds, my_diamond) }
puts "Index"
puts Benchmark.measure { diamonds.index my_diamond }
puts "Binary Search"
puts Benchmark.measure { binary_search(diamonds, my_diamond) }

