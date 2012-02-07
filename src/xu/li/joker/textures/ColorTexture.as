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
			
			_color = color;
			_bounds.width = width;
			_bounds.height = height;
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
		override public function render(target:BitmapData, x:int = 0, y:int = 0):void
		{
			_bounds.x += x;
			_bounds.y += y;
			target.fillRect(_bounds, _color);
			_bounds.x -= x;
			_bounds.y -= y;
		}
	}

}