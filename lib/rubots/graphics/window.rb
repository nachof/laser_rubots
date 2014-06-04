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

      GAME_END_TICKS = 150
      def update
        if !@game_over
          @game.tick
          @beams += @game.laser_beams.map { |b| Beam.new self, b }
          decay_beams
          @game_over = @game.over?
        else
          @game_over_countdown ||= GAME_END_TICKS
          @game_over_countdown -= 1
          if @game_over_countdown == 0
            puts "#{@game.winner.name} wins the game."
            exit
          end
        end

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
