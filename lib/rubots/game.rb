module Rubots
  class Game
    attr_reader :robots, :laser_beams
    MAP_HEIGHT = 700
    MAP_WIDTH  = 1000

    def initialize
      @robots = [
        Robot.new(Samples::Rotator,      self, *random_location),
        Robot.new(Samples::SittingDuck,  self, *random_location),
        Robot.new(Samples::TargetFinder, self, *random_location),
        Robot.new(Samples::Artillery,    self, *random_location),
      ]
    end

    def tick
      @laser_beams = []
      @robots.each { |robot| robot.tick      }
      @robots.each { |robot| robot.tick_fire }
    end

    def map
      OpenStruct.new width: MAP_WIDTH, height: MAP_HEIGHT
    end

    def laser_fire(source_robot)
      @laser_beams << Beam.new(source_robot.x, source_robot.y, source_robot.gun_angle)
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
