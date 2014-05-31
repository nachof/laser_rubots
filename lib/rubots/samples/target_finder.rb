module Rubots
  module Samples
    class TargetFinder < Strategy
      FIND_X = 500
      FIND_Y = 350

      ANGLE_DOWN  = 180
      ANGLE_UP    = 0
      ANGLE_LEFT  = 270
      ANGLE_RIGHT = 90

      def initialize(me, targets)
        @finding = :x
      end

      def command(me, targets)
        if @finding == :x
          find_x(me)
        elsif @finding == :y
          find_y(me)
        else
          do_nothing
        end
      end

      def find_x(me)
        if me.x > FIND_X && me.angle != ANGLE_LEFT
          rotate_to ANGLE_LEFT
        elsif me.x < FIND_X && me.angle != ANGLE_RIGHT
          rotate_to ANGLE_RIGHT
        elsif me.x != FIND_X
          if (FIND_X - me.x).abs > 50
            throttle 4
          else
            throttle 1
          end
        else # At pos x
          @finding = :y
          throttle 0
        end
      end

      def find_y(me)
        if me.y > FIND_Y && me.angle != ANGLE_UP
          rotate_to ANGLE_UP
        elsif me.y < FIND_Y && me.angle != ANGLE_DOWN
          rotate_to ANGLE_DOWN
        elsif me.y != FIND_Y
          if (FIND_Y - me.y).abs > 50
            throttle 5
          else
            throttle 1
          end
        else # At pos y
          @finding = :none
          throttle 0
        end
      end
    end
  end
end
