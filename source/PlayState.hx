package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	// Entities in the game
	private var _player:Player;
	private var _grpBread:FlxTypedGroup<Bread>;
	private var _grpEnemy:FlxTypedGroup<Enemy>;
	private var _grpCrumb:FlxTypedGroup<Crumb>;

	private var _addBread:Bool = true;

	override public function create():Void
	{
		_player = new Player(20, 20);
		add(_player);

		_grpBread = new FlxTypedGroup<Bread>(1);
		_grpBread.add(new Bread());
		add(_grpBread);

		_grpEnemy = new FlxTypedGroup<Enemy>();
		_grpEnemy.add(new Enemy(200, 200));
		add(_grpEnemy);

		_grpCrumb = new FlxTypedGroup<Crumb>();
		add(_grpCrumb);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.overlap(_player, _grpBread, playerTouchBread);

		if (_player.dropCrumb)
		{
			_player.dropCrumb = false;
			_grpCrumb.add(new Crumb(_player.x, _player.y));
		}
	}

	private function playerTouchBread(p:Player, b:Bread)
	{
		if (p.alive && p.exists && b.alive && b.exists)
		{
			b.eat();
		}
	}
}
