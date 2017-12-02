package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	// Entities in the game
	private var _player:Player;
	private var _grpBread:FlxTypedGroup<Bread>;

	private var _addBread:Bool = true;

	override public function create():Void
	{
		_player = new Player(20, 20);
		add(_player);

		_grpBread = new FlxTypedGroup<Bread>(1);
		_grpBread.add(new Bread());
		add(_grpBread);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.overlap(_player, _grpBread, playerTouchBread);
	}

	private function playerTouchBread(p:Player, b:Bread)
	{
		if (p.alive && p.exists && b.alive && b.exists)
		{
			b.eat();
		}
	}
}
