class Entity
  attr_reader :x, :y, :char, :name
  attr_accessor :health

  def initialize(x, y, char, name = nil, health = rand(2..5))
    @x = x
    @y = y
    @char = char
    @health = health
    @name = name || char
  end
end
