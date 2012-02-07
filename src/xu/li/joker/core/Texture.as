package xu.li.joker.core 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	/**
	 * The base texture class
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class Texture implements ITexture
	{
		protected var _x:int;
		protected var _y:int;
		
		protected var _bounds:Rectangle;
		
		/**
		 * Constructor
		 */
		public function Texture()
		{
			_bounds = new Rectangle();
		}
		
		/**
		 * @inheritDoc
		 */
		public function setPosition(x:int = 0, y:int = 0):void
		{
			_x = x;
			_y = y;
			
			_bounds.x = x;
			_bounds.y = y;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPosition(point:Point = null):Point
		{
			point = point == null ? new Point() : point;
			
			point.x = _x;
			point.y = _y;
			
			return point;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBounds():Rectangle
		{
			return _bounds;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isHit(x:int = 0, y:int = 0):Boolean
		{
			return x >= _bounds.left && x < _bounds.right && y >= _bounds.top && y < _bounds.bottom;
		}
		
		/**
		 * @inheritDoc
		 */
		public function render(target:BitmapData, x:int = 0, y:int = 0):void
		{
			// do nothing
		}
		
		protected static var _tempRect:Rectangle = new Rectangle();
	}
}