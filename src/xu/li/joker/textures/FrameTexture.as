package xu.li.joker.textures 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import xu.li.joker.core.ITexture;
	import xu.li.joker.core.Texture;
	
	/**
	 * A frame texture class
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class FrameTexture extends Texture implements ITexture
	{
		private var _image:BitmapData;
		private var _rect:Rectangle;
		
		/**
		 * Constructor
		 * 
		 * @param	image
		 * @param	rect
		 */
		public function FrameTexture(image:BitmapData, rect:Rectangle = null) 
		{
			_image = image;
			_rect = rect ? rect : image.rect;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function render(target:BitmapData, originX:int = 0, originY:int = 0):void 
		{
			_tempPoint.x = originX + _x;
			_tempPoint.y = originY + _y;
			
			target.copyPixels(_image, _rect, _tempPoint);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function isHit(x:int = 0, y:int = 0):Boolean 
		{
			if (x >= _x && x < _x + _rect.width && y >= _y && y < _y + _rect.height
				&& (_image.getPixel32(x - _x, y - _y) >> 24 & 0xff) > 0)
			{
				return true;
			}
			
			return false;
		}
		
	}

}