package xu.li.joker.core 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * The Scene class
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class IsoScene
	{
		/**
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/BitmapData.html
		 */
		private static const MAX_BITMAPDATA_PIXELS:int = 16777215;
		
		/**
		 * Constructor
		 * @param	width The width of the view port
		 * @param	height The height of the view port
		 * @param	backgroundColor The default background color
		 */
		public function IsoScene(width:int, height:int, backgroundColor:uint = 0) 
		{
			_container = new Bitmap();
			_viewport = new Rectangle();
			_backgroundColor = backgroundColor;
			
			setViewport(width, height, false);
		}
		
		/**
		 * Get the container
		 * @return
		 */
		public function getContainer():Bitmap
		{
			return _container;
		}
		
		///////////////////////////////////////////////////////
		// Layer
		///////////////////////////////////////////////////////
		
		// all the layers
		private var _layers:Vector.<IsoLayer>;
		
		/**
		 * Get all the iso layers
		 * @return
		 */
		public function getLayers():Vector.<IsoLayer>
		{
			return _layers;
		}
		
		/**
		 * Add a layer on top of all the other layers
		 * @param	layer
		 */
		public function addLayer(layer:IsoLayer):void
		{
			if (!_layers)
			{
				_layers = new Vector.<IsoLayer>();
			}
			
			_layers.push(layer);
		}
		
		/**
		 * Remove a layer from the scene
		 * @param	layer
		 */
		public function removeLayer(layer:IsoLayer):void
		{
			if (_layers)
			{
				_layers.splice(_layers.indexOf(layer), 1);
			}
		}
		
		///////////////////////////////////////////////////////
		// Render
		///////////////////////////////////////////////////////
		
		protected var _container:Bitmap;
		protected var _buffer:BitmapData;
		protected var _backgroundColor:uint;
		
		/**
		 * Render the scene
		 */
		public function render():void
		{
			// @TODO render based on the dirty flag.
			
			beforeRender();
			
			renderLayers();
			
			afterRender();
		}
		
		/**
		 * Before layer render
		 */
		protected function beforeRender():void
		{
			_buffer.lock();
			
			//_buffer.floodFill(0, 0, _backgroundColor);
			_buffer.fillRect(_buffer.rect, _backgroundColor);
		}
		
		/**
		 * Render the layers
		 */
		protected function renderLayers():void
		{
			if (_layers)
			{
				for (var i:int = 0, l:int = _layers.length; i < l; ++i)
				{
					_layers[i].render(_buffer, _viewport);
				}
			}
		}
		
		/**
		 * Before layer render
		 */
		protected function afterRender():void
		{
			_buffer.unlock();
		}
		
		///////////////////////////////////////////////////////
		// Camera
		///////////////////////////////////////////////////////
		
		// the viewport rectangle
		protected var _viewport:Rectangle;
		
		/**
		 * Pan the viewport
		 * @param	dx
		 * @param	dy
		 */
		public function pan(dx:int = 0, dy:int = 0):void
		{
			_viewport.offset(dx, dy);
		}
		
		/**
		 * Center the viewport at specific location
		 * @param	x
		 * @param	y
		 */
		public function centerViewportAt(x:int = 0, y:int = 0):void
		{
			_viewport.x = x - _viewport.width / 2;
			_viewport.y = y - _viewport.height / 2;
		}
		
		/**
		 * Set the viewport size
		 * @param	width
		 * @param	height
		 * @param	centerOrigin
		 */
		public function setViewport(width:int, height:int, centerOrigin:Boolean = true):void
		{
			if (width * height > MAX_BITMAPDATA_PIXELS)
			{
				throw new Error("Max bitmapdata pixels exceeded.");
			}
			
			if (_viewport.width != width || _viewport.height != height)
			{
				if (centerOrigin)
				{
					_viewport.x += _viewport.width / 2 - width / 2;
					_viewport.y += _viewport.height / 2 - height / 2;
				}
				
				_viewport.width = width;
				_viewport.height = height;
				
				_buffer && _buffer.dispose();
				_buffer = new BitmapData(width, height, false, _backgroundColor);
				_container.bitmapData = _buffer;
			}
		}
		
		public function zoom(level:Number):void
		{
			
		}
		
		///////////////////////////////////////////////////////
		// Interaction
		///////////////////////////////////////////////////////
		
		/**
		 * Get the sprite at local position (x, y), relative to the view port
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function getSpriteAt(x:int = 0, y:int = 0):IsoSprite
		{
			if (_layers)
			{
				var i:int = _layers.length - 1;
				
				while (i >= 0)
				{
					var sprite:IsoSprite = _layers[i].getSpriteAt(x + _viewport.x, y + _viewport.y);
					if (sprite)
					{
						return sprite;
					}
					i--;
				}
			}
			
			return null;
		}
		
		///////////////////////////////////////////////////////
		// Tile
		///////////////////////////////////////////////////////
		
		// width of a tile in 2d space
		private static var _tileWidth:int = 0;
		
		// height of a tile in 2d space
		private static var _tileHeight:int = 0;
		
		// size of a tile in isometric space, (width equals height)
		private static var _isoTileSize:int = 0;
		
		/**
		 * Set the tile size in isometric space
		 * @param	isoTileSize
		 */
		public static function setTileSize(isoTileSize:int):void
		{
			_isoTileSize = isoTileSize;
			_tileHeight = isoTileSize;
			_tileWidth = isoTileSize * 2;
		}
		
		/**
		 * Get the tile width in 2d space
		 * @return
		 */
		public static function getTileWidth():int
		{
			return _tileWidth;
		}
		
		/**
		 * Get the tile height in 2d space
		 * @return
		 */
		public static function getTileHeight():int
		{
			return _tileHeight;
		}
		
		/**
		 * Get the tile size in isometric space
		 * @return
		 */
		public static function getTileSize():int
		{
			return _isoTileSize;
		}
		
		// default the iso tile width to 50
		{
			IsoScene.setTileSize(50);
		}
		
		///////////////////////////////////////////////////////
		// Coordinates transform
		///////////////////////////////////////////////////////
	}
}