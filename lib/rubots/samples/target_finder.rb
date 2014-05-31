module Rubots
  module Samples
    # Homes into the center of the map, then stays there, points up, and aims down.
    class TargetFinder < Strategy
      ANGLE_DOWN  = 180
      ANGLE_UP    = 0
      ANGLE_LEFT  = 270
      ANGLE_RIGHT = 90

      def initialize(map, me, targets)
        @finding = :x
        @map = map
        @find_x = map.width / 2
        @find_y = map.height / 2
      end

      def command(me, targets)
        if @finding == :x
          find_x(me)
        elsif @finding == :y
          find_y(me)
        elsif me.angle != 0
          rotate_to 0
        else
          rotate_gun_to 180
        end
      end

      def find_x(me)
        if me.x > @find_x && me.angle != ANGLE_LEFT
          rotate_to ANGLE_LEFT
        elsif me.x < @find_x && me.angle != ANGLE_RIGHT
          rotate_to ANGLE_RIGHT
        elsif me.x != @find_x
          if (@find_x - me.x).abs > 50
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
        if me.y > @find_y && me.angle != ANGLE_UP
          rotate_to ANGLE_UP
        elsif me.y < @find_y && me.angle != ANGLE_DOWN
          rotate_to ANGLE_DOWN
        elsif me.y != @find_y
          if (@find_y - me.y).abs > 50
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
