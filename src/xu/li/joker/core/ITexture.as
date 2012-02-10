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
		 * @param	originX The origin point of this texture, in target's coordinate space
		 * @param	originY The origin point of this texture, in target's coordinate space
		 */
		function render(target:BitmapData, originX:int = 0, originY:int = 0):void;
		
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