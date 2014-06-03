require 'ostruct'

module Rubots
  class Robot
    attr_reader :x, :y, :angle, :gun_angle
    attr_writer :desired_angle, :desired_throttle, :desired_gun_angle

    # Some constants
    MAX_ANGLE      = 360 # Maximum angle. Wraps around to zero after this.
    ANGLE_STEP     = 1   # How much we change angle each tick.

    MAX_THROTTLE   = 10  # Max throttle. Can't go above.
    THROTTLE_STEP  = 1   # How much we change throttle each tick.

    SPEED_FACTOR   = 1   # How much movement does each throttle step represent

    MAX_GUN_ANGLE  = 360 # Maximum gun angle. Wraps around to zero after this.
    GUN_ANGLE_STEP = 2   # How much we change angle each tick.


    def initialize(strategy_class, game, x, y)
      @x = x
      @y = y
      @throttle  = @desired_throttle  = 0.0
      @angle     = @desired_angle     = 0.0
      @gun_angle = @desired_gun_angle = 0.0
      @game = game

      @strategy = strategy_class.new(@game.map, robot_data, nil)

      @destroyed = false

      @cooldown_timer = 0
    end

    def tick
      return if @destroyed

      if @cooldown_timer > 0
        @cooldown_timer -= 1
      else
        command = @strategy.get_command(robot_data, targets_data)
        command.apply_to(self)
        @cooldown_timer = command.cooldown
      end
      tick_angle
      tick_throttle
      tick_movement
      tick_gun
    end

    # It's a separate method because we want fire to be after *every* robot moved
    def tick_fire
      if @firing
        @game.laser_fire(Beam.from(self))
        @firing = false
      end
    end

    def name
      @strategy.name
    end

    def do_fire
      @firing = true
    end

    def distance_to(other)
      x_dist = @x - other.x
      y_dist = @y - other.y
      Math.sqrt(x_dist ** 2 + y_dist ** 2)
    end

    def destroy
      @throttle = 0
      @destroyed = true
    end

    def destroyed?
      @destroyed
    end

  private

    def robot_data
      OpenStruct.new x: @x, y: @y, angle: @angle, throttle: @throttle, gun_angle: @gun_angle
    end

    def targets_data
      @game.robots.map do |target_robot|
        next if target_robot == self
        x_dist = @x - target_robot.x
        y_dist = @y - target_robot.y
        distance = Math.sqrt(x_dist ** 2 + y_dist ** 2)
        actual_angle = Math.atan2(x_dist, -y_dist) * 180 / Math::PI + 180
        relative_angle = (actual_angle - @angle) % 360

        OpenStruct.new name: target_robot.name, distance: distance, angle: relative_angle
      end.compact
    end

    def tick_angle
      if @desired_angle != @angle
        if (@desired_angle - @angle).abs < ANGLE_STEP
          @angle = @desired_angle # Fractional angles
        else
          diff = @desired_angle - @angle
          sign = diff / diff.abs
          sign = sign * -1 if diff.abs > MAX_ANGLE / 2.0
          @angle += sign * ANGLE_STEP
          @angle += MAX_ANGLE if @angle < 0
          @angle -= MAX_ANGLE if @angle >= MAX_ANGLE
        end
      end
    end

    def tick_throttle
      if @desired_throttle != @throttle
        diff = @desired_throttle - @throttle
        if diff.abs < THROTTLE_STEP
          @throttle = @desired_throttle
        else
          @throttle += (diff / diff.abs) * THROTTLE_STEP
        end
      end
    end

    def tick_movement
      movement = @throttle * SPEED_FACTOR
      rad_angle = angle * Math::PI / 180
      mov_x = Math.sin(rad_angle) * movement
      mov_y = Math.cos(rad_angle) * movement * -1
      @x += mov_x
      @y += mov_y
    end

    def tick_gun
      if @desired_gun_angle != @gun_angle
        if (@desired_gun_angle - @gun_angle).abs < GUN_ANGLE_STEP
          @gun_angle = @desired_gun_angle # Fractional angles
        else
          diff = @desired_gun_angle - @gun_angle
          sign = diff / diff.abs
          sign = sign * -1 if diff.abs > MAX_GUN_ANGLE / 2.0
          @gun_angle += sign * GUN_ANGLE_STEP
          @gun_angle += MAX_GUN_ANGLE if @gun_angle < 0
          @gun_angle -= MAX_GUN_ANGLE if @gun_angle >= MAX_GUN_ANGLE
        end
      end
    end
  end
end
