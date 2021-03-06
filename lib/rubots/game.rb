module Rubots
  class Game
    attr_reader :robots, :laser_beams
    MAP_HEIGHT = 700
    MAP_WIDTH  = 1000
    CELL_SIZE  = 40 # Positioning cell

    def initialize(robots)
      @robots = robots.map { |klass| Robot.new(klass, self, *random_location) }
    end

    def tick
      @laser_beams = []
      @robots.each { |robot| robot.process_command }
      @robots.each { |robot| robot.tick            }
      check_collisions
      check_out_of_area
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

    def random_location
      x_cells = MAP_WIDTH  / CELL_SIZE
      y_cells = MAP_HEIGHT / CELL_SIZE
      @taken ||= []
      begin
        pair = [rand(x_cells), rand(y_cells)]
      end while @taken.include?(pair)
      @taken << pair
      pair.map { |coord| coord * CELL_SIZE + CELL_SIZE / 2 }
    end

    COLLISION_DISTANCE = 32
    def check_collisions
      @robots.each do |r1|
        @robots.each do |r2|
          next if r1 == r2
          if r1.distance_to(r2) < COLLISION_DISTANCE
            r1.destroy
            puts "#{r1.name} destroyed by collision with #{r2.name}"
          end
        end
      end
    end

    def check_beam_hits
      @laser_beams.each do |beam|
        @robots.each { |robot| beam.check_hit robot }
      end
    end

    def check_out_of_area
      @robots.each do |r|
        if r.x > MAP_WIDTH || r.y > MAP_HEIGHT || r.x < 0 || r.y < 0
          r.destroy
          puts "#{r.name} hit the invisible wall and was destroyed"
        end
      end
    end

    def clean_up_bodies
      @robots.reject!(&:destroyed?)
    end

  end
end
