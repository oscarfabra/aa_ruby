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
    new_arr = []
    self.my_each do |ele|
      new_arr += (ele.is_a?(Array))? ele.my_flatten : [ele]
    end
    new_arr
  end

  # p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

  # Returns a new array containing self.length elements. Each element of the 
  # new array is an array with a length of the input arguments + 1 and contains
  # the merged elements at that index. If the size of any argument is less than
  # self, nil is returned for that location.
  def my_zip(*args)
    new_arr = []
    (0...self.length).to_a.my_each do |i|
      arr = [self[i]]
      (0...args.length).to_a.my_each do |j|
        arr << args[j][i]
      end
      new_arr << arr
    end
    new_arr
  end

  # a = [ 4, 5, 6 ]
  # b = [ 7, 8, 9 ]
  # p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  # p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  # p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

  # c = [10, 11, 12]
  # d = [13, 14, 15]
  # p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

  # Returns a new array containing all the elements of the original array in a 
  # rotated order. By default, the array rotates by one element. If a negative 
  # value is given, the array is rotated in the opposite direction.
  def my_rotate(n = 1)
    new_arr = Array.new(self)
    if n > 0
      n.times do 
        new_arr.push(new_arr.shift)
      end
    else
      (-n).times do
        new_arr.unshift(new_arr.pop)
      end
    end
    new_arr
  end

  # a = [ "a", "b", "c", "d" ]
  # p a.my_rotate         #=> ["b", "c", "d", "a"]
  # p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
  # p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
  # p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

  # Returns a single string containing all the elements of the array, separated 
  # by the given string separator. If no separator is given, an empty string is 
  # used.
  def my_join(separator = "")
    str = ""
    i = 0
    while i < self.length
      str += self[i].to_s
      str += separator if i < self.length - 1
      i += 1
    end
    str
  end

  # a = [ "a", "b", "c", "d" ]
  # p a.my_join         # => "abcd"
  # p a.my_join("$")    # => "a$b$c$d"

  # Returns a new array containing all the elements of the original array in 
  # reverse order.
  def my_reverse
    new_arr = []
    i = self.length - 1
    while i >= 0
      new_arr << self[i]
      i -= 1
    end
    new_arr
  end

  # a = [ "a", "b", "c" ]
  # b = [1]
  # p a.my_reverse   #=> ["c", "b", "a"]
  # p b.my_reverse               #=> [1]
  # p a, b
end