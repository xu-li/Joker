package xu.li.joker.core 
{
	/**
	 * ...
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class IsoSprite
	{
		public var prev:IsoSprite;
		public var next:IsoSprite;
		
		private var _layer:IsoLayer;
		
		private var _texture:ITexture;
		
		private var _x:int;
		private var _y:int;
		private var _isoX:int;
		private var _isoY:int;
		
		public function IsoSprite() 
		{
			
		}
	}
}