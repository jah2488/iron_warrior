path       = File.expand_path(__dir__)
full_path  = path + '/../lib/**/*.rb'

Dir[full_path].each do |file|
  require file
end

Game.new.start

