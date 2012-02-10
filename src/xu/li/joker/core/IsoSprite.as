package xu.li.joker.core 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * The iso sprite class
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class IsoSprite
	{
		public static const FLAG_POSITION_DIRTY:int = 1;
		public static const FLAG_SIZE_DIRTY:int     = 2;
		
		// the previous iso sprite
		internal var prev:IsoSprite;
		// the next iso sprite
		internal var next:IsoSprite;
		
		/**
		 * Constructor
		 */
		public function IsoSprite() 
		{
			_visible = true;
		}
		
		///////////////////////////////////////////////////////
		// Position
		///////////////////////////////////////////////////////
		
		private var _x:int;
		private var _y:int;
		private var _isoX:int;
		private var _isoY:int;
		private var _tileX:int;
		private var _tileY:int;
		private var _isoWidth:int;
		private var _isoHeight:int;
		
		/**
		 * Set the isometric position (world coordinate)
		 * @param	x
		 * @param	y
		 */
		public function setPosition(x:int, y:int):void
		{
			_isoX = x;
			_isoY = y;
			_point.x = x;
			_point.y = y;
			IsoMath.isoToScreen(_point);
			_x = _point.x;
			_y = _point.y;
		}
		
		/**
		 * Get the position at x (world coordinate)
		 * @return
		 */
		public function getX():int
		{
			return _x;
		}
		
		/**
		 * Get the position at y (world coordinate)
		 * @return
		 */
		public function getY():int
		{
			return _y;
		}
		
		/**
		 * Get the position at isox (world coordinate)
		 * @return
		 */
		public function getIsoX():int
		{
			return _isoX;
		}
		
		/**
		 * Get the position at isoY (world coordinate)
		 * @return
		 */
		public function getIsoY():int
		{
			return _isoY;
		}
		
		
		///////////////////////////////////////////////////////
		// Render
		///////////////////////////////////////////////////////
		
		/**
		 * Render the sprite
		 * 
		 * @param	target
		 * @param	viewport
		 */
		public function render(target:BitmapData, viewport:Rectangle):void
		{
			if (_visible && _texture)
			{
				// @TODO check the viewport
				
				_texture.render(target, _x - viewport.x, _y - viewport.y);
			}
		}
		
		
		///////////////////////////////////////////////////////
		// Visibility
		///////////////////////////////////////////////////////
		
		private var _visible:Boolean;
		
		/**
		 * Set the visibility of this iso sprite
		 * @param	visible
		 */
		public function setVisible(visible:Boolean):void
		{
			_visible = visible;
		}
		
		/**
		 * Check the visibility of this iso sprite
		 * @return
		 */
		public function isVisible():Boolean
		{
			return _visible;
		}
		
		///////////////////////////////////////////////////////
		// Texture
		///////////////////////////////////////////////////////
		
		private var _texture:ITexture;
		
		/**
		 * Set the texture
		 * @param	texture
		 */
		public function setTexture(texture:ITexture):void
		{
			if (_texture != texture)
			{
				_texture = texture;
			}
		}
		
		/**
		 * Get the texture
		 * @return
		 */
		public function getTexture():ITexture
		{
			return _texture;
		}
		
		///////////////////////////////////////////////////////
		// Layer
		///////////////////////////////////////////////////////
		
		// which layer
		private var _layer:IsoLayer;
		
		/**
		 * Get the layer 
		 * 
		 * @return
		 */
		public function getLayer():IsoLayer
		{
			return _layer;
		}
		
		/**
		 * Set the layer 
		 * 
		 * @return
		 */
		public function setLayer(layer:IsoLayer):void
		{
			_layer = layer;
		}
		
		
		///////////////////////////////////////////////////////
		// Interaction
		///////////////////////////////////////////////////////
		
		/**
		 * Get the sprite at 2d world space
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function isHit(x:int = 0, y:int = 0):Boolean
		{
			if (_texture)
			{
				return _texture.isHit(x - _x, y - _y);
			}
			
			return false;
		}
		
		///////////////////////////////////////////////////////
		// Other
		///////////////////////////////////////////////////////
		
		// tmp point
		private static var _point:Point = new Point();
	}
}