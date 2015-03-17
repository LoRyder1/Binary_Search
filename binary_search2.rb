require 'benchmark'

# def linear_search(planets, my_planet)
# 	planets.each do |planet|
# 		if planet == my_planet
# 			puts "Found my_planet"
# 			return true
# 		end
# 	end
# 	puts "Your planet isn't in the list"
# 	return false
# end


# def binary_search(planets, my_planet)
# 	sorted_planets = planets.sort
# 	lower_bound = 0 
# 	upper_bound = planets.size

# 	while lower_bound <= upper_bound
# 		mid_point = ((lower_bound + upper_bound)/2).floor
# 		if my_planet < sorted_planets[mid_point]
# 			upper_bound = mid_point - 1
# 		elsif my_planet > sorted_planets[mid_point]
# 			lower_bound = mid_point + 1
# 		else
# 			puts "Found my_planet"
# 			return true
# 		end
# 	end
# 	puts "Your planet is not in the list"
# 	return false
# end

# planets = []

# 1_000_000.times do 
# 	planets << rand(1..1_000_000)
# end

# planets << 1_000_001

# my_planet = 1_000_001

# puts "Linear Search"

# puts Benchmark.measure { linear_search(planets, my_planet)}

# puts "Binary Search"

# puts Benchmark.measure { binary_search(planets, my_planet)}


class Array
  def bindex element, lower = 0, upper = length - 1
    return if lower > upper
    mid = (lower + upper) / 2
    if element < self[mid]
    	upper = mid -1
    else
    	lower = mid +1
    end
    if element == self[mid]
    	mid
    else
    	bindex(element, lower, upper)
    end
    # element < self[mid] ? upper = mid - 1 : lower = mid + 1
    # element == self[mid] ? mid : bindex(element, lower, upper)
  end
end

class Array
  def it_bindex element, edge
    upper = self.size
    lower = 0
    while upper >= lower
      mid = (upper + lower) / 2
      if self[mid] < element
        lower = mid + 1
        # return "hello"
      elsif self[mid] > element
        # if edge[mid] < element
          # return mid
        # else
          upper = mid - 1
        # end
        # return mid if element < edge[mid] &&
        # return "hello"
      else
        return mid
      end
    end
    return nil
  end
end

z = [1,4,7,10,13,16,19]
y = [3,6,9,12,15,18,21]

# p z.it_bindex(14, y) #
# p z.it_bindex(1, y) 
# p z.it_bindex(2, y) 
# p z.it_bindex(4, y) 
# p z.it_bindex(7, y) 
# p z.it_bindex(9, y) 
# p z.it_bindex(10, y) #
# p z.it_bindex(11, y) 
# p z.it_bindex(12, y) 
# p z.it_bindex(13, y) #
# p z.it_bindex(8, y) #
# p z.it_bindex(5, y)

# Given sorted array A
# Find a key using binary search and get an index. 
# If A[index] == key
#     return index;
# else 
#    while(index > 1 && A[index] == A[index -1]) index = index -1;
#    return index;



def iter_bindex(array, element)
	upper = array.size
	lower = 0
	while upper >= lower
		mid = (upper + lower) /2
		if array[mid] < element
			lower = mid + 1
		elsif array[mid] > element
			upper = mid -1
		else 
			return mid
		end
	end
	return nil
end

diamonds = (1..1_000_000).to_a

# p iter_bindex(diamonds, 0)
# p iter_bindex(diamonds, 1_000_000)

# puts Benchmark.measure { iter_bindex(diamonds, 750000) }

# puts Benchmark.measure { diamonds.index 750000 }

# require 'benchmark/ips'

# Benchmark.ips do |r|
#   array = (1..100).to_a

#   r.report 'binary' do
#     array.bindex 25
#     array.bindex 75
#   end

#   r.report 'it_bindex' do
#   	array.it_bindex 25
#   	array.it_bindex 75
#   end

#   r.report 'rindex' do
#     array.rindex 25
#     array.rindex 75
#   end

