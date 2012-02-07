package xu.li.joker.core 
{
	import flash.display.Bitmap;
	/**
	 * The Scene class
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class IsoScene
	{
		
		public function IsoScene() 
		{
			
		}
		
		/**
		 * Get the container
		 * @return
		 */
		public function getContainer():Bitmap
		{
			
		}
		
		///////////////////////////////////////////////////////
		// Layer
		///////////////////////////////////////////////////////
		
		private var _layers:Vector.<IsoLayer>;
		
		/**
		 * Get all the iso layers
		 * @return
		 */
		public function getLayers():Vector.<IsoLayer>
		{
			
		}
		
		/**
		 * Add a layer into the scene
		 * @param	layer
		 */
		public function addLayer(layer:IsoLayer):void
		{
			
		}
		
		/**
		 * Remove a layer from the scene
		 * @param	layer
		 */
		public function removeLayer(layer:IsoLayer):void
		{
			
		}
		
		
		///////////////////////////////////////////////////////
		// IsoSprite
		///////////////////////////////////////////////////////
		
		private var _sprites:Vector.<IsoSprite>;
		
		
		///////////////////////////////////////////////////////
		// Render
		///////////////////////////////////////////////////////
		
		public function render():void
		{
			
		}
		
		public function invalidate(x:int = 0, y:int = 0, width:int = 0, height:int = 0):void
		{
			
		}
		
		///////////////////////////////////////////////////////
		// Camera
		///////////////////////////////////////////////////////
		
		public function pan(dx:int = 0, dy:int = 0):void
		{
			
		}
		
		
		public function zoom(level:Number):void
		{
			
		}
		
		///////////////////////////////////////////////////////
		// Interaction
		///////////////////////////////////////////////////////
		
		public function getSpriteAt(x:int = 0, y:int = 0):IsoSprite
		{
			
		}
	}
}