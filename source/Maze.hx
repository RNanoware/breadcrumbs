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
    public var set:Array<Cell> = null;

    public function new()
    {}
}

class Maze extends FlxTilemap
{
    private static var _rand:FlxRandom = new FlxRandom();

    public function new(width:Int, height:Int)
    {
        super();
        loadMapFrom2DArray(create(width, height), FlxGraphic.fromRectangle(32, 16, FlxColor.GRAY));
    }

    public function getRandEmpty():FlxPoint
    {
        return getTileCoordsByIndex(_rand.getObject(getTileInstances(0)), false);
    }

    private static function create(width:Int, height:Int):Array<Array<Int>>
    {
        var mazeData:Array<Array<Int>> = [for (y in 0...height * 2 + 1) [for (x in 0...width * 2 + 1) 0]];
        var cellRow:Array<Cell> = [for (x in 0...width) new Cell()];
        for (y in 0...height)
        {
            makeSet(cellRow);
            makeRightWalls(cellRow);
            makeDownWalls(cellRow);
            if (y == height - 1)
                endRow(cellRow);
            cellsToMazeRow(cellRow, mazeData, y);
            if (y != height - 1)
                initNextRow(cellRow);
        }
        // Create the upper-left walls
        for (i in 0...mazeData[0].length) mazeData[0][i] = mazeData[height*2][i] = 1;
        for (i in 0...mazeData.length) mazeData[i][0] = mazeData[i][width*2] = 1;
        // Fill in "corner wall" gaps
        for (j in 1...height)
            for (i in 1...width)
                mazeData[i*2][j*2] = 1;
        return mazeData;
    }

    // Every cell without a set is given a new set with just itself
    private static function makeSet(row:Array<Cell>):Void
    {
        for (cell in row)
            if (cell.set == null)
                cell.set = [cell];
    }

    // Keep already-connected regions separate; randomly merge disconnected regions
    private static function makeRightWalls(row:Array<Cell>):Void
    {
        for (i in 1...row.length)
        {
            if (row[i-1].set.indexOf(row[i]) >= 0 || _rand.bool())
                row[i-1].right = true;
            else
                mergeCellSets(row[i-1], row[i]);
        }
    }

    private static function mergeCellSets(into:Cell, from:Cell):Void
    {
        for (c in from.set)
        {
            into.set.push(c);
            c.set = into.set;
        }
    }

    // Make at least one downward pathway for each region
    private static function makeDownWalls(row:Array<Cell>):Void
    {
        for (cell in row)
        {
            _rand.getObject(cell.set).down = false;
            while (_rand.bool(1))
                _rand.getObject(cell.set).down = false;
        }
    }

    // Join any disconnected regions in the (final) row of cells
    private static function endRow(row:Array<Cell>)
    {
        for (i in 1...row.length)
        {
            if (row[i-1].set.indexOf(row[i]) < 0)
            {
                row[i-1].right = false;
                mergeCellSets(row[i-1], row[i]);
            }
        }
    }

    // Add cell data to given row of maze data structure
    private static function cellsToMazeRow(cellRow:Array<Cell>, maze:Array<Array<Int>>, rowIndex:Int)
    {
        rowIndex = 2 * rowIndex + 1;
        for (i in 0...cellRow.length)
        {
            if (cellRow[i].right)
                maze[rowIndex][2*i+2] = 1;
            if (cellRow[i].down)
                maze[rowIndex+1][2*i+1] = 1;
        }
    }

    // After copying data out of the cell array, recycle it for next row
    private static function initNextRow(row:Array<Cell>)
    {
        for (cell in row)
        {
            cell.right = false;
            if (cell.down)
            {
                cell.set.remove(cell);
                cell.set = null;
            }
            else
                cell.down = true;
        }
    }
}