package xu.li.joker.textures 
{
	import flash.display.BitmapData;
	import xu.li.joker.core.ITexture;
	import xu.li.joker.core.Texture;
	
	/**
	 * ...
	 * @author lixu<AthenaLightenedMyPath@gmail.com>
	 */
	public class IsoTileMap extends Texture implements ITexture 
	{
		protected var _textures:Vector.<ITexture>;
		protected var _rows:int;
		protected var _cols:int;
		protected var _defaultColor:int;
		
		protected var _buffer:BitmapData;
		protected var _tileWidth:int;
		protected var _tileHeight:int;
		protected var _data:Vector.<int>;
		
		/**
		 * Constructor
		 * 
		 * @param	textures
		 * @param	rows
		 * @param	cols
		 * @param	tileSize
		 * @param	defaultColor
		 */
		public function IsoTileMap(textures:Vector.<ITexture>, rows:int = 2, cols:int = 2, tileSize:int = 50, defaultColor:int = 0) 
		{
			_textures = textures;
			_rows = rows;
			_cols = cols;
			_tileWidth = tileSize * 2;
			_tileHeight = tileSize;
			_defaultColor = defaultColor;
			
			_data = new Vector.<int>(rows * cols, true);
			
			createBuffer();
		}
		
		/**
		 * Create the buffer
		 */
		protected function createBuffer():void 
		{
			_buffer = new BitmapData((_cols + _rows) * _tileHeight, (_cols + _rows) * _tileHeight / 2, false, _defaultColor);
		}
		
		/**
		 * Set the tile
		 * @param	index The index in the texture list
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 */
		public function setTile(index:int, x:int, y:int, width:int = 1, height:int = 1):void
		{
			index = index % _textures.length;
			
			for (var i:int = x, iMax:int = (x + width) >= _cols ? _cols - 1 : x + width; i < iMax; i++)
			{
				for (var j:int = y, jMax:int = (y + height) >= _rows ? _rows - 1 : y + height; j < jMax; j++)
				{
					_data[j * _cols + i] = index;
					
					setTexture(_textures[index], i, j);
				}
			}
		}
		
		/**
		 * Update the buffer
		 * @param	texture
		 * @param	x
		 * @param	y
		 */
		protected function setTexture(texture:ITexture, x:int, y:int):void
		{
			texture.render(_buffer, (y - x + _rows - 1) * _tileHeight, (x + y) * _tileHeight / 2);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function render(target:BitmapData, originX:int = 0, originY:int = 0):void 
		{
			_tempPoint.x = originX + _x;
			_tempPoint.y = originY + _y;
			
			target.copyPixels(_buffer, _buffer.rect, _tempPoint);
		}
	}

}