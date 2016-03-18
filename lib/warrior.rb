class Warrior
  attr_accessor :x, :y, :char, :health, :facing, :room
  def initialize(x, y, char = "\033[31m@\033[m", log: [], room: [])
    @x = x
    @y = y
    @char = char
    @health = 10
    @damage = 2
    @facing = EAST
    @log = log
    @room = room
  end

  def walk!(direction)
    @facing = direction.upcase
    space = send(direction)

    if space.is_a?(Entity) &&
       space.x == @room.exit.x &&
       space.y == @room.exit.y
      @log.push "#{warrior} found the exit!"
      return
    end

    if space != Room::EMPTY
      @log.push "#{warrior} blocked by #{space.name}"
    else
      case direction
      when NORTH then @y -= 1 if @y > 1
      when SOUTH then @y += 1 if @y < @room.height
      when EAST then  @x += 1 if @x < @room.width
      when WEST then  @x -= 1 if @x > 1
      end
      @log.push "#{warrior} walks #{direction}"
    end
  end

  def feel(direction, should_log = nil)
    space = send(direction)
    if should_log
      @log.push "#{warrior} feels #{direction} and notices #{space.name}"
    end
    space
  end

  def consult_map
    distance_x = @room.exit.x - @x
    distance_y = @room.exit.y - @y
    distance = (distance_x + distance_y) / 2
    @log.push "#{warrior} checks their map to find they are #{distance} space(s) from the exit"
  end

  def attack!(direction)
    space = send(direction)
    if space == Room::EMPTY
      @log.push "#{warrior} swings their sword #{direction} at nothing"
    else
      damage = rand(1..@damage)
      if space.respond_to?(:health)
        space.health -= damage
        @log.push "#{warrior} slices #{direction} hitting #{space.name} for #{damage} damage"
      end
    end
  end

  def rest!
    if warrior.health > 10
      healing = -1
    else
      max_heal = warrior.health / 10
      healing = rand((max_heal - 1)..(max_heal + 1))
      warrior.health += healing
    end
    @log.push "#{warrior} rests for a turn, restoring #{healing} health"
  end

  private
  def warrior
    "#{color(0)}Warrior#{reset}"
  end

  def north
    room[x, y - 1]
  end

  def east
    room[x + 1, y]
  end

  def south
    room[x, y + 1]
  end

  def west
    room[x - 1, y]
  end

  def color(code)
    case code
    when 0 then "\033[31m" #red
    when 1 then "\033[32m" #green
    when 3 then "\033[33m" #yellow
    when 4 then "\033[34m" #cyan
    when 5 then "\033[36m"
    else
      "\033[35m" #magenta
    end
  end

  def reset
    "\033[m"
  end
end

