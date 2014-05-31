module Rubots
  class Game
    attr_reader :robots
    MAP_HEIGHT = 700
    MAP_WIDTH  = 1000

    def initialize
      #@robots = [Robot.new(Samples::Rotator, *random_location), Robot.new(Samples::SittingDuck, *random_location), Robot.new(Samples::TargetFinder, *random_location)]
      @robots = [Robot.new(Samples::TargetFinder, *random_location)]
    end

    def tick
      @robots.each do |robot|
        robot.tick
      end
    end

  private

    # TODO enforce separation
    def random_location
      x = rand(MAP_WIDTH)
      y = rand(MAP_HEIGHT)
      [x, y]
    end

  end
end
