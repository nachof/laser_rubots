module Rubots
  class StrategyLoader
    def self.load(params)
      return default_lineup unless params.any?

      params.map { |p| new(p).strategy_class }
    end

    def self.default_lineup
      [ Samples::Rotator, Samples::SittingDuck, Samples::TargetFinder,
        Samples::Artillery ]
    end

    def initialize(name)
      @name = name
    end

    def strategy_class
      if is_sample?
        sample_class
      else
        class_from_file
      end
    end

  private

    def class_from_file
      load @name

      class_name = camelize(File.basename(@name, ".rb"))
      Rubots.const_get(class_name)
    end

    def is_sample?
      @name.match /^sample:/
    end

    def sample_class
      Samples.const_get(camelize(@name.split(':').last))
    end

    def camelize(term)
      string = term.to_s
      string = string.sub(/^[a-z\d]*/) { $&.capitalize }
      string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
      string.gsub!('/', '::')
      string
    end
  end
end
