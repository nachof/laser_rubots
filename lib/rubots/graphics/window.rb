module Rubots
  module Graphics
    class Window < Gosu::Window
      def initialize(game)
        @game = game
        super Game::MAP_WIDTH, Game::MAP_HEIGHT, false
        self.caption = "LASER RUBOTS PEW PEW PEW"
        @robots = @game.robots.map { |r| Robot.new self, r }
      end

      def update
        @game.tick
      end

      def draw
        @robots.each &:draw
      end
    end
  end
end
