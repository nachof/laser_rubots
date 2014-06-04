module Rubots
  class Game
    attr_reader :robots, :laser_beams
    MAP_HEIGHT = 700
    MAP_WIDTH  = 1000

    def initialize(robots)
      @robots = robots.map { |klass| Robot.new(klass, self, *random_location) }
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

    def over?
      @robots.count <= 1
    end

    def winner
      return nil unless over?

      @robots.first || OpenStruct.new(name: "Nobody")
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
      @laser_beams.each do |beam|
        @robots.each { |robot| beam.check_hit robot }
      end
    end

    def clean_up_bodies
      @robots.reject!(&:destroyed?)
    end

  end
end
