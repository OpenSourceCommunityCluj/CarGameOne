package 
{
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import CGEngine.CGEngineContactListener;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.*;
	import CGEngine.ArbiStaticActor;
	import CGEngine.CarActor;
	import CGEngine.PhysiVals;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class the_game_itself extends Sprite 
	{
		public var main_class:the_game;
		public var current_level:int;
		private var playerCar:CarActor;
		private var mainLayer:Sprite = new Sprite();
		private var staticLayer:Sprite = new Sprite();
		private var ground:ArbiStaticActor;
		private var ground2:ArbiStaticActor;
		private var ground3:ArbiStaticActor;
		private var ground4:ArbiStaticActor;
		private var mainStage:Stage;
		private var timerSecondsText:TextField;
		private var timeLeft:TextField;
		private var timerFormat:TextFormat = new TextFormat();
		public var gameOver:Boolean;
		private var levelCompleteWall:ArbiStaticActor;
		private var time_count:Timer;
		private var main_level:int;
		private var uSeconds:int;
		
		//SHAPES
		private var boxShapes:Array = [[new Point(0, 0), new Point(60, 0), new Point(60, 60), new Point(0, 60)]];
		private var rampShapes:Array = [[new Point(0, 0), new Point(200, -100), new Point(200, -87), new Point(0, 3)]];
		private var barrelShapes:Array = [[new Point(0, 0), new Point(80, 0), new Point(80, 30), new Point(0, 30)]];
		private var metalRampShapes:Array = [[new Point(0, 0), new Point(50, -50), new Point(50, 0)]];
		private var newGroundShapes:Array = [[new Point(0, 0), new Point(215, -150), new Point(2480, -150), new Point(2720, 0)]];
		private var woodShapes:Array = [[new Point(0, 0), new Point(300, 0), new Point(300, 30), new Point(0, 30)]];
		
		private var wallShapes:Array = [[new Point(0, 0), new Point(50, 0), new Point(50, 553), new Point(0, 535)]];
		
		private var groundShapes:Array = [[new Point(0, 0), new Point(5700, 0), new Point(5700, 45), new Point(0, 45)]];
		
		public function the_game_itself(passed_class:the_game, level:int,stage:Stage) 
		{
			current_level = level;
			mainStage = stage;
			main_class = passed_class;
			mainStage.addChild(mainLayer);
			mainLayer.mouseEnabled = false;
			mainStage.addChild(staticLayer);
			staticLayer.mouseEnabled = false;
			mainStage.addEventListener(Event.ENTER_FRAME, on_enter_frame);
			setupPhysicsWorld();
			makeCar();
			makeLevel();
		}
		
		private function makeLevel():void 
		{
			/*
			 *  FORR ALL THE LEVELS
			 */
			//adding the wals
			var leftWall:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(0, 0), wallShapes, LeftWall);
			var rightWall:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(22750,0), wallShapes, RightWall);
			levelCompleteWall = rightWall;
			
			//adding the ground
			
			ground = new ArbiStaticActor(mainLayer, new Point(0, 535), groundShapes, Ground);
			ground2 = new ArbiStaticActor(mainLayer, new Point(5700, 535), groundShapes, Ground);
			ground3 = new ArbiStaticActor(mainLayer, new Point(11400, 535), groundShapes, Ground);
			ground4 = new ArbiStaticActor(mainLayer, new Point(17100, 535), groundShapes, Ground);
			var ground5 = new ArbiStaticActor(mainLayer, new Point(-5700, 535), groundShapes, Ground);
			var ground6 = new ArbiStaticActor(mainLayer, new Point(22800, 535), groundShapes, Ground);
			/*
			 * FOR EACH LEVEL
			 */ 
			switch(current_level)
			{
				
				case 1: level1Specifics();
						break;
				case 2: level2Specifics();
						break;
				case 3: level3Specifics();
						break;
				case 4: level4Specifics();
						break;
				case 5: level5Specifics();
						break;
				case 6: level6Specifics();
						break;
				case 7: level7Specifics();
						break;
				case 8: level8Specifics();
						break;
			}
		}
		
		private function setTimer(seconds:int):void
		{
			uSeconds = seconds;
			//timer format
			timerFormat.size = 30;
			timerFormat.color = 0xF7FE2E;
			timerFormat.bold = true;
			
			//timer
			timeLeft = new TextField();
			timeLeft.x = 20;
			timeLeft.y = 10;
			timeLeft.text = " Time Left : ";
			timeLeft.width = 200;
			timeLeft.setTextFormat(timerFormat);
			staticLayer.addChild(timeLeft);
			
			timerSecondsText = new TextField();
			timerSecondsText.x = 180;
			timerSecondsText.y = 10;
			timerSecondsText.text = String(seconds);
			timerSecondsText.setTextFormat(timerFormat);
			staticLayer.addChild(timerSecondsText);
			
			time_count = new Timer(1000, seconds);
			if (time_count.addEventListener(TimerEvent.TIMER, show_time))
				time_count.removeEventListener(TimerEvent.TIMER,  show_time);
			else 
				time_count.addEventListener(TimerEvent.TIMER, show_time);
				
			time_count.start();
			
		}
		
		private function level8Specifics():void 
		{
			setTimer(90);
			main_level = 8;
			//WOODS
			var wood:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2800, 354), woodShapes, Wood);
			var wood1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3500, 354), woodShapes, Wood);
			
			//NEW GROUNDS
			var newGround:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1200, 535), newGroundShapes, NewGround);
			var newGround2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5500, 535), newGroundShapes, NewGround);
			
			//RAMPS
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(7000, 383), rampShapes, Ramp);
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(7110, 353), barrelShapes, Barrel);
			
			//METAL RAMPS
			for (var i = 0; i < 10; i++)
			{
				var metalRamp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(10000 + (i * 600),535), metalRampShapes, MetalRamp);
			}
			
			//BOXES
			for (i = 0; i < 6; i++)
			{
				var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(20000 + (i * 200), 490), boxShapes, Box);
			}
		}
		
		private function level7Specifics():void 
		{
			setTimer(100);
			main_level = 7;
			//WOODS
			var wood:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(800, 505), woodShapes, Wood);
			var wood1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1000, 475), woodShapes, Wood);
			var wood2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1200, 445), woodShapes, Wood);
			var wood3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1400, 415), woodShapes, Wood);
			var wood4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1600, 385), woodShapes, Wood);
			var wood5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1800, 355), woodShapes, Wood);
			var wood6:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2000, 325), woodShapes, Wood);
			var wood7:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2200, 295), woodShapes, Wood);
			var wood8:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2400, 265), woodShapes, Wood);
			var wood9:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2600, 235), woodShapes, Wood);
			var wood10:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2800, 205), woodShapes, Wood);
			var wood11:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3000, 175), woodShapes, Wood);
			var wood12:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3200, 145), woodShapes, Wood);
			var wood13:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3400, 115), woodShapes, Wood);
			var wood14:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3600, 85), woodShapes, Wood);
			var wood15:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3800, 55), woodShapes, Wood);
			var wood16:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4000, 85), woodShapes, Wood);
			var wood17:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4200, 115), woodShapes, Wood);
			var wood18:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4400, 145), woodShapes, Wood);
			var wood30NuIntrebaDeCe:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4600, 175), woodShapes, Wood);
			var wood19:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4800, 205), woodShapes, Wood);
			var wood20:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5000, 235), woodShapes, Wood);
			var wood21:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5200, 265), woodShapes, Wood);
			var wood22:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5400, 295), woodShapes, Wood);
			var wood23:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5600, 325), woodShapes, Wood);
			var wood24:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5800, 355), woodShapes, Wood);
			var wood25:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6000, 385), woodShapes, Wood);
			var wood26:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6200, 415), woodShapes, Wood);
			var wood27:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6400, 445), woodShapes, Wood);
			var wood28:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6600, 475), woodShapes, Wood);
			var wood29:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6800, 505), woodShapes, Wood);
			
			//NEW GROUNDS
			var newGround:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(7500, 535), newGroundShapes, NewGround);
			
			//BOXES
			var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(9000, 340), boxShapes, Box);
			var box1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(9400, 340), boxShapes, Box);
			for (var i:int = 0; i < 6; i++)
			{
				var box2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(16900 + (i * 600), 490), boxShapes, Box);
			}
			
			//RAMPS
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(14000, 535), rampShapes, Ramp);
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(14110, 505), barrelShapes, Barrel);
			
			//METAL RAMPS
			var metalRamp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(15800, 535), metalRampShapes, MetalRamp);
			
		}
		
		private function level6Specifics():void 
		{
			setTimer(100);
			main_level = 6;
			//NEW GROUNDS
			var newGround:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5500, 535), newGroundShapes, NewGround);
			
			//RAMPS
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4600, 535), rampShapes, Ramp);
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4710, 505), barrelShapes, Barrel);
			var ramp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(7500, 383), rampShapes, Ramp);
			var barrel1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(7610, 355), barrelShapes, Barrel);
			
			//METAL RAMPS
			
			//BOXES
			var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6000, 340), boxShapes, Box);
			var box1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6800, 340), boxShapes, Box);
			for (var i = 0; i < 11; i++)
			{
				var box2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(10000 + (i * 600), 490), boxShapes, Box);
			}
			
			//WOODS
			var wood:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(300, 505), woodShapes, Wood);
			var wood1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3200, 505), woodShapes, Wood);
		}
		
		private function level5Specifics():void 
		{
			setTimer(80);
			main_level = 5;
			//NEW GROUNDS
			var newGround:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(200, 535), newGroundShapes, NewGround);
			var newGround1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4500, 535), newGroundShapes, NewGround);
			var newGround2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(17000, 535), newGroundShapes, NewGround);
			
			//RAMP
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3500, 535), rampShapes, Ramp);
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3610, 505), barrelShapes, Barrel);
			var ramp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5700, 385), rampShapes, Ramp);
			var barrel1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5810, 355), barrelShapes, Barrel);
			var ramp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(9500, 535), rampShapes, Ramp);
			var barrel2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(9610, 505), barrelShapes, Barrel);
			var ramp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(14000, 535), rampShapes, Ramp);
			var barrel3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(14110, 505), barrelShapes, Barrel);
			var ramp4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(15500, 535), rampShapes, Ramp);
			var barrel4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(15610, 505), barrelShapes, Barrel);
			var ramp5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(18500, 385), rampShapes, Ramp);
			var barrel5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(18610, 355), barrelShapes, Barrel);
			
			//METAL RAMPS
			var metalRamp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1800, 385), metalRampShapes, MetalRamp);
			var metalRamp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5300, 385), metalRampShapes, MetalRamp);
			var metalRamp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(12000, 535), metalRampShapes, MetalRamp);
			var metalRamp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(15000, 535), metalRampShapes, MetalRamp);
			var metalRamp4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(19500, 535), metalRampShapes, MetalRamp);
			var metalRamp5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(20000, 535), metalRampShapes, MetalRamp);
			var metalRamp6:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(21000, 535), metalRampShapes, MetalRamp);
			
			//BOXES
			var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(600, 340), boxShapes, Box);
			var box1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1200, 340), boxShapes, Box);
			var box2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(13100, 490), boxShapes, Box);
			var box3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(13500, 490), boxShapes, Box);
		}
		
		private function level4Specifics():void 
		{
			setTimer(80);
			main_level = 4;
			//RAMPS
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(200, 535), rampShapes, Ramp);
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(310, 505), barrelShapes, Barrel);
			var ramp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2200, 535), rampShapes, Ramp);
			var barrel1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2310, 505), barrelShapes, Barrel);
			var ramp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4200, 535), rampShapes, Ramp);
			var barrel2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4310, 505), barrelShapes, Barrel);
			var ramp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6200, 535), rampShapes, Ramp);
			var barrel3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6310, 505), barrelShapes, Barrel);
			var ramp4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(8200, 535), rampShapes, Ramp);
			var barrel4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(8310, 505), barrelShapes, Barrel); 
			var ramp5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(10200, 535), rampShapes, Ramp);
			var barrel5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(10310, 505), barrelShapes, Barrel);
			
			//METAL RAMP
			var metalRamp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(11800, 535), metalRampShapes, MetalRamp);
			var metalRamp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(13800, 535), metalRampShapes, MetalRamp);
			var metalRamp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(15800, 535), metalRampShapes, MetalRamp);
			var metalRamp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(17800, 535), metalRampShapes, MetalRamp);
			var metalRamp4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(19800, 535), metalRampShapes, MetalRamp);
			var metalRamp5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(21800, 535), metalRampShapes, MetalRamp);
			
			//BOXES
			var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(1200, 490), boxShapes, Box);
			var box1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3200, 490), boxShapes, Box);
			var box2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5200, 490), boxShapes, Box);
			var box3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(7200, 490), boxShapes, Box);
			var box4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(9200, 490), boxShapes, Box);
			var box5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(11200, 490), boxShapes, Box);
			var box6:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(14800, 490), boxShapes, Box);
			
		}
		
		private function level3Specifics():void 
		{
			setTimer(90);
			main_level = 3;
			//RAMPS
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(800, 535), rampShapes, Ramp);
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(910, 505), barrelShapes, Barrel);
			var ramp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6300, 535), rampShapes, Ramp);
			var barrel1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6410, 505), barrelShapes, Barrel);
			var ramp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(16000, 535), rampShapes, Ramp);
			var barrel2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(16110, 505), barrelShapes, Barrel);
			var ramp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(21000, 535), rampShapes, Ramp);
			var barrel3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(21110, 505), barrelShapes, Barrel);
			
			//METAL RAMP
			var metalRamp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2800, 535), metalRampShapes, MetalRamp);
			var metalRamp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5500, 535), metalRampShapes, MetalRamp);
			var metalRamp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(9000, 535), metalRampShapes, MetalRamp);
			var metalRamp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(18000, 535), metalRampShapes, MetalRamp);
			var metalRamp4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(18500, 535), metalRampShapes, MetalRamp);
			
			//BOXES
			var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4800, 490), boxShapes, Box);
			var box1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(7500, 490), boxShapes, Box);
			var box2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(10000, 490), boxShapes, Box);
			var box3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(12000, 490), boxShapes, Box);
			var box4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(15000, 490), boxShapes, Box);
			var box5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(17000, 490), boxShapes, Box);
			var box6:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(17500, 490), boxShapes, Box);
			var box7:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(19000, 490), boxShapes, Box);
		}
		
		private function level2Specifics():void 
		{
			setTimer(60);
			main_level = 2;
			//RAMPS
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(800, 535), rampShapes, Ramp);
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(910, 505), barrelShapes, Barrel);
			var ramp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3800, 535), rampShapes, Ramp);
			var barrel1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3910, 505), barrelShapes, Barrel);
			var ramp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(12800, 535), rampShapes, Ramp);
			var barrel2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(12910, 505), barrelShapes, Barrel);
			var ramp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(20800, 535), rampShapes, Ramp);
			var barrel3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(20910, 505), barrelShapes, Barrel);
			var ramp4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(8000, 535), rampShapes, Ramp);
			var barrel4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(8110, 505), barrelShapes, Barrel);
			
			//BOXES
			var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2200, 490), boxShapes, Box);
			var box2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(3200, 490), boxShapes, Box);
			var box3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2200, 490), boxShapes, Box);
			var box4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(6300, 490), boxShapes, Box);
			
			
			//METALIC RAMPS
			var metalRamp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(200,535), metalRampShapes, MetalRamp);
			var metalRamp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2800, 535), metalRampShapes, MetalRamp);
			var metalRamp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5500, 535), metalRampShapes, MetalRamp);
			var metalRamp4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(20000, 535), metalRampShapes, MetalRamp);
				
		}
		
		private function level1Specifics():void 
		{
			setTimer(60);
			main_level = 1;
			//adding boxes [DONE]
			var box:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(400, 490), boxShapes, Box);
			var box1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(5400, 490), boxShapes, Box);
			var box2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(10400, 490), boxShapes, Box);
			var box3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(15400, 490), boxShapes, Box);
			var box4:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(20400, 490), boxShapes, Box);
			var box5:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(25400, 490), boxShapes, Box);
			var box6:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(30400, 490), boxShapes, Box);
			var box7:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(35400, 490), boxShapes, Box);
			
			//adding ramps
			var ramp:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2000, 535), rampShapes, Ramp);
			var ramp1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4000, 535), rampShapes, Ramp);
			var ramp2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(8000, 535), rampShapes, Ramp);
			var ramp3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(18000, 535), rampShapes, Ramp);
			
			
			var barrel:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(2110, 505), barrelShapes, Barrel);
			var barrel1:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(4110, 505), barrelShapes, Barrel);
			var barrel2:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(8110,505), barrelShapes, Barrel);
			var barrel3:ArbiStaticActor = new ArbiStaticActor(mainLayer, new Point(18110, 505), barrelShapes, Barrel);
			
			
		}
		
		private function show_time(e:TimerEvent):void 
		{
			timerSecondsText.text = String((uSeconds - e.target.currentCount));
			timerSecondsText.setTextFormat(timerFormat);
			if (int(timerSecondsText.text) == 0)
			{
				//removing things
				time_count.removeEventListener(TimerEvent.TIMER,  show_time);
				mainStage.removeEventListener(Event.ENTER_FRAME, on_enter_frame);
				staticLayer.removeChild(timerSecondsText);
				mainStage.removeChild(mainLayer);
				mainStage.removeChild(staticLayer);
				//adding things
				main_class.show_game_over(current_level);
			}
		}
		private function on_enter_frame(e:Event):void 
		{
			PhysiVals.world.Step(1 / 60.0, 30);
			 playerCar.updateNow();
			playerCar.followCar(mainLayer);
			
			checkGameOver();
			checkGameWon();
			
		}
		private function checkGameWon():void 
		{
			if (levelCompleteWall.getX() -  playerCar.getX() < 100)
			{
				//removing things
				time_count.removeEventListener(TimerEvent.TIMER,  show_time);
				mainStage.removeEventListener(Event.ENTER_FRAME, on_enter_frame);
				staticLayer.removeChild(timerSecondsText);
				mainStage.removeChild(mainLayer);
				mainStage.removeChild(staticLayer);
				//adding stuff
				main_class.show_congratz(current_level);
			}
		}
		
		private function checkGameOver():void 
		{
			if (playerCar.getRotation() > 178 && gameOver == true)
			{	
				//removing things
				time_count.removeEventListener(TimerEvent.TIMER,  show_time);
				mainStage.removeEventListener(Event.ENTER_FRAME, on_enter_frame);
				staticLayer.removeChild(timerSecondsText);
				mainStage.removeChild(mainLayer);
				mainStage.removeChild(staticLayer);
				//adding things
				main_class.show_game_over(current_level);
			}
			
		}
		
		private function makeCar():void
		{
			playerCar = new CarActor(mainStage, mainLayer, new Point(150, 400), CarBody);
			playerCar.addWheels(CarWheel);
		}
		
		private function setupPhysicsWorld():void 
		{
			var worldBounds:b2AABB = new b2AABB();
			worldBounds.lowerBound.Set( -2000, -1200);
			worldBounds.upperBound.Set(2000, 2000);
			
			var gravity:b2Vec2 = new b2Vec2(0,10.0);
			var allowSleep:Boolean = true;
			
			PhysiVals.world = new b2World(worldBounds, gravity, allowSleep);
			PhysiVals.world.SetContactListener(new CGEngineContactListener(this));
		}
	}
}