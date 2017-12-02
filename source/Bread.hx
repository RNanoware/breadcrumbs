package;

import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;

class Bread extends FlxSprite
{
    private static var _radius:Int = 7;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(_radius * 2, _radius * 2, FlxColor.TRANSPARENT);
        drawCircle(-1, -1, -1, FlxColor.LIME);
        replace();
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
        x = Math.random() * FlxG.width;
        y = Math.random() * FlxG.height;
        alpha = 1;
    }
}