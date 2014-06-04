module Rubots
  class Beam
    attr_reader :source_x, :source_y, :angle

    def initialize(source_x, source_y, angle)
      @source_x = source_x
      @source_y = source_y
      @angle = angle
    end

    def self.from(robot)
      real_angle = (robot.angle + robot.gun_angle) % 360
      new robot.x, robot.y, real_angle
    end

    def check_hit(robot)
      if found_hit?(robot)
        robot.destroy
        puts "#{robot.name} hit by laser"
      end
    end

    # Laser beam is:
    # (x - x0) = tan(angle)(y0 - y)
    # We check for X:
    # x = tan(angle)(y0 - y) + x0
    # We check for Y
    # y = (x0 - x)/tan(angle) - y0
    HIT_THRESHOLD = 16
    def found_hit?(robot)
      return false if robot.x == @source_x && robot.y == @source_y # Avoid hitting self

      # Check we're pointing to the right quadrant
      return false if robot.x > @source_x && (@angle > 190 && @angle < 350)
      return false if robot.x < @source_x && (@angle < 170 && @angle >  10)
      return false if robot.y > @source_y && (@angle > 280 || @angle <  80)
      return false if robot.y < @source_y && (@angle < 260 && @angle > 100)

      tan_angle = Math.tan(@angle * Math::PI / 180)

      test_x = tan_angle * (@source_y - robot.y) + @source_x
      return true if (test_x - robot.x).abs < HIT_THRESHOLD

      test_y = (@source_x - robot.x)/tan_angle - @source_y
      (test_y - robot.y).abs < HIT_THRESHOLD
    end
  end
end
