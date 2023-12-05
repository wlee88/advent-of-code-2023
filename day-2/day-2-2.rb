class GameCollection
  def initialize
    @games = []
  end

  def addGame(game)
    @games << game
  end

  def max_cubes_per_game
    # for each game, get the highest count number of each color
    @games.each do |game|
      pp game.highest_results
    end
  end

  def power_results_per_game
    max_cubes_per_game.map do |game|
      values = game.highest_results.values
      values.reject(&:zero?).inject(:*)
    end
  end

  def sum_power_results
    power_results_per_game.sum
  end

end

class Game
  attr_accessor :highest_results , :id

  def initialize(id)
      @id = id
      @highest_results =  Hash.new(0)
  end

  def addResult(result)
    color = result.keys.first.to_s
    count = result.values.first
    if @highest_results[color] < count
      @highest_results[color] = count
    end
  end

  def to_s
    "id: #{@id}, results: #{@results}"
  end

  def ==(other)
    @id == other.id
  end
end
def parseInputToGame(input)
  id = input.split(':').first.split(' ').last.to_i
  game = Game.new(id)
  results = input.split(':').last.split(';')
  results.each do |result|
    results = result.strip
    count_color_pair = results.split(',').map { |color| color.strip }.map { |color| color.split(' ') }

    count_color_pair.each do |pair|
      count = pair.first.to_i
      color = pair.last
      game.addResult(color => count)
    end
  end
  game
end


PUZZLE_INPUT_PATH = 'day-2-puzzle.txt'
input = File.readlines(PUZZLE_INPUT_PATH)

collection = GameCollection.new
input.each do |input|
  collection.addGame(parseInputToGame(input))
end
pp collection.sum_power_results
