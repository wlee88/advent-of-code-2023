class GameCollection
  def initialize
    @games = []
  end

  def addGame(game)
    @games << game
  end

  def possible_games(available)
    possible = []
    @games.each do |game|
      puts game.results.inspect
      puts available
      possible << game if !game.results.any? { |result| available[result.keys.first] < result.values.first }
    end
    possible.uniq
  end
end

class Game
  attr_accessor :results, :id

  def initialize(id)
      @id = id
      @results = []
  end

  def addResult(result)
    @results.push result
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
available = {'red' => 12, 'green' => 13, 'blue' => 14}
possible_games = collection.possible_games(available)
puts possible_games
ids = possible_games.map { |game| game.id }
puts ids.sum