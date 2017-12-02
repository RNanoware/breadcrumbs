package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Enemy extends FlxSprite
{
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(7, 7, FlxColor.TRANSPARENT);
        drawTriangle(0, 0, 7, FlxColor.RED);
    }
}