#   r.report 'index' do
#     array.index 25
#     array.index 75
#   end

# end

# diamonds = (1..100_000_000).to_a
# puts "Bindex"
# puts Benchmark.measure { diamonds.bindex 75000000 }
# puts "Iterative Bindex"
# puts Benchmark.measure { diamonds.it_bindex 75000000 }
# puts "Index"
# puts Benchmark.measure { diamonds.index 75000000 }

# diamonds = [] #my bowl of diamonds

# # 10000000.times do 
# 1_000_0000.times do 
#   diamonds << rand(1..1_000_000) #make an diamond with a random diameter
# end
# diamonds << 1_000_001

# my_diamond = rand(1_000_001) #set my_diamond diameter to compare to

# # puts "Linear Search"
# # puts Benchmark.measure { linear_search(diamonds, my_diamond) }
# puts "Index"
# puts Benchmark.measure { diamonds.index my_diamond }
# puts "Binary Search"
# puts Benchmark.measure { diamonds.bindex my_diamond }



def find(x)
  return nil if x.nil?
  low = 0
  high = self.size - 1
  while low <= high
    mid = (low + high) / 2
    case matches?(x, low, high, mid)
      when -1 then high = mid - 1
      when 1 then low = mid + 1
      when 0 then return self[mid]
      else return nil
    end
  end
  nil
end

a = [1,2,3,4,5,6,7,8,9]

# p a.find(2)

# puts a



class SegmentTree
  # An elementary interval
  class Segment #:nodoc:all:
    attr_reader :range, :value

    def initialize(range, value)
      raise ArgumentError, 'Range expected, %s given' % range.class.name unless range.is_a?(Range)

      @range, @value = range, value
    end

    # segments are sorted from left to right, from shortest to longest
    def <=>(other)
      case cmp = @range.begin <=> other.range.begin
        when 0 then @range.end <=> other.range.end
        else cmp
      end
    end
  end

  # Build a segment tree from +data+.
  #
  # Data can be one of the following:
  # 1. Hash - a hash, where ranges are keys,
  #    i.e. <code>{(0..3) => some_value1, (4..6) => some_value2, ...}<code>
  # 2. 2-dimensional array - an array of arrays where first element of
  #    each element is range, and second is value:
  #    <code>[[(0..3), some_value1], [(4..6), some_value2] ...]<code>
  #
  # You can pass optional argument +sorted+.
  # If +sorted+ is true then tree consider that data already sorted in proper order.
  # Use it at your own risk!
  def initialize(data, sorted = false)
    # build elementary segments
    @segments = case data
      when Hash, Array, Enumerable then
        data.collect { |range, value| Segment.new(range, value) }
      else raise ArgumentError, '2-dim Array or Hash expected'
    end

    @segments.sort! unless sorted
  end

  # Find first interval containing point +x+.
  # @return [Segment|NilClass]
  def find(x)
    return nil if x.nil?
    low = 0
    high = @segments.size - 1
    while low <= high
      mid = (low + high) / 2

      case matches?(x, low, high, mid)
        when -1 then high = mid - 1
        when 1 then low = mid + 1
        when 0 then return @segments[mid]
        else return nil
      end
    end
    nil
  end

  def inspect
    if @segments.size > 0
      "SegmentTree(#{@segments.first.range.begin}..#{@segments.last.range.end})"
    else
      "SegmentTree(empty)"
    end
  end

  private
  def matches?(x, low_idx, high_idx, idx) #:nodoc:
    low, high = @segments[low_idx], @segments[high_idx]
    segment   = @segments[idx]
    left      = idx > 0 && @segments[idx - 1]
    right     = idx < @segments.size - 1 && @segments[idx + 1]

    case
      when left && low.range.begin <= x && x <= left.range.end then -1
      when segment.range.begin <=x && x <= segment.range.end then 0
      when right && right.range.begin <=x && x <= high.range.end then 1
      else nil
    end
  end
end


tree = SegmentTree.new(1..10 => "a", 11..20 => "b", 21..30 => "c")
p tree.find(19)