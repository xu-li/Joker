package xu.li.joker.core 
{
	import flash.geom.Point;
	/**
	 * The iso to screen convertor class
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class IsoMath
	{
		/**
		 * Convert the point from screen coordinates to isometric coordinates.
		 * @param	screenPoint
		 */
		public static function screenToIso(screenPoint:Point):void
		{
			var x:Number = screenPoint.x * 0.5 + screenPoint.y;
			var y:Number = screenPoint.y - screenPoint.x * 0.5;
			
			screenPoint.x = x;
			screenPoint.y = y;
		}
		
		/**
		 * Convert the point from isometric coordinates to screen coordinates.
		 * @param	isoPoint
		 */
		public static function isoToScreen(isoPoint:Point):void
		{
			var x:Number = isoPoint.x - isoPoint.y;
			var y:Number = (isoPoint.x + isoPoint.y) * 0.5;
			
			isoPoint.x = x;
			isoPoint.y = y;
		}
	}
}