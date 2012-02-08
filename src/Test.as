package  
{
	import com.gskinner.performance.ptest;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	public class Test extends Sprite
	{
		private var _target:BitmapData;
		private var _source:BitmapData;
		
		private var _rect:Rectangle;
		private var _pt:Point;
		
		private var _rect1:Rectangle;
		private var _rect2:Rectangle;
		
		public function Test() 
		{
			_target = new BitmapData(300, 200, false, 0);
			_source = new BitmapData(20, 20);
			_rect = new Rectangle(0, 0, 20, 20);
			_pt = new Point();
			
			
			_rect1 = new Rectangle(0, 0, 100, 100);
			_rect2 = new Rectangle(10, 10, 20, 20);
			trace(ptest(intersection, [], 'intersection', 1000, 10));
			trace(ptest(intersection, [], 'myIntersection', 1000, 10));
			
			//intersection();
		}
		
		private function intersection():void
		{
			//trace(_rect1, _rect2);
			_rect = _rect1.intersection(_rect2);
			
			//trace(_rect1, _rect2);
		}
		
		private function myIntersection():void
		{
			if (_rect1.intersects(_rect2))
			{
				_rect.x = _rect1.x > _rect2.x ? _rect1.x : _rect2.x;
				_rect.y = _rect1.y > _rect2.y ? _rect1.y : _rect2.y;
				_rect.right = _rect1.right > _rect2.right ? _rect2.right : _rect1.right;
				_rect.bottom = _rect1.bottom > _rect2.bottom ? _rect2.bottom : _rect1.bottom;
			}
			else
			{
				_rect.setEmpty();
			}
		}
		
		
		private function renderOnce():void
		{
			_rect.width = 40;
			_target.copyPixels(_source, _rect, _pt);
		}
		
		private function renderTwice():void
		{
			_rect.width = 20;
			_target.copyPixels(_source, _rect, _pt);
			_target.copyPixels(_source, _rect, _pt);
		}
	}

}