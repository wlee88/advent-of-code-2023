# read in matrix

PUZZLE_INPUT_PATH='day-3-puzzle.txt'
input = File.readlines(PUZZLE_INPUT_PATH)

def numeric?(char)
  return (0..9).include?(char.to_i) if Integer(char, exception: false)
end

def is_period?(char)
  char == "."
end

# check is non-numeric is a "."
def is_part_symbol?(char)
  is_numeric = numeric?(char)
  is_period = is_period?(char)
  
  return !is_numeric && !is_period
end

def to_unique_symbol(symbol, line_index, char_index)
  return "#{symbol}-#{line_index}-#{char_index}"
end

def check_adjacent(matrix, line_index, char_index, line_length, char)
  is_first_line = line_index == 0
  is_last_line = line_index == matrix.length - 1
  is_first_char = char_index == 0
  is_last_char = char_index == line_length - 1
  if !is_first_line
    top = to_unique_symbol(matrix[line_index-1][char_index], line_index-1, char_index) if is_part_symbol?(matrix[line_index-1][char_index])
    top_left = to_unique_symbol(matrix[line_index-1][char_index-1], line_index-1, char_index-1) if is_part_symbol?(matrix[line_index-1][char_index-1])
    top_right = to_unique_symbol(matrix[line_index-1][char_index+1], line_index-1, char_index+1) if is_part_symbol?(matrix[line_index-1][char_index+1])
  end

  if !is_first_char
    left = to_unique_symbol(matrix[line_index][char_index-1], line_index, char_index-1) if is_part_symbol?(matrix[line_index][char_index-1])
  end
  if !is_last_char
    right = to_unique_symbol(matrix[line_index][char_index+1], line_index, char_index+1) if is_part_symbol?(matrix[line_index][char_index+1])
  end

  # check if not last line
  if !is_last_line
    bottom_left = to_unique_symbol(matrix[line_index+1][char_index-1], line_index+1, char_index-1) if is_part_symbol?(matrix[line_index+1][char_index-1])
    bottom = to_unique_symbol(matrix[line_index+1][char_index], line_index+1, char_index) if is_part_symbol?(matrix[line_index+1][char_index])
    bottom_right = to_unique_symbol(matrix[line_index+1][char_index+1], line_index+1, char_index+1) if is_part_symbol?(matrix[line_index+1][char_index+1])
  end

  map = { top: top, top_left: top_left, left: left, bottom_left: bottom_left, bottom: bottom, bottom_right: bottom_right, right: right, top_right: top_right }
  map.values.filter { |value| !value.nil? } 
end

matrix = []
input.each do |line|
  line_str = line.chomp
  line_arr = line_str.split("")
  matrix << line_arr
end

results = []
current_digit = []
parts = []

matrix.each_with_index do |line, line_index|
  line.each_with_index do |char, char_index|
    is_last_char = char_index == line.length - 1
    
    if numeric?(char)
      current_digit << char
      parts = check_adjacent(matrix, line_index, char_index, line.length, char) if parts.empty?
      if is_last_char
        results << { part_number: current_digit.join('').to_i, parts: parts } if current_digit.length > 0
        current_digit = []
        parts = []
      end
    else
      results << { part_number: current_digit.join('').to_i, parts: parts } if current_digit.length > 0
      current_digit = []
      parts = []
    end
  end
end

results_with_parts =  results.filter { |result| result[:parts].length > 0 }

parts_map = Hash.new
results_with_parts.each do |result|
  result[:parts].each do |part|
    parts_map[part] = [] if parts_map[part].nil?
    parts_map[part] << result[:part_number]
  end
end

parts_with_two_numbers = parts_map.filter { |key, value| value.length == 2 }

gear_ratios = parts_with_two_numbers.values.map { |value| value.inject(&:*) }

pp gear_ratios.sum