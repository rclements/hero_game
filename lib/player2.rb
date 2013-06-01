# Player class.
class Player2
  attr_reader :x, :y

  def initialize(window, x, y, hero = "./sprites/hero.png")
    @x, @y = x, y
    @dir = :left
    @map = window.map
    # Load all animation frames
    @stand_down1, @walk_down1, @stand_down2, @walk_down2, @left_stand1, @walk_left1, @left_stand2, @walk_left2, @right_stand1, @walk_right1, @right_stand2, @walk_right2, @up_stand1, @walk_up1, @up_stand2, @walk_up2 = *Image.load_tiles(window, hero, 32, 49, false)
    # This always points to the frame that is currently drawn.
    # This is set in update, and used in draw.
    @cur_image = @stand_down1
  end
  
  def draw
    # Flip vertically when facing to the left.
    if @dir == :left then
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end
  
  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    not @map.solid?(@x + offs_x, @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y - 45)
  end
  
  def update(move_x, move_y)
    # Select image depending on action
    if (move_x == 0)
      @cur_image = @stand_down1
    else
      @cur_image = (milliseconds / 175 % 2 == 0) ? @walk_left1 : @walk_left2
    end
    #if (move_y < 0)
    #  @cur_image = @stand_down1
    #else
    #  @cur_image = (milliseconds / 175 % 2 == 0) ? @walk_left1 : @walk_left2
    #end
    
    # Directional walking, horizontal movement
    if move_x > 0 then
      @dir = :right
      move_x.times { if would_fit(1, 0) then @x += 1 end }
    end
    if move_x < 0 then
      @dir = :left
      (-move_x).times { if would_fit(-1, 0) then @x -= 1 end }
    end
    if move_y > 0 then
      @dir = :up
      move_y.times { if would_fit(0, 1) then @y += 1 end }
    end
    if move_y < 0 then
      @dir = :down
      (-move_y).times { if would_fit(0, -1) then @y -= 1 end }
    end



    # Acceleration/gravity
    # By adding 1 each frame, and (ideally) adding vy to y, the player's
    # jumping curve will be the parabole we want it to be.
    #@vy += 1
    ## Vertical movement
    #if @vy > 0 then
    #  @vy.times { if would_fit(0, 1) then @y += 1 else @vy = 0 end }
    #end
    #if @vy < 0 then
    #  (-@vy).times { if would_fit(0, -1) then @y -= 1 else @vy = 0 end }
    #end
#
    #if @map.solid?(@x, @y + 1) then
    #  @y = +5
    #end

  end
  
  def try_to_jump
    if @map.solid?(@x, @y + 1) then
      @vy = -20
    end
  end
  
  def collect_items(items)
    # Same as in the tutorial game.
    items.reject! do |c|
      (c.x - @x).abs < 50 and (c.y - @y).abs < 50
    end
  end
end


