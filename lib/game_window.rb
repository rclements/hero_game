require 'rubygems'
require 'gosu'
require './lib/player2'
include Gosu

class GameWindow < Window
  def initialize
    super 960, 625, false
    #super(640, 480, false)
    self.caption = "Complex"

    @background_image = Image.new(self, "complex.jpg", true)

    @player = Player2.new(self)
    @player.warp(320, 240)
  end

  def update
    if button_down? KbLeft or button_down? GpLeft then
      @player.turn_left
    end
    if button_down? KbRight or button_down? GpRight then
      @player.turn_right
    end
    if button_down? KbUp or button_down? GpButton0 then
      @player.accelerate
    end
    if button_down? KbDown or button_down? GpButton1 then
      @player.reverse
    end

    @player.move
  end

  def draw
    @player.draw
    @background_image.draw(0, 0, 0);
  end

  def button_down(id)
    if id == KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show


