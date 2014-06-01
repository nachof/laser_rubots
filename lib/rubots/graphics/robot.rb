module Rubots
  module Graphics
    class Robot
      Z_AXIS = 10

      def initialize(window, robot)
        @robot = robot
        @image      = Gosu::Image.new(window, "media/robot.png", false)
        @gun_image  = Gosu::Image.new(window, "media/gun.png", false)
        @dead_image = Gosu::Image.new(window, "media/deadbot.png", false)
        @font       = Gosu::Font.new(window, Gosu::default_font_name, 14)
      end

      def draw
        if @robot.destroyed?
          @dead_image.draw_rot(@robot.x, @robot.y, Z_AXIS, 0)
        else
          @image.draw_rot(@robot.x, @robot.y, Z_AXIS, @robot.angle)
          @gun_image.draw_rot(@robot.x, @robot.y, Z_AXIS + 1, @robot.angle + @robot.gun_angle)
        end
        @font.draw_rel(@robot.name, @robot.x, @robot.y + 20, Z_AXIS + 2, 0.5, 1.0, 1.0, 1.0, 0xffffff00)
      end
    end
  end
end
