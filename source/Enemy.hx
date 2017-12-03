package;

import flixel.math.FlxVelocity;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Enemy extends FlxSprite
{
    public var speed:Float = 100;
    public var seesPlayer:Bool = false;
    public var playerPos:FlxPoint;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(7, 7, FlxColor.TRANSPARENT);
        drawTriangle(0, 0, 7, FlxColor.RED);
        drag.x = drag.y = 10;
        playerPos = FlxPoint.get();
    }

    override public function update(elapsed:Float):Void
    {
        if (seesPlayer)
            FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
        else
            velocity.x = velocity.y = 0;
        super.update(elapsed);
    }
}