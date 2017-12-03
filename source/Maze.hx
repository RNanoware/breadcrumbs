package;

import flixel.math.FlxPoint;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;

private class Cell
{
    public var right:Bool = false;
    public var down:Bool = true;
    public var X:Int;
    public var Y:Int;
    public var set:Array<Cell> = null;

    public function new(X:Int, Y:Int)
    {
        this.X = X;
        this.Y = Y;
    }
}

class Maze extends FlxTilemap
{
    private static var _mazeData:Array<Array<Int>> = [
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		[1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
		[1, 0, 0, 1, 1, 1, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 1, 1, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
	];

    private var _rand:FlxRandom;

    public function new(width:Int, height:Int)
    {
        super();
        loadMapFrom2DArray(create(width, height), FlxGraphic.fromRectangle(32, 16, FlxColor.GRAY));
        _rand = new FlxRandom();
    }

    public function getRandEmpty():FlxPoint
    {
        return getTileCoordsByIndex(_rand.getObject(getTileInstances(0)), false);
    }

    private static function create(width:Int, height:Int):Array<Array<Int>>
    {
        // var mazeData:Array<Array<Int>> = [for (x in 0...height * 2 + 1) [for (y in 0...width * 2 + 1) 0]];
        return _mazeData;
    }

    // Every cell without a set is given a new set with just itself
    private static function makeSet(row:Array<Cell>):Array<Cell>
    {
        for (cell in row)
            if (cell.set == null)
                cell.set = [cell];
        return row;
    }

    private static function makeRightWalls(row:Array<Cell>):Array<Cell>
    {
        for (cell in row)
        {
            if (false)
                continue;
        }
        return row;
    }
}