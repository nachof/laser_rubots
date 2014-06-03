module Rubots
  module Command
    class Fire < Base
      def apply_to(robot)
        robot.do_fire
      end

      def cooldown
        60
      end
    end
  end
end
