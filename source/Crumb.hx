package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Crumb extends FlxSprite
{
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(1, 1, FlxColor.GREEN);
    }
}