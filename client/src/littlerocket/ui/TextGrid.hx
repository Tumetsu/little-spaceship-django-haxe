package littlerocket.ui;
import flambe.Component;
import flambe.Entity;
import flambe.display.TextSprite;

/**
 * This component enables and manages a grid or table of Texts. Lets the
 * user to define rows and columns of different Text-sprites and update their content
 * individually.
 * @author Tuomas Salmi
 */
class TextGrid extends Component
{
	private var rows:Array<Array<Entity>> = null;
	private var cellHeight:Float = 18;
	private var columnWidths:Array<Float> = null;
	private var cellRightSpacing:Float = 12;
	
	public function new() 
	{
		
	}
	
	override public function onAdded():Void
	{
		
	}
	
	//resizes all the widths of the existing cells to represent the current width.
	//basically it just updates the locations of the text-sprites
	private function resizeCells():Void
	{
		for (row in 0...rows.length)
		{		
			for (column in 0...rows[row].length)
			{
				if (rows[row][column].get(TextSprite) != null)
				{
					rows[row][column].get(TextSprite).x._ = getColumnX(column);
				}
			}
		}
	}
	
	//gives the x position of the given column
	//calculates the sum of the column widths
	private function getColumnX(index:Int):Float
	{
		var xpos:Float = 0;
		for (i in 0...index)
		{
			xpos += columnWidths[i];
		}
		
		return xpos;
	}
	
	/**
	 * Sets the dimensions of the table. Has to be called before
	 * other functions
	 * @param	width
	 * @param	height
	 */
	public function dimensions(width:Int, height:Int):Void
	{
		rows = new Array();
		columnWidths = new Array();
		
		for ( i in 0...height ) 
		{
			rows.push(new Array());	//create rows
			for (j in 0...width)
			{
				var e:Entity = new Entity();
				owner.addChild(e);
				rows[i].push(e);	//create Entity to the row (column)
			}
		}
		
		//create array of widths for each column
		for ( i in 0...width)
		{
			columnWidths.push(0);
		}
	}
	
	/**
	 * Add a TextSprite to the 
	 * @param	text
	 * @param	row
	 * @param	column
	 */
	public function addText(text:TextSprite, column:Int, row:Int):Void
	{
		if (columnWidths[column] < text.getNaturalWidth() + cellRightSpacing)
		{
			//widen the cell so that the text fits in
			columnWidths[column] = text.getNaturalWidth() + cellRightSpacing;
		}
		
		text.setXY(getColumnX(column), row * cellHeight);
		rows[row][column].add(text);	//add TextSprite to the Entity in the cell
		
		resizeCells();
	}
	
	/**
	 * Get pointer to the TextSprite component which resides in the specified
	 * row and column.
	 * @param	column
	 * @param	row
	 * @return
	 */
	public function getText(column:Int, row:Int):TextSprite
	{
		return rows[row][column].get(TextSprite);
	}
	
	
	
}