module Rubots
  module Command
    class Fire
      def apply_to(robot)
        robot.do_fire
      end
    end
  end
end
