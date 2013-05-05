require 'rubygems'
require 'gosu'
require './lib/player2'
require './lib/map'
require './lib/tiles'
require './lib/map'

include Gosu

class Game < Window
  attr_reader :map

  #def initialize
  #  super(640, 480, false)
  #  self.caption = "Survival"
  #  @sky = Image.new(self, "./media/space.png", true)
  #  @map = Map.new(self, "CptnRuby Map.txt")
  #  @player = Player2.new(self, 400, 100)
  #  # The scrolling position is stored as top left corner of the screen.
  #  @camera_x = @camera_y = 0
  #end

  def initialize
    super(640, 480, false)
    self.caption = "Cptn. Ruby"
    @sky = Image.new(self, "./media/Space.png", true)
    @map = Map.new(self, "./media/map.txt")
    @cptn = Player2.new(self, 400, 100)
    # The scrolling position is stored as top left corner of the screen.
    @camera_x = @camera_y = 0
  end

  def update
    move_x = 0
    move_y = 0
    move_x -= 5 if button_down? KbLeft
    move_x += 5 if button_down? KbRight
    move_y += 5 if button_down? KbDown
    move_y -= 5 if button_down? KbUp
    @cptn.update(move_x, move_y)
    @cptn.collect_items(@map.items)
    # Scrolling follows player
    @camera_x = [[@cptn.x - 320, 0].max, @map.width * 50 - 640].min
    @camera_y = [[@cptn.y - 240, 0].max, @map.height * 50 - 480].min
  end

  def draw
    @sky.draw 0, 0, 0
    translate(-@camera_x, -@camera_y) do
      @map.draw
      @cptn.draw
    end
  end

  def button_down(id)
    #if id == KbUp then @cptn.try_to_jump end
    if id == KbEscape then close end
  end
end

Game.new.show
