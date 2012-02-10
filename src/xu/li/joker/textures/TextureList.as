package xu.li.joker.textures 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import xu.li.joker.core.ITexture;
	import xu.li.joker.core.Texture;
	
	/**
	 * A list of textures
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class TextureList extends Texture implements ITexture
	{
		protected var _list:Vector.<ITexture>;
		
		/**
		 * Constructor
		 */
		public function TextureList() 
		{
			_list = new Vector.<ITexture>();
		}
		
		///////////////////////////////////////////////////////
		// Child Texture
		///////////////////////////////////////////////////////
		
		/**
		 * Add the texture
		 * @param	texture
		 * @param	index
		 */
		public function addTexture(texture:ITexture, index:int = int.MAX_VALUE):void
		{
			index = Math.min(index, _list.length);
			var oldIndex:int = _list.indexOf(texture);
			if (oldIndex >= 0)
			{
				_list.splice(oldIndex, 1);
			}
			
			_list.splice(index, 0, texture);
		}
		
		/**
		 * Remove the texture
		 * @param	texture
		 */
		public function removeTexture(texture:ITexture):void
		{
			var index:int = _list.indexOf(texture);
			if (index >= 0)
			{
				_list.splice(index, 1);
			}
		}
		
		/**
		 * Has texture?
		 * @param	texture
		 * @return
		 */
		public function hasTexture(texture:ITexture):Boolean
		{
			return _list.indexOf(texture) >= 0;
		}
		
		/**
		 * Get all the textures
		 * @return
		 */
		public function getTextures():Vector.<ITexture>
		{
			return _list;
		}
		
		///////////////////////////////////////////////////////
		// ITexture Implementation
		///////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render(target:BitmapData, originX:int = 0, originY:int = 0):void
		{
			originX += _x;
			originY += _y;
			
			for (var i:int = 0, l:int = _list.length; i < l; ++i)
			{
				_list[i].render(target, originX, originY);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function isHit(x:int = 0, y:int = 0):Boolean 
		{
			x -= _x;
			y -= _y;
			
			var i:int = _list.length - 1;
			while (i >= 0)
			{
				if (_list[i].isHit(x, y))
				{
					return true;
				}
				
				i--;
			}
		
			return false;
		}
	}

}