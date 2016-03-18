# coding: utf-8
NORTH = :north
SOUTH = :south
EAST  = :east
WEST  = :west
SPACE = ' '
STEP_CAP = 40

class Game
  include Display

  def start
    @turn  = 0
    @width = (`tput cols`.chomp.to_i / 3)
    @width = 23 if @width < 23
    system('clear')
    puts "Welcome to IRON WARRIOR"
    @log     = Array.new(5) { '...' } #Replace with logger class
    @warrior = Warrior.new(2, 2, log: @log)
    @player  = Player.new
    @room    = Room.new(8, 3, [@warrior,
                            Enemy.new(7, 2, "\033[32m♘\033[m", "minataur"),
                            Entity.new(8, 3, '☖')])
    @room.exit = Entity.new(8, 3, '☖')
    @warrior.room = @room
    step
  end

  def step
    loop do
      break if @turn >= STEP_CAP
      @turn += 1
      system('clear')
      print_hud
      @room.print_room(@width)
      puts line
      print_logs(5)
      puts line
      @player.step(@warrior)
      print "Enter to progress a turn"
      gets #or sleep 1
    end
  end

  def print_logs(amt)
    log_len = @log.length - 5
    @log[-5..-1].each.with_index do |line, index|
      puts "[#{(log_len + index).to_s.rjust(3,'0')}][#{line}]"
    end
  end
end
