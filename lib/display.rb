module Display
  def print_hud
    puts line
puts center """ ,-_/          ,.   ,   ,.
'  |,-.,-.,-. `|  /|  /,-.,-.,-..,-.,-.
.- ||  | || |  | / | / ,-||  |  || ||
`--''  `-'' '  `'  `'  `-^'  '  '`-'' """
    puts line

    puts lr_msg("Warrior(#{@warrior.x},#{@warrior.y})", "HP(#{@warrior.health})")
    puts lr_msg("Facing(#{@warrior.facing})", "▲")
    puts lr_msg("Turn ##{@turn}", "N")

    puts line
  end

  def lr_msg(left, right)
    left + (' ' * (@width - (left.length + right.length))) + right
  end

  def center(msg)
    # Omg this is terrifying. Fix me immediately. 😰
    padding = ' ' * ((((@width / 2) - (msg.split("\n").first.length / 2)) / 2)).abs
    if (msg_pieces = msg.split("\n"); msg_pieces.length > 1)
      padding + msg_pieces.join("\n" + padding)
    else
      padding + msg
    end
  end

  def line
    '-' * @width
  end

end
