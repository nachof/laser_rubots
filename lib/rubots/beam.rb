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
  end
end
