package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

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

		_grpCrumb.forEachAlive(setClosestCrumb);
	}

	private function playerTouchBread(p:Player, b:Bread)
	{
		if (p.alive && p.exists && b.alive && b.exists)
		{
			b.eat();
		}
	}

	private function setClosestCrumb(thisC:Crumb):Void
	{
		if (_grpCrumb.length > 1)
		{
			var _closestDist:Float = Math.POSITIVE_INFINITY;
			var _closestPoint:FlxPoint = FlxPoint.get();
			var _thisPoint:FlxPoint = thisC.getMidpoint();
			var _thatPoint:FlxPoint;
			for (thatC in _grpCrumb)
			{
				if (thisC != thatC)
				{
					_thatPoint = thatC.getMidpoint();
					var _dist = _thisPoint.distanceTo(_thatPoint);
					if (_closestDist > _dist)
					{
						_closestDist = _dist;
						_closestPoint.copyFrom(_thatPoint);
					}
				}
			}
			thisC.destPos.copyFrom(_closestPoint);
			_closestPoint.put();
			thisC.hasDest = true;
		}
	}
}
