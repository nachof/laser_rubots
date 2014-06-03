module Rubots
  class Strategy
    def initialize(map, me, targets)
    end

    # Called by the Robot to get a command
    def get_command(me, targets)
      @command_queue ||= []
      command(me, targets) if @command_queue.empty?
      @command_queue.shift || Command::DoNothing.new
    end

    # When get_command is out of commands, it calls this, which will queue commands
    def command(me, targets)
      # Implement in subclass
    end

    def name
      "Unnamed robot"
    end

    protected

    def rotate_to(angle)
      @command_queue << Command::RotateTo.new(angle)
    end

    def rotate_gun_to(angle)
      @command_queue << Command::RotateGunTo.new(angle)
    end

    def throttle(throttle)
      @command_queue << Command::Throttle.new(throttle)
    end

    def fire
      @command_queue << Command::Fire.new
    end

    def do_nothing
      @command_queue << Command::DoNothing.new
    end
  end
end
