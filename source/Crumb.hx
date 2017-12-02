package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Crumb extends FlxSprite
{
    public var destPos(default, null):FlxPoint;
    public var hasDest:Bool = false;

    // The distance that a crumb will hop on each moving update
    private var _jumpDist:Float = 4;
    private var _idleTmr:Float = 0;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(1, 1, FlxColor.GREEN);
        destPos = new FlxPoint();
    }

    override public function update(elapsed:Float):Void
    {
        if (_idleTmr <= 0)
        {
            if (hasDest)
            {
                var _mp = getMidpoint();
                var _offset = FlxPoint.get(0, -Math.min(_jumpDist, _mp.distanceTo(destPos)));
                _offset.rotate(FlxPoint.weak(), _mp.angleBetween(destPos));
                x += _offset.x;
                y += _offset.y;
                _offset.put();
            }
            _idleTmr = FlxG.random.float(0, 2);
        }
        _idleTmr -= elapsed;
        super.update(elapsed);
    }
}