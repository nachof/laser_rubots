Gem::Specification.new do |s|
  s.name        = 'rubots'
  s.version     = '0.2'
  s.date        = '2014-06-05'
  s.summary     = "Laser Rubots!"
  s.description = "A small simple game where you program robots to fight to the death using red lasers"
  s.author      = "Nacho Facello"
  s.email       = 'nacho@nucleartesuji.com'
  s.files       = Dir.glob('lib/**/*.rb') + Dir.glob('media/*.png') + Dir.glob('media/*.wav')
  s.executables << 'rubots'
  s.homepage    =
    'http://github.com/nachof/laser_rubots'
  s.license       = 'MIT'

  s.add_runtime_dependency 'gosu', '~> 0.7.50'
end
