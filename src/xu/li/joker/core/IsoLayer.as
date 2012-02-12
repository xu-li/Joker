package xu.li.joker.core 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * The Iso Layer class
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class IsoLayer
	{
		public static const FLAG_VISIBILITY:int   = 1;
		public static const FLAG_INTERACTABLE:int = 2;
		public static const FLAG_DEPTH_DIRTY:int  = 4;
		
		/**
		 * Constructor
		 * 
		 * @param	interactable
		 */
		public function IsoLayer(interactable:Boolean = false) 
		{
			setFlag(FLAG_VISIBILITY, true);
			setFlag(FLAG_INTERACTABLE, interactable);
		}
		
		///////////////////////////////////////////////////////
		// Sprites
		///////////////////////////////////////////////////////
		
		private var _firstSprite:IsoSprite;
		private var _lastSprite:IsoSprite;
		
		/**
		 * Add the sprite to the last
		 * 
		 * @param	sprite
		 */
		public function addSprite(sprite:IsoSprite):void
		{
			if (_lastSprite == null)
			{
				sprite.prev = null;
				sprite.next = null;
				
				_firstSprite = sprite;
				_lastSprite = sprite;
			}
			else
			{
				_lastSprite.next = sprite;
				sprite.prev = _lastSprite;
				sprite.next = null;
				_lastSprite = sprite;
			}
			
			var oldLayer:IsoLayer = sprite.getLayer();
			if (oldLayer)
			{
				oldLayer.removeSprite(sprite);
			}
			
			sprite.setLayer(this);
		}
		
		/**
		 * Remove the sprite from the layer
		 * 
		 * @param	sprite
		 */
		public function removeSprite(sprite:IsoSprite):void
		{
			var spriteAdded:IsoSprite = _firstSprite;
			
			while (spriteAdded)
			{
				if (spriteAdded == sprite)
				{
					if (sprite.prev) // it's not the first node
					{
						if (sprite.next) // it's not the last node
						{
							sprite.prev.next = sprite.next;
							sprite.next.prev = sprite.prev;
						}
						else
						{
							sprite.prev.next = null;
							_lastSprite = sprite.prev;
						}
					}
					else // it's the first node
					{
						if (sprite.next) // it's not the last node
						{
							sprite.next.prev = null;
							_firstSprite = sprite.next;
						}
						else
						{
							_firstSprite = null;
							_lastSprite = null;
						}
					}
					
					sprite.prev = null;
					sprite.next = null;
					sprite.setLayer(null);
					
					return ;
				}
				
				spriteAdded = spriteAdded.next;
			}
		}
		
		///////////////////////////////////////////////////////
		// Sort
		///////////////////////////////////////////////////////
		
		/**
		 * Depth sort the layer
		 */
		public function depthSort():void
		{
			if (getFlag(FLAG_DEPTH_DIRTY))
			{
				
				
				
				setFlag(FLAG_DEPTH_DIRTY, false);
			}
		}
		
		/**
		 * Compare the depth
		 * 
		 * @param	isoSpriteA
		 * @param	isoSpriteB
		 * @return 1 if isoSpriteA is behind isoSpriteB, -1 otherwise
		 */
		protected function compareDepth(isoSpriteA:IsoSprite, isoSpriteB:IsoSprite):int
		{
			return isoSpriteA.getTileX() <= isoSpriteB.getTileX() + isoSpriteB.getTileWidth()
				&& isoSpriteA.getTileY() <= isoSpriteB.getTileY() + isoSpriteB.getTileHeight()
				? 1 : -1;
		}
		
		///////////////////////////////////////////////////////
		// Render
		///////////////////////////////////////////////////////
		
		/**
		 * Render this layer
		 * 
		 * @param	target
		 * @param	viewport
		 */
		public function render(target:BitmapData, viewport:Rectangle):void
		{
			if (getFlag(FLAG_VISIBILITY))
			{
				beforeRender();
				
				renderSprites(target, viewport);
				
				afterRender();
			}
		}
		
		/**
		 * Before rendering the sprites
		 */
		protected function beforeRender():void
		{
			depthSort();
		}
		
		/**
		 * Render the sprites
		 * 
		 * @param	target
		 * @param	viewport
		 */
		protected function renderSprites(target:BitmapData, viewport:Rectangle):void
		{
			var sprite:IsoSprite = _firstSprite;
			
			while (sprite)
			{
				sprite.render(target, viewport);
				
				sprite = sprite.next;
			}
		}
		
		/**
		 * After rendering the sprites
		 */
		protected function afterRender():void
		{
			// do nothing
		}
		
		///////////////////////////////////////////////////////
		// Flags
		///////////////////////////////////////////////////////

		/**
		 * Flags
		 * @see IsoLayer::FLAG_VISIBILITY
		 * @see IsoLayer::FLAG_INTERACTABLE
		 * @see IsoLayer::FLAG_DEPTH_DIRTY
		 */
		private var _flags:int = 0;
		
		/**
		 * Set the flag
		 * @param	flag
		 * @param	value
		 */
		public function setFlag(flag:int, value:Boolean = true):void
		{
			_flags = value ? _flags | flag : _flags & ~flag;
		}
		
		/**
		 * Get the flag
		 * @param	flag
		 * @return
		 */
		public function getFlag(flag:int):Boolean 
		{
			return (_flags & flag) == flag;
		}
		
		///////////////////////////////////////////////////////
		// Interaction
		///////////////////////////////////////////////////////
		
		/**
		 * Get the sprite at 2d world space
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function getSpriteAt(x:int = 0, y:int = 0):IsoSprite
		{
			if (!getFlag(FLAG_VISIBILITY | FLAG_INTERACTABLE))
			{
				return null;
			}
			
			var sprite:IsoSprite = _firstSprite;
			while (sprite)
			{
				if (sprite.isHit(x, y))
				{
					return sprite;
				}
				
				sprite = sprite.next;
			}
			
			return null;
		}
	}

}