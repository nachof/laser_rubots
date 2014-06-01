module Rubots
  module Graphics
    class Window < Gosu::Window
      def initialize(game)
        @game = game
        super Game::MAP_WIDTH, Game::MAP_HEIGHT, false
        self.caption = "LASER RUBOTS PEW PEW PEW"
        @robots = @game.robots.map { |r| Robot.new self, r }
        @beams = []
      end

      def update
        @game.tick
        @beams += @game.laser_beams.map { |b| Beam.new self, b }
        decay_beams
      end

      def draw
        @robots.each &:draw
        @beams.each &:draw
      end

    private

      def decay_beams
        @beams.each(&:decay)
        @beams.reject!(&:expired?)
      end
    end
  end
end
