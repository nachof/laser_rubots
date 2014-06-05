# Laser Rubots

## What's this?

Laser Rubots is a small game where you program a robot to do battle with other robots, armed with red lasers.

## How do I install it?

    gem install rubots

## How does it work?

You need to create a class that inherits from Rubots::Strategy and implements the command method. Once you have that, save it in a file that matches the name of the class. For example, if your class is called Test, save it in test.rb

## Can you give me an example?

There's a few (poorly written) examples in the lib/rubots/samples directory. But if you want a quick view of how a robot strategy would look:

    class SimpleBot < Rubots::Strategy
      def name
        "Simple Robot"
      name

      def command(me, targets)
        rotate_gun_to targets.first.angle
        fire
      end
    end

This robot will just sit there, attempt to rotate its gun towards the first enemy in the list, and then fire. It will do this every time, and it will keep firing until it fires in the right direction and hits an enemy.

## Alright, how can I see that in action?

You need to run the rubots command:

    rubots <robot1> <robot2> ...

You can place however many robots you want. You will need at least two, of course. You can either place multiple copies of the same robot, or you can use some of the sample robots included. Let's do that last one. Save the SimpleBot code as simple\_bot.rb and run:

    rubots simple_bot.rb sample:sitting_duck

The sitting duck sample robot will just sit there and do nothing. Good for target practice. If you want to see multiple of those, you can do:

    rubots simple_bot.rb sample:sitting_duck sample:sitting_duck sample:sitting_duck

## Good, but what else can my robot do?

Just firing is boring. You will want to probably move around. In particular since if you don't, you're an easy target.

### A little more detail on how robots work.

When a command is needed for the robot, your Strategy subclass will receive a call to the command method, with parameters giving details on your own position and status and also on other robots positions relative to you. For each command you want to give your robot you will need to call one of the methods provided by Strategy. If you call more than one, they will be queued and executed in succession. Keep in mind that most commands don't have an immediate effect, and also some of them have a cooldown period.

### The map

The game map is a featureless rectangular area. Its dimensions are given to you on Strategy initialization. The first parameter to Strategy.new will be a map structure with width and height values. Graphically, the map is drawn with (0, 0) on the top left. Try no to leave the designated area, or your robot will just explode against the invisible wall that surrounds the arena.

Angles are given in degrees, with zero degrees being either "forward from my robot" (when seeing targets, and when aiming) or "top direction" (when rotating your robot).

### Commands

#### Rotating your robot

If you want to look in direction other than top, you will need to issue the rotate\_to command:

    rotate_to angle

This command will instruct the robot to start rotating to the specified angle. The change in direction is not instantaneous, it will happen over time.

The angle is given in degrees, and 0 is "straight up" (pointing in the direction of negative Y), and it grows clockwise.

#### Moving

Your robot moves always forward. The speed is given by the throttle command:

    throttle speed

The speed is a number between 0 and 10. If you give a lower number, it will be set to 0, and if you give a higher than 10 number, it will be set to 10. As with rotation, this is not an immediate change. Your robot will accelerate or decelerate until it reaches the desired speed.

#### Aiming

You could just fire straight ahead, but where's the fun in that? You can rotate your gun with the rotate\_gun\_to command.

    rotate_gun_to gun_angle

The gun angle is given relative to your robot's direction. Zero degrees is straight ahead, 90 degrees is pointing to the right, 180 degrees is pointing backwards, and 270 degrees is to your left. You can probably figure out any other angle on your own.

As with the robot's rotation, this is not an instantaneous change. It will take time for the gun to reach the desired position.

#### FIRE!

If you want to destroy other robots (and who wouldn't?) just pointing at them in a menacing fashion won't do. You'll need to actually fire. To do that use the fire command:

    fire

No parameters. Simple, isn't it? That will fire a laser beam (red, currently, but maybe in the future you can personalize your laser color) that will destroy everything in its path. The beam will be in the direction your gun is pointing, so aim carefully.

After firing, the robot's systems need a second to recover, so there is a cooldown of 60 cycles (which is about a second in real time) before you can issue another command. Keep that in mind.

#### Do nothing

If you want to do nothing for a cycle, you can just not call any of the above methods. If, for some reason, you want to be very explicit about doing nothing, just call:

    do_nothing

That will do nothing, as expected.

### Seeing your surroundings

When the command method is called, you're passed two parameters.

The first parameter will give you information about your robot.

    me.x         # Your X position
    me.y         # Your Y position
    me.angle     # Your current heading
    me.throttle  # Your current throttle
    me.gun_angle # Where you're pointing your deadly cannons at

The second parameter will be an array with information about the other robots in the map.

    targets.first.name     # The name of the other robot.
    targets.first.distance # How far away from you it is.
    targets.first.angle    # In which direction, relative to you (0 is straight ahead)

## Winning the game

The game is won by the last robot left alive.

There's three main ways a robot can die: by colliding with another robot, by hitting the invisible wall surrounding the map area, or by being hit with a laser.

Once only one robot is left, he's declared the winner, and the game pauses for a moment to let you see the end result. If no survivors are left, then nobody wins.

## Loading robots

You can load any number of robots, but it's probably not wise to do it with numbers over 10.

To specify a robot, you can pass the file as a parameter to the rubots command. To do that, just write:

    rubots filename1.rb filename2.rb ...

The Strategy class name must match the file name. So if your class is DeathToAllHumans, you should save it in a file called death\_to\_all\_humans.rb.

If you want, you can try the few included samples. They don't do much, but they can serve as target practice. You should be able to beat them easily. The included samples are:

    sitting_duck  # Stays in place, waiting to be shot
    rotator       # Rotates 90 degrees right, then left, then right, and so on
    target_finder # Attempts to move to the center of the map. Doesn't work well.
    artillery     # Rotates 90 degrees right, then aims and fires at targets.

To load a sample, specify it as sample:name. For example:

    rubots sample:artillery sample:sitting_duck

If you want multiple copies of a single robot, you can use the n\*robotname format:

    rubots 5*sample:artillery 3*test_bot.rb

That will load five artillery sample robots, and 3 TestBot robots from the test\_bot.rb file.

## License and sources

You can use and modify this code all you want. See the LICENSE file for details, but it's the MIT license, so you probably already know how it works.

The images used in the game were taken from the internet, and to the best of my knowledge they're public domain (they're marked as such, at least). If you want bigger versions, look here:

    Robot: https://openclipart.org/detail/191077/green-spaceship-by-scout-191077
    Explosion: https://openclipart.org/detail/122959/pow-by-viscious-speed
    Cannon: https://openclipart.org/detail/172792/spaceship-cannon-by-jamiely-172792

The laser beam sound sample was recorded by me, and it's free for use by anybody who wants to avoid their girlfriends laughing at them, like mine did while I recorded it.
