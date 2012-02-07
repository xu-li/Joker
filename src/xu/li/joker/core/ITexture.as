package xu.li.joker.core 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * The basic grphic
	 * 
	 * A texture is basically a rectagular area of graphic.
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public interface ITexture 
	{
		/**
		 * Render this texture
		 * 
		 * @param	target The target bitmapdata to be rendered at.
		 * @param	x The x coordinate in the target space
		 * @param	y The y coordinate in the target space
		 */
		function render(target:BitmapData, x:int = 0, y:int = 0):void;
		
		/**
		 * Set the position
		 * 
		 * @param	x
		 * @param	y
		 */
		function setPosition(x:int = 0, y:int = 0):void;
		
		/**
		 * Get the position
		 * @param	point The point object to be filled with data
		 * @return
		 */
		function getPosition(point:Point = null):Point;
		
		/**
		 * Get the bounds of this texture in local coordinates,
		 * taking offset into consideration.
		 * 
		 * @return
		 */
		function getBounds():Rectangle;
		
		/**
		 * Check if there is an opaque pixel at coordinate (x, y).
		 * 
		 * @param	x The x value in local coordinates
		 * @param	y The y value in local coordinates
		 * @return
		 */
		function isHit(x:int = 0, y:int = 0):Boolean;
	}
}