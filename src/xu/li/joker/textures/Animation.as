package xu.li.joker.textures 
{
	import xu.li.joker.core.ITexture;
	import xu.li.joker.core.Texture;
	
	/**
	 * An animation texture
	 * 
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class Animation extends TextureList implements ITexture
	{
		protected var _currentFrameIndex:int = 0;
		
		/**
		 * 
		 * @param	time
		 * @param	type
		 * @param	onComplete
		 */
		public function Animation(time:Number, loop:Boolean = true, onComplete:Function = null)
		{
			
		}
	}

}