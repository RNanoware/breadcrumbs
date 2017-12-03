package;

import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;

class Bread extends FlxSprite
{
    private var getNextPos:Void->FlxPoint;
    private static var _radius:Int = 7;

    public function new(positionGenerator:Void->FlxPoint)
    {
        var firstPos:FlxPoint = positionGenerator();
        super(firstPos.x, firstPos.y);
        makeGraphic(_radius * 2, _radius * 2, FlxColor.TRANSPARENT);
        drawCircle(-1, -1, -1, FlxColor.LIME);
        getNextPos = positionGenerator;
    }

    public function eat():Void
    {
        FlxTween.tween(this, { alpha: 0, y: y - 16 }, .33, { ease: FlxEase.circOut, onComplete: finishEat });
    }

    private function finishEat(_):Void
    {
        replace();
    }

    public function replace():Void
    {
        var nextPos:FlxPoint = getNextPos();
        x = nextPos.x;
        y = nextPos.y;
        nextPos.put();
        FlxTween.tween(this, { alpha: 1 }, .33, { ease: FlxEase.circIn });
    }
}