module Rubots
  module Command
    class RotateTo < Base
      def initialize(angle)
        @angle = angle % Robot::MAX_ANGLE
      end

      def apply_to(robot)
        robot.desired_angle = @angle
      end
    end
  end
end
