module Rubots
  module Samples
    # Rotates in place direction
    class Rotator < Strategy
      def initialize(map, me, targets)
        @direction = :left
      end

      def command(me, targets)
        if @direction == :left
          @direction = :right if me.angle == 270
          rotate_to 270
        else
          @direction = :left if me.angle == 89
          rotate_to 89
        end
      end
    end
  end
end
