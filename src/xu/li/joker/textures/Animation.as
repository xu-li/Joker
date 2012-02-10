package xu.li.joker.textures 
{
	import flash.display.BitmapData;
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
		protected var _timePerFrame:Number = 0;
		protected var _loop:Boolean = false;
		protected var _onComplete:Function = null;
		
		protected var _onCompleteFunctionCalled:Boolean = false;
		protected var _timeRemained:Number = 0;
		
		/**
		 * Constructor
		 * 
		 * @param	timePerFrame
		 * @param	type
		 * @param	onComplete
		 */
		public function Animation(timePerFrame:Number, loop:Boolean = true, onComplete:Function = null)
		{
			_timePerFrame = timePerFrame;
			_loop = loop;
			_onComplete = onComplete;
		}
		
		/**
		 * Update the animation for certain period of time
		 * @param	timeElapsed
		 */
		public function update(timeElapsed:Number):void
		{
			if (!_list || _list.length == 0)
			{
				return ;
			}
			
			_timeRemained += timeElapsed;
			
			if (_timeRemained > _timePerFrame)
			{
				_timeRemained -= _timePerFrame;
				
				if (_currentFrameIndex == _list.length - 1) // last frame
				{
					if (_loop)
					{
						_currentFrameIndex = 0;
						_onCompleteFunctionCalled = false;
					}
					
					if (!_onCompleteFunctionCalled && _onComplete is Function)
					{
						_onComplete.call();
						
						_onCompleteFunctionCalled = true;
					}
				}
				else
				{
					_currentFrameIndex++;
				}
			}
		}
		
		/**
		 * Go to specific frame
		 * @param	index
		 */
		public function gotoAndStop(index:int):void
		{
			if (!_list || _list.length == 0)
			{
				return ;
			}
			
			_currentFrameIndex = index >= _list.length ? _list.length - 1 : index;
			
			_timeRemained = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function render(target:BitmapData, originX:int = 0, originY:int = 0):void 
		{
			if (_list && _list.length > 0)
			{
				originX += _x;
				originY += _y;
				
				_list[_currentFrameIndex].render(target, originX, originY);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function isHit(x:int = 0, y:int = 0):Boolean 
		{			
			if (_list && _list.length > 0)
			{
				x -= _x;
				y -= _y;
				
				return _list[_currentFrameIndex].isHit(x, y);
			}
			
			return false;
		}
	}

}