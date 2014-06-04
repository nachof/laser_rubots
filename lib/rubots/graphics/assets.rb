module Rubots
  module Graphics
    class Assets
      MEDIA_DIR = File.join(File.dirname(__FILE__), '..', '..', '..', 'media')
      PEW_SOUND = File.join(MEDIA_DIR, "pew.wav")
      ROBOT_IMG = File.join(MEDIA_DIR, "robot.png")
      GUN_IMG   = File.join(MEDIA_DIR, "gun.png")
      DEAD_IMG  = File.join(MEDIA_DIR, "deadbot.png")
    end
  end
end
