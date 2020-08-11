class Array

  # Calls the block on every element of the array and returns the original array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  # # calls my_each twice on the array, printing all the numbers twice.
  # return_value = [1, 2, 3].my_each do |num|
  #   puts num
  # end.my_each do |num|
  #   puts num
  # end
  # # # => 1
  # #     2
  # #     3
  # #     1
  # #     2
  # #     3
  # p return_value  # => [1, 2, 3]

  # Returns a new array containing only elements that satisfy the block
  def my_select(&prc)
    new_arr = []
    self.my_each do |ele|
      new_arr << ele if prc.call(ele)
    end
    new_arr
  end

  # a = [1, 2, 3]
  # p a.my_select { |num| num > 1 } # => [2, 3]
  # p a.my_select { |num| num == 4 } # => []

  # Returns a new array excluding elements that satisfy the block
  def my_reject(&prc)
    new_arr = []
    self.my_each do |ele|
      new_arr << ele if !prc.call(ele)
    end
    new_arr
  end

  # a = [1, 2, 3]
  # p a.my_reject { |num| num > 1 } # => [1]
  # p a.my_reject { |num| num == 4 } # => [1, 2, 3]

  # Returns true if any elements of the array satisfy the block
  def my_any?(&prc)
    self.my_each do |ele|
      return true if prc.call(ele)
    end
    false
  end

  # Returns true if all elements satisfy the block
  def my_all?(&prc)
    self.my_each do |ele|
      return false if !prc.call(ele)
    end
    true
  end

  # a = [1, 2, 3]
  # p a.my_any? { |num| num > 1 } # => true
  # p a.my_any? { |num| num == 4 } # => false
  # p a.my_all? { |num| num > 1 } # => false
  # p a.my_all? { |num| num < 4 } # => true

  # Returns all elements of the array into a new, one-dimensional array
  def my_flatten

  end

  # [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

  # Returns a new array containing self.length elements. Each element of the 
  # new array is an array with a length of the input arguments + 1 and contains
  # the merged elements at that index. If the size of any argument is less than
  # self, nil is returned for that location.
  def my_zip(*args)

  end

  # a = [ 4, 5, 6 ]
  # b = [ 7, 8, 9 ]
  # [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  # a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  # [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

  # c = [10, 11, 12]
  # d = [13, 14, 15]
  # [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

  # Returns a new array containing all the elements of the original array in a 
  # rotated order. By default, the array rotates by one element. If a negative 
  # value is given, the array is rotated in the opposite direction.
  def my_rotate(n)

  end

  # a = [ "a", "b", "c", "d" ]
  # a.my_rotate         #=> ["b", "c", "d", "a"]
  # a.my_rotate(2)      #=> ["c", "d", "a", "b"]
  # a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
  # a.my_rotate(15)     #=> ["d", "a", "b", "c"]

  # Returns a single string containing all the elements of the array, separated 
  # by the given string separator. If no separator is given, an empty string is 
  # used.
  def my_join(separator = "")

  end

  # a = [ "a", "b", "c", "d" ]
  # a.my_join         # => "abcd"
  # a.my_join("$")    # => "a$b$c$d"

  # Returns a new array containing all the elements of the original array in 
  # reverse order.
  def my_reverse

  end

  # [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
  # [ 1 ].my_reverse               #=> [1]
end