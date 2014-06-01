require 'gosu'
require 'rubots/graphics'
require 'rubots/game'
require 'rubots/robot'
require 'rubots/command'
require 'rubots/beam'
require 'rubots/strategy'
require 'rubots/samples'

module Rubots
  def self.run_game
    game = Game.new

    Graphics::Window.new(game).show
  end
end
