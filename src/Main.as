package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.ColorCorrection;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import net.hires.debug.Stats;
	import xu.li.joker.core.IsoLayer;
	import xu.li.joker.core.IsoScene;
	import xu.li.joker.core.IsoSprite;
	import xu.li.joker.core.ITexture;
	import xu.li.joker.textures.Animation;
	import xu.li.joker.textures.ColorTexture;
	import xu.li.joker.textures.FrameTexture;
	import xu.li.joker.textures.TextureList;
	
	/**
	 * ...
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	[SWF("width=800, height=600")]
	public class Main extends Sprite 
	{
		[Embed(source='../assets/tile1.png')]
		private var _tile1Class:Class;
		private var _tile1Image:BitmapData = Bitmap(new _tile1Class()).bitmapData;
		private var _tile1WhiteTile:FrameTexture = new FrameTexture(_tile1Image, new Rectangle(0, 0, 100, 50));
		private var _tile1RedTile:FrameTexture = new FrameTexture(_tile1Image, new Rectangle(100, 0, 100, 50));
		
		private var _scene:IsoScene;
		private var _layer:IsoLayer;
		private var _sprite:IsoSprite;
		private var _texture:ITexture;
		private var _timer:Timer;
		
		private var _animation:Animation;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			_timer = new Timer(1 / 60);
			
			_scene = new IsoScene(stage.stageWidth, stage.stageHeight);
			_layer = new IsoLayer(true);
			
			_animation = new Animation(1, true);
			_animation.addTexture(_tile1RedTile);
			_animation.addTexture(_tile1WhiteTile);
			
			
			_sprite = new IsoSprite();
			_sprite.setPosition(100, 0);
			_texture = new ColorTexture(0xff0000, 100, 100);
			_sprite.setTexture(_animation);
			_layer.addSprite(_sprite);
			
			//for (var i:int = 0; i < 10; ++i)
			//{
				//var sprite:IsoSprite = new IsoSprite();
				//sprite.setPosition(100 + i * 50, 0);
				//sprite.setTexture(_tile1WhiteTile);
				//_layer.addSprite(sprite);
			//}
			
			
			_scene.addLayer(_layer);
			
			
			addChild(_scene.getContainer());
			addChild(new Stats());
		
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			
			stage.doubleClickEnabled = true;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			stage.addEventListener(MouseEvent.DOUBLE_CLICK, onStageDoubleClick);
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void 
		{
			
			_scene.setViewport(stage.stageWidth, stage.stageHeight);
		}
		
		private function onStageDoubleClick(e:MouseEvent):void 
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				stage.displayState = StageDisplayState.NORMAL;
			}
			else
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		}
		
		private var _lastMousePositionX:Number = 0;
		private var _lastMousePositionY:Number = 0;
		private var _isMouseDown:Boolean = false;
		private var _selectedSprite:IsoSprite = null;
		
		private function onStageMouseDown(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			
			_lastMousePositionX = e.stageX;
			_lastMousePositionY = e.stageY;
			_isMouseDown = true;
		}
		
		private function onStageMouseMove(e:MouseEvent):void 
		{
			if (_isMouseDown)
			{
				_scene.pan(_lastMousePositionX - e.stageX, _lastMousePositionY - e.stageY);
				
				_lastMousePositionX = e.stageX;
				_lastMousePositionY = e.stageY;
			}
			else
			{
				var sprite:IsoSprite = _scene.getSpriteAt(_scene.getContainer().mouseX, _scene.getContainer().mouseY);
				
				if (sprite && _selectedSprite != sprite)
				{
					sprite.setTexture(_tile1RedTile);
					_selectedSprite && _selectedSprite.setTexture(_tile1WhiteTile);
					_selectedSprite = sprite;
				}
			}
		}
		
		private function onStageMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			_isMouseDown = false;
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			_animation.update(1 / 30);
			_scene.render();
		}
	}
	
}