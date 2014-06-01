module Rubots
  module Graphics
    class Beam
      BEAM_LENGTH = 10000 # As long as it goes out of the screen it's good
      BEAM_DURATION = 30 # For how many ticks is the beam visible

      def initialize(window, beam)
        @beam = beam
        @duration = BEAM_DURATION
        @window = window
      end

      def decay
        @duration -= 1
      end

      def expired?
        @duration <= 0
      end

      def draw
        rad_angle = @beam.angle * Math::PI / 180
        x_end = @beam.source_x + Math.sin(rad_angle) * BEAM_LENGTH
        y_end = @beam.source_y + Math.cos(rad_angle) * BEAM_LENGTH * -1
        beam_color = 0xffff0000
        @window.draw_line @beam.source_x, @beam.source_y, beam_color, x_end, y_end, beam_color
      end
    end
  end
end
