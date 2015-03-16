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

require 'benchmark/ips'

# Benchmark.ips do |r|
#   array = (1..100).to_a

#   r.report 'binary' do
#     array.bindex 25
#     array.bindex 75
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

diamonds = (1..100000000).to_a
puts "Bindex"
puts Benchmark.measure { diamonds.bindex 75000000 }
puts "Index"
puts Benchmark.measure { diamonds.index 75000000 }

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



