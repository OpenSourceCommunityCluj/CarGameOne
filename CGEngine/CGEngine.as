/**
 * ...
 * @author Andrei Elvedi
 */
package  CGEngine
{
	
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class CGEngine extends MovieClip 
	{
		var playerCar:CarActor;
		var obstacle:ArbiStaticActor;
		var obstacle1:ArbiStaticActor;
		var obstacle2:ArbiStaticActor;
		var ground:ArbiStaticActor;
		var leftWall:ArbiStaticActor;
		var rightWall:ArbiStaticActor;
		var debugSprite:Sprite = new Sprite();
		var wcX:Number = 0;
		var wcY:Number = 0;
		var lvX:Number = 0;
		var lvY:Number = 0;
		var mainLayer:Sprite = new Sprite();
		var main_class:TheEngine;
		
		
		public function CGEngine(passed_class:TheEngine) 
		{
			setUpPhysicsWorld();
			makeCar();
			addEventListener(Event.ENTER_FRAME, gameLoop);
			stage.addChild(mainLayer);
			main_class = passed_class;
		}
		public function gameLoop(e:Event):void 
		{
			PhysiVals.world.Step(1 / 60.0, 30);
			playerCar.updateNow();
			playerCar.followCar(mainLayer); 
		}
		
		private function makeCar():void
		{
			playerCar = new CarActor(stage,mainLayer, new Point(100,300), CarBody);
			playerCar.addWheels(CarWheel);
			
			//obstacle 1
			var obstacleShapes:Array = [ [ new Point(0, 0), new Point(50, 0), new Point(50, 45), new Point(0, 45) ] ];
			obstacle = new ArbiStaticActor(mainLayer, new Point(480, 390), obstacleShapes, Box);
			
			//obstacle 2
			var obstacle1Shapes:Array = [[new Point(0, 0), new Point(100, -80), new Point(100, 15), new Point(0, 15)]];
			obstacle1 = new ArbiStaticActor(mainLayer, new Point(200, 420), obstacle1Shapes);
			
			//obstacle 3
			var obstacle2Shapes:Array = [[new Point(0, 25), new Point(230, -80), new Point(830, -80), new Point(1230, 25)]];
			obstacle2 = new ArbiStaticActor(mainLayer, new Point(850, 410), obstacle2Shapes);
			
			//ground 
			var groundShapes:Array = [[new Point(-100, 0), new Point(3200, 0), new Point(3200, 45), new Point(-100, 45)]];
			ground = new ArbiStaticActor(mainLayer, new Point(0, 435), groundShapes, Ground);
			
			//left wall
			var leftWallShapes:Array = [[new Point(0, 0), new Point(10, 0), new Point(10, 435), new Point(0, 435)]];
			leftWall = new ArbiStaticActor(mainLayer, new Point(0, 0), leftWallShapes);
			
			//right wall
			var rightWallShapes:Array = [[new Point(0,0), new Point(10,0), new Point(10,435), new Point(0,435)]];
			rightWall = new ArbiStaticActor(mainLayer, new Point(3190, 0), rightWallShapes);
			
		}
		
		private function setUpPhysicsWorld():void
		{
			//create the world
			var worldBounds:b2AABB = new b2AABB();
			worldBounds.lowerBound.Set( -200, -100);
			worldBounds.upperBound.Set( 200, 200);
			
			var gravity:b2Vec2 = new b2Vec2(0, 10.0);
			var allowSleep:Boolean = true;
			
			PhysiVals.world = new b2World(worldBounds, gravity, allowSleep);
			
			
			/*
			//[MOFT] in plus
			var debugSprite:Sprite = new Sprite();
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			dbgDraw.m_sprite = debugSprite;
			debugSprite.visible = true;
			addChild(dbgDraw.m_sprite);
			dbgDraw.m_drawScale = 30;
			dbgDraw.m_fillAlpha = 0.3;
			dbgDraw.m_lineThickness = 1.0;
			dbgDraw.m_drawFlags = b2DebugDraw.e_shapeBit |b2DebugDraw.e_centerOfMassBit;
			PhysiVals.world.SetDebugDraw(dbgDraw);
			//endOf(MOFT)
			*/
			
		}
	}
	
}
