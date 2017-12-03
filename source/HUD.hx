package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
    private var _sprBack:FlxSprite;
    private var _sprBread:FlxSprite;
    private var _txtBread:FlxText;

    public function new()
    {
        super();
        _sprBack = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
        _txtBread = new FlxText(0, 2, 0, "0", 8);
        _sprBread = new FlxSprite(FlxG.width - 12, 4);
        _sprBread.makeGraphic(Bread.RADIUS * 2, Bread.RADIUS * 2, FlxColor.TRANSPARENT);
        _sprBread.drawCircle(-1, -1, -1, FlxColor.LIME);
        _txtBread.x = _sprBread.x - _txtBread.width - 4;
        _txtBread.alignment = RIGHT;

        add(_sprBack);
        add(_sprBread);
        add(_txtBread);
    }
}