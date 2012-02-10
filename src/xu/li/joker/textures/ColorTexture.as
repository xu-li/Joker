package xu.li.joker.textures 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import xu.li.joker.core.ITexture;
	import xu.li.joker.core.Texture;
	
	/**
	 * A color texture
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class ColorTexture extends Texture implements ITexture
	{
		private var _color:uint;
		private var _width:int;
		private var _height:int;
		
		/**
		 * Constructor
		 * 
		 * @param	color The color to be filled
		 * @param	width The width of this texture
		 * @param	height The height of this texture
		 */
		public function ColorTexture(color:uint, width:int = 1, height:int = 1) 
		{
			super();
			
			_width = width;
			_height = height;
			
			setColor(color);
		}
		
		/**
		 * Set the color
		 * @param	color
		 */
		public function setColor(color:uint):void
		{
			_color = color;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function render(target:BitmapData, originX:int = 0, originY:int = 0):void
		{
			_tempRect.x = originX + _x;
			_tempRect.y = originY + _y;
			_tempRect.width = _width;
			_tempRect.height = _height;
			
			target.fillRect(_tempRect, _color);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function isHit(x:int = 0, y:int = 0):Boolean 
		{
			return x >= _x && x < _x + _width && y >= _y && y < _y + _height;
		}
	}

}