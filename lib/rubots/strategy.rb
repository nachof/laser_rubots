module Rubots
  class Strategy
    def initialize(me, targets)
    end

    # Command is called when we need to get a command from the robot.
    # It should return a Command. We'll provide helper methods for that.
    def command(me, targets)
      # Implement in subclass
    end

    protected

    def rotate_to(angle)
      Command::RotateTo.new(angle)
    end

    def throttle(throttle)
      Command::Throttle.new(throttle)
    end

    def do_nothing
      nil
    end
  end
end
