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
      check_collisions
      check_beam_hits
      clean_up_bodies
    end

    def map
      OpenStruct.new width: MAP_WIDTH, height: MAP_HEIGHT
    end

    def laser_fire(beam)
      @laser_beams << beam
    end

  private

    # TODO enforce separation
    def random_location
      x = rand(MAP_WIDTH)
      y = rand(MAP_HEIGHT)
      [x, y]
    end

    COLLISION_DISTANCE = 32
    def check_collisions
      @robots.each do |r1|
        @robots.each do |r2|
          next if r1 == r2
          r1.destroy if r1.distance_to(r2) < COLLISION_DISTANCE
        end
      end
    end

    def check_beam_hits
      # TODO
    end

    def clean_up_bodies
      @robots.reject!(&:destroyed?)
    end

  end
end
