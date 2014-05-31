module Rubots
  module Graphics
    class Robot
      Z_AXIS = 10

      def initialize(window, robot)
        @robot = robot
        @window = window
        @image     = Gosu::Image.new(window, "media/robot.png", false)
        @gun_image = Gosu::Image.new(window, "media/gun.png", false)
      end

      def draw
        @image.draw_rot(@robot.x, @robot.y, Z_AXIS, @robot.angle)
        @gun_image.draw_rot(@robot.x, @robot.y, Z_AXIS + 1, @robot.angle + @robot.gun_angle)
      end
    end
  end
end
