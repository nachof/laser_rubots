module Rubots
  module Command
    class RotateGunTo < Base
      def initialize(angle)
        @angle = angle % Robot::MAX_GUN_ANGLE
      end

      def apply_to(robot)
        robot.desired_gun_angle = @angle
      end
    end
  end
end

