package;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Player extends FlxSprite
{
    public var speed:Float = 150;
    public var dropCrumb:Bool = false;

    private var _drag:Float = 1600;
    private var _distSinceCrumb:Float = 0;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(2, 2, FlxColor.WHITE);
        drag.x = drag.y = _drag;
    }

    override public function update(elapsed:Float):Void
    {
        movement();
        checkCrumbDrop(elapsed);
        super.update(elapsed);
    }

    private function movement():Void
    {
        var _up:Bool = FlxG.keys.anyPressed([UP, W]);
        var _down:Bool = FlxG.keys.anyPressed([DOWN, S]);
        var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
        var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

        // We can't move in two opposing directions at once
        if (_up && _down)
            _up = _down = false;
        if (_left && _right)
            _left = _right = false;

        if (_up || _down || _left || _right)
        {
            var angle:Float = 0;
            if (_up)
            {
                angle = -90;
                if (_left)
                    angle -= 45;
                else if (_right)
                    angle += 45;
            }
            else if (_down)
            {
                angle = 90;
                if (_left)
                    angle += 45;
                else if (_right)
                    angle -= 45;
            }
            else if (_left)
                angle = 180;
            else if (_right)
                angle = 0;

            velocity.x = speed;
            velocity.y = 0;
            velocity.rotate(FlxPoint.weak(0, 0), angle);
        }
    }

    private function checkCrumbDrop(elapsed:Float):Void
    {
        _distSinceCrumb += elapsed * velocity.distanceTo(FlxPoint.weak(0, 0));
        if (_distSinceCrumb > 100)
        {
            _distSinceCrumb = 0;
            dropCrumb = true;
        }
    }
}