package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;

class Crumb extends FlxSprite
{
    public static var MAX_SIZE(default, null):Int = 5;

    public var destCrumb:Crumb = null;
    public var hasDest:Bool = false;
    public var size(default, null):Int = 1;

    private static var _sizeColorGradient:Array<FlxColor>;
    // The distance that a crumb will hop on each moving update
    private var _jumpDist:Float = 4;
    private var _idleTmr:Float = 0;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        _sizeColorGradient = FlxGradient.createGradientArray(1, MAX_SIZE, [FlxColor.GREEN, FlxColor.YELLOW, FlxColor.RED]);
        updateGraphic();
    }

    override public function update(elapsed:Float):Void
    {
        if (_idleTmr <= 0)
        {
            if (destCrumb != null && destCrumb.alive)
            {
                var _mp = getMidpoint();
                var _destMp = destCrumb.getMidpoint();
                velocity.x = 0;
                velocity.y = -Math.min(_jumpDist, _mp.distanceTo(_destMp));
                velocity.rotate(FlxPoint.weak(), _mp.angleBetween(_destMp));
            }
            else
                velocity.x = velocity.y = 0;
            _idleTmr = FlxG.random.float(0, 2);
        }
        _idleTmr -= elapsed;
        updateGraphic();
        super.update(elapsed);
    }

    public function cluster(that:Crumb)
    {
        size = Std.int(Math.min(size + that.size, MAX_SIZE));
        that.kill();
        hasDest = false;
    }

    private function updateGraphic()
    {
        makeGraphic(size, size, _sizeColorGradient[size - 1]);
    }
}