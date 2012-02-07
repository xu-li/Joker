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
			
			if (oldIndex < 0)
			{
				calculateBounds();
			}
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
				calculateBounds();
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
		
		/**
		 * Recalculate the bounds
		 */
		protected function calculateBounds():void
		{
			_bounds.setEmpty();
			
			for (var i:int = 0, l:int = _list.length; i < l; ++i)
			{
				_bounds = _bounds.union(_list[i].getBounds());
			}
			
			_bounds.x += _x;
			_bounds.y += _y;
		}
		
		///////////////////////////////////////////////////////
		// Implementation
		///////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render(target:BitmapData, x:int = 0, y:int = 0):void 
		{
			x += _x;
			y += _y;
			
			for (var i:int = 0, l:int = _list.length; i < l; ++i)
			{
				_list[i].render(target, x, y);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function isHit(x:int = 0, y:int = 0):Boolean 
		{
			if (super.isHit(x, y))
			{
				x -= _x;
				y -= _y;
				
				for (var i:int = 0, l:int = _list.length; i < l; ++i)
				{
					if (_list[i].isHit(x, y))
					{
						return true;
					}
				}
			}
			
			return false;
		}
	}

}