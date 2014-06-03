require 'gosu'
require 'rubots/graphics'
require 'rubots/game'
require 'rubots/robot'
require 'rubots/command'
require 'rubots/beam'
require 'rubots/strategy'
require 'rubots/strategy_loader'
require 'rubots/samples'

module Rubots
  def self.run_game(params)
    game = Game.new StrategyLoader.load(params)

    Graphics::Window.new(game).show
  end
end
