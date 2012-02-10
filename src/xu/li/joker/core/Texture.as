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
		
		protected static var _tempPoint:Point = new Point();
		protected static var _tempRect:Rectangle = new Rectangle();
		
		/**
		 * Set the position
		 * 
		 * @param	x
		 * @param	y
		 */
		public function setPosition(x:int = 0, y:int = 0):void
		{
			_x = x;
			_y = y;
		}
		
		/**
		 * Get x
		 * @return
		 */
		public function getX():int
		{
			return _x;
		}
		
		/**
		 * Get y
		 * @return
		 */
		public function getY():int
		{
			return _y;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isHit(x:int = 0, y:int = 0):Boolean
		{
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function render(target:BitmapData, originX:int = 0, originY:int = 0):void
		{
			// do nothing
		}
	}
}