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

numbers = input.map { |input| get_numbers(input) }
input_sums = numbers.map { |n| n.first + n.last }

puts input_sums

input_sums_as_integer = input_sums.map { |sum_char| sum_char.to_i }
puts input_sums_as_integer.sum
