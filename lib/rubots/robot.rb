require 'ostruct'

module Rubots
  class Robot
    attr_reader :x, :y, :angle, :gun_angle
    attr_writer :desired_angle, :desired_throttle

    # Some constants
    MAX_ANGLE     = 360 # Maximum angle. Wraps around to zero after this.
    ANGLE_STEP    = 1   # How much we change angle each tick.

    MAX_THROTTLE  = 10  # Max throttle. Can't go above.
    THROTTLE_STEP = 1   # How much we change throttle each tick.

    SPEED_FACTOR  = 1   # How much movement does each throttle step represent


    def initialize(strategy_class, x, y)
      @x = x
      @y = y
      @throttle  = @desired_throttle  = 0.0
      @angle     = @desired_angle     = 0.0
      @gun_angle = @desired_gun_angle = 0.0

      @strategy = strategy_class.new(robot_data, nil)
    end

    def tick
      command = @strategy.command(robot_data, nil)
      command.apply_to(self) if command
      tick_angle
      tick_throttle
      tick_movement
    end

  private

    def robot_data
      OpenStruct.new x: @x, y: @y, angle: @angle, throttle: @throttle, gun_angle: @gun_angle
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
  end
end
