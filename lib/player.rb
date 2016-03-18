class Player
  def step(warrior)
    space = warrior.feel(EAST)
    warrior.consult_map
    if space.is_a?(Enemy)
      warrior.attack!(EAST)
    else
      if space == Room::WALL
        warrior.walk!(SOUTH)
      else
        warrior.walk!(EAST)
      end
    end
  end
end
