module Rubots
  module Samples
    # Points at a target and fires a single shot.
    class Artillery < Strategy
      def initialize(map, me, targets)
        @fired = false
      end

      def command(me, targets)
        if me.angle != 90
          rotate_to 90
        elsif me.gun_angle != targets.first.angle
          rotate_gun_to targets.first.angle
        else
          unless @fired
            @fired = true
            fire
          else
            do_nothing
          end
        end
      end

      def name
        "Artillery"
      end
    end
  end
end
