PUZZLE_INPUT_PATH = 'day-1-puzzle.txt'
input = File.readlines(PUZZLE_INPUT_PATH)

def get_numbers(word)
  word.chars.filter { |ch| is_digit? ch }
end


def is_digit?(s)
  code = s.ord
  # 48 is ASCII code of 0
  # 57 is ASCII code of 9
  48 <= code && code <= 57
end

def transformWordedNumbersToDigits(input)
  input
  .gsub('one', 'one1one')
  .gsub('two', 'two2two')
  .gsub('three', 'three3three')
  .gsub('four', 'four4four')
  .gsub('five', 'five5five')
  .gsub('six', 'six6six')
  .gsub('seven', 'seven7seven')
  .gsub('eight', 'eight8eight')
  .gsub('nine', 'nine9nine')
end

formatted_input = input.map { |input| transformWordedNumbersToDigits(input) }
numbers = formatted_input.map { |input| get_numbers(input) }
puts "numbers: #{numbers}"
puts "count: #{numbers.count}"
input_sums = numbers.map { |n| n.first + n.last }
puts "input_sums: #{input_sums}"

input_sums_as_integer = input_sums.map { |sum_char| sum_char.to_i }
puts "total: #{input_sums_as_integer.sum}"
