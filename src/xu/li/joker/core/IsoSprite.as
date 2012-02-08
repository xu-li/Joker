package xu.li.joker.core 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class IsoSprite
	{
		
		
		
		public var prev:IsoSprite;
		public var next:IsoSprite;
		
		private var _layer:IsoLayer;
		
		private var _visible:Boolean;
		private var _texture:ITexture;
		
		private var _x:int;
		private var _y:int;
		private var _isoX:int;
		private var _isoY:int;
		
		public function IsoSprite() 
		{
			
		}
		
		public function render(target:BitmapData, viewport:Rectangle):void
		{
			
		}
		
		public function getBounds():Rectangle
		{
			return null;
		}
	}
}