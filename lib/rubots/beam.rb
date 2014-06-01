module Rubots
  class Beam
    attr_reader :source_x, :source_y, :angle

    def initialize(source_x, source_y, angle)
      @source_x = source_x
      @source_y = source_y
      @angle = angle
    end
  end
end
