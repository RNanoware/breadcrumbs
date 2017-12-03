package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAxes;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;

class GameOverState extends FlxState
{
    private var _bread:Int;

    private var _txtMsg:FlxText;
    private var _txtBread:FlxText;
    private var _sprBread:FlxSprite;

    public function new(bread:Int)
    {
        super();
        _bread = bread;
    }

    override public function create():Void
    {
        _txtMsg = new FlxText(0, 20, 0, "Game Over", 22);
        _txtMsg.alignment = CENTER;
        _txtMsg.screenCenter(FlxAxes.X);
        add(_txtMsg);

        _sprBread = new FlxSprite(FlxG.width/2 - 8, 0);
        _sprBread.makeGraphic(Bread.RADIUS * 2, Bread.RADIUS * 2, FlxColor.TRANSPARENT);
        _sprBread.drawCircle(-1, -1, -1, FlxColor.LIME);
        _sprBread.screenCenter(FlxAxes.Y);
        add(_sprBread);

        _txtBread = new FlxText(FlxG.width/2, 0, 0, Std.string(_bread), 8);
        _txtBread.screenCenter(FlxAxes.Y);
        add(_txtBread);

        super.create();
    }
}