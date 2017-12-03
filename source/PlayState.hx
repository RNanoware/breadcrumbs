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
	private var _maze:Maze;

	override public function create():Void
	{
		_player = new Player(20, 20);
		add(_player);

		_maze = new Maze(10, 10);
		add(_maze);

		_grpBread = new FlxTypedGroup<Bread>(1);
		_grpBread.add(new Bread(_maze.getRandEmpty));
		add(_grpBread);

		_grpEnemy = new FlxTypedGroup<Enemy>();
		add(_grpEnemy);

		_grpCrumb = new FlxTypedGroup<Crumb>();
		add(_grpCrumb);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.overlap(_player, _grpBread, playerTouchBread);
		FlxG.overlap(_grpCrumb, _grpCrumb, crumbCollide);

		FlxG.collide(_player, _maze);
		FlxG.collide(_grpEnemy, _maze);
		FlxG.collide(_grpCrumb, _maze);

		if (_player.dropCrumb)
		{
			_player.dropCrumb = false;
			_grpCrumb.add(new Crumb(_player.x, _player.y));
		}

		_grpCrumb.forEachAlive(setClosestCrumb);
		_grpEnemy.forEachAlive(checkEnemyVision);
	}

	private function playerTouchBread(p:Player, b:Bread)
	{
		if (p.alive && p.exists && b.alive && b.exists)
		{
			b.eat();
		}
	}

	private function crumbCollide(c1:Crumb, c2:Crumb)
	{
		c1.cluster(c2);
		if (c1.size >= Crumb.MAX_SIZE)
		{
			_grpEnemy.add(new Enemy(c1.x, c1.y));
			c1.kill();
		}
	}

	private function setClosestCrumb(thisC:Crumb):Void
	{
		if (_grpCrumb.length > 1)
		{
			var _closestDist:Float = Math.POSITIVE_INFINITY;
			var _closestCrumb:Crumb = null;
			var _thisPoint:FlxPoint = thisC.getMidpoint();
			var _thatPoint:FlxPoint;
			_grpCrumb.forEachAlive(function(thatC) {
				if (thisC != thatC)
				{
					_thatPoint = thatC.getMidpoint();
					if (_maze.ray(_thisPoint, _thatPoint)) // Return false if wall is hit
					{
						var _dist = _thisPoint.distanceTo(_thatPoint);
						if (_closestDist > _dist)
						{
							_closestDist = _dist;
							_closestCrumb = thatC;
						}
					}
				}
			});
			thisC.destCrumb = _closestCrumb;
		}
	}

	private function checkEnemyVision(e:Enemy):Void
	{
		if (_maze.ray(_player.getMidpoint(), e.getMidpoint()))
		{
			e.seesPlayer = true;
			e.playerPos.copyFrom(_player.getMidpoint());
		}
		else
			e.seesPlayer = false;
	}
}
