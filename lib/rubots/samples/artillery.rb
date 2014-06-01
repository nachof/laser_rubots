module Rubots
  module Samples
    class Artillery < Strategy
      def command(me, targets)
        puts targets.inspect
        rotate_gun_to targets.first.angle
      end

      def name
        "Artillery"
      end
    end
  end
end
