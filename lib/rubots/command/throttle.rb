module Rubots
  module Command
    class Throttle
      def initialize(throttle)
        @throttle = throttle
        @throttle = 0 if @throttle < 0
        @throttle = Robot::MAX_THROTTLE if @throttle > Robot::MAX_THROTTLE
      end

      def apply_to(robot)
        robot.desired_throttle = @throttle
      end
    end
  end
end
