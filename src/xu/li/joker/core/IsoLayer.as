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
		public static const FLAG_DEPTH_DIRTY:int = 1;
		
		// whether this layer should handle the mouse events
		private var _interactable:Boolean = true;
		
		/**
		 * Constructor
		 * 
		 * @param	interactable
		 */
		public function IsoLayer(interactable:Boolean = false) 
		{
			_visible = true;
			_interactable = interactable;
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
			// @TODO sort the layer by using the depth dirty flag
			
			// do nothing
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
			if (_visible)
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
		// Visibility
		///////////////////////////////////////////////////////
		
		private var _visible:Boolean;
		
		/**
		 * Set the visibility of this iso sprite
		 * @param	visible
		 */
		public function setVisible(visible:Boolean):void
		{
			_visible = visible;
		}
		
		/**
		 * Check the visibility of this iso sprite
		 * @return
		 */
		public function isVisible():Boolean
		{
			return _visible;
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
			if (!_interactable)
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