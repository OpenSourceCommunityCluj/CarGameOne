package  CGEngine
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Andrei Elvedi
	 */
	public class CarActor extends Actor
	{
		private static const CAR_WIDTH:int = 100;
		private static const CAR_HEIGHT:int = 20;
		private static const WHEEL_DIAM:int = 32;
		private var wheelBody:b2Body;
		private var wheelBody2:b2Body;
		private var carBody:b2Body;
		private var globalLocation:Point;
		private var uParent:Sprite;
		private var wheelSprite1:Sprite;
		private var wheelSprite2:Sprite;
		private var frontWheelRevoluteJointDef:b2RevoluteJointDef;
		private var rearWheelRevoluteJointDef:b2RevoluteJointDef;
		private var frontWheelRevoluteJoint:b2RevoluteJoint;
		private var rearWheelRevoluteJoint:b2RevoluteJoint;
		private var left:Boolean;
		private var carSprite:MovieClip = new MovieClip();
		private var up:Boolean;
		private var right:Boolean;
		private var down:Boolean;
		private var motorSpeed:Number = 0;
		private var wheelsSet:Boolean = false;
		private const DRAW_SCALE:Number = 50;
		private const SCREEN_WIDTH:Number  = 640;
		private const SCREEN_HEIGHT:Number = 480;
		private var rotation1:Number = 0;
		private var rotation2:Number = 0;
		
		public function CarActor(stage :Stage, parent:Sprite, location:Point, Type:Class)
		{
			//passing variables
			globalLocation = location;
			
			uParent = parent;
			stage.focus = stage;
			
			//First , create the costume
			carSprite = new Type();
			carSprite.width = 100;
			carSprite.height = 20;
			parent.addChild(carSprite);
			
			//Create the shape definition
			var carShapeDef:b2PolygonDef = new b2PolygonDef();
			carShapeDef.SetAsBox((carSprite.width - 1) / 2 / PhysiVals.RATIO, (carSprite.height - 1) / 2 / PhysiVals.RATIO);
			carShapeDef.friction = 0;
			carShapeDef.density = 1.5;
			
			//Create the body definition (+location)
			var carBodyDef:b2BodyDef = new b2BodyDef();
			carBodyDef.position.Set(location.x / PhysiVals.RATIO, location.y / PhysiVals.RATIO);
			
			
			//Create the body
			carBody = PhysiVals.world.CreateBody(carBodyDef);
			
			//Create the shape
			carBody.CreateShape(carShapeDef);
			carBody.SetMassFromShapes();
			
			super(carBody, carSprite); 
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, releaseKey);
		}
		
		private function pressKey(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case 37:left = true; 
						break;
				case 38:up = true;
						break;
				case 39:right = true;
						break;
				case 40:down = true;
						break;
			}
		}
		private function releaseKey(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case 37:left = false;
						break;
				case 38:up = false;
						break;
				case 39:right = false;
						break;
				case 40:down = false;
						break;
			}
		}
		
		
		public function addWheels(Type:Class):void
		{
			
			//Create costum
			wheelSprite1= new Type();
			uParent.addChild(wheelSprite1);
			
			// Create shape definition for wheel
			var wheelShapeDef:b2CircleDef = new b2CircleDef();
			wheelShapeDef.radius = WHEEL_DIAM / 2 / PhysiVals.RATIO;
			wheelShapeDef.friction = 7;
			wheelShapeDef.density = 1;
			
			
			// Create body definition 
			var wheelBodyDef:b2BodyDef = new b2BodyDef();
			wheelBodyDef.position.Set((globalLocation.x / PhysiVals.RATIO - 1.3), (globalLocation.y / PhysiVals.RATIO) + 1);
			
			// Create body
			wheelBody= PhysiVals.world.CreateBody(wheelBodyDef);
		
			// Create shape
			wheelBody.CreateShape(wheelShapeDef);
			wheelBody.SetMassFromShapes();
			
			//add 2nd wheel
			
			//Create costume
			wheelSprite2 = new CarWheel();
			uParent.addChild(wheelSprite2);
			
			// Create shape definition for wheel
			var wheelShapeDef2:b2CircleDef = new b2CircleDef();
			wheelShapeDef2.radius = WHEEL_DIAM / 2 / PhysiVals.RATIO;
			wheelShapeDef2.friction = 17;
			wheelShapeDef2.density = 1;
			
			
			// Create body definition 
			var wheelBodyDef2:b2BodyDef = new b2BodyDef();
			wheelBodyDef2.position.Set((globalLocation.x / PhysiVals.RATIO + 1.3), (globalLocation.y / PhysiVals.RATIO) + 1);
			
			// Create body
			wheelBody2 = PhysiVals.world.CreateBody(wheelBodyDef2);
			
			// Create shape
			wheelBody2.CreateShape(wheelShapeDef2);
			wheelBody2.SetMassFromShapes();
			
			wheelsSet = true;
			
			//Create Joints
			createJoints(); 
		}
		
		private function createJoints():void 
		{
			//front joint
			frontWheelRevoluteJointDef = new b2RevoluteJointDef();
			frontWheelRevoluteJointDef.Initialize(wheelBody2, carBody, wheelBody2.GetWorldCenter());
			frontWheelRevoluteJointDef.motorSpeed = 5;
			frontWheelRevoluteJointDef.enableMotor=true;
			frontWheelRevoluteJoint = PhysiVals.world.CreateJoint(frontWheelRevoluteJointDef) as b2RevoluteJoint;	
			
			//rear joint
			rearWheelRevoluteJointDef = new b2RevoluteJointDef();
			rearWheelRevoluteJointDef.Initialize(wheelBody, carBody , wheelBody.GetWorldCenter());
			rearWheelRevoluteJointDef.motorSpeed = 5;
			rearWheelRevoluteJointDef.enableMotor = true;
			rearWheelRevoluteJoint = PhysiVals.world.CreateJoint(rearWheelRevoluteJointDef) as b2RevoluteJoint;	
		}
		
		override protected function childSpecificUpdating():void 
		{
			super.childSpecificUpdating();
			
			if (wheelsSet == true)
			{
				updateWheels(); 
				moveCar();
			}
		}
		public function getWorldCenterX():Number
		{
			return carBody.GetWorldCenter().x;
		}
		public function getWorldCenterY():Number
		{
			return carBody.GetWorldCenter().y;
		}
		public function getLinearVelocityX():Number
		{
			return carBody.GetLinearVelocity().x;
		}
		public function getLinearVelocityY():Number
		{
			return carBody.GetLinearVelocity().y;
		}
		
		public function followCar(debugSprite:Sprite):void 
		{
			debugSprite.x = -30 * carBody.GetWorldCenter().x +  640 / 2;
			debugSprite.y = ((-30* carBody.GetWorldCenter().y + 2*300/3 ))/3;
		}
		
		private function moveCar():void 
		{
			carBody.WakeUp();
			frontWheelRevoluteJoint.SetMotorSpeed(15 * Math.PI * (up ? -1 : down ? 1: 0 ));
			
			frontWheelRevoluteJoint.SetMaxMotorTorque(up || down ? 12 : 0.5);
			
			rearWheelRevoluteJoint.SetMotorSpeed(15 * Math.PI *(up ? -1 : down ? 1: 0));
			rearWheelRevoluteJoint.SetMaxMotorTorque(up || down ? 12 : 0.5);
			
			if (left)
			{
				carBody.ApplyTorque(-40);
			}
			if (right) 
			{
				carBody.ApplyTorque(40);
			}
		}
		
		private function updateWheels():void
		{
			rotation1 = (wheelBody.GetAngle() * 180 / Math.PI) % 360;
			wheelSprite1.x = wheelBody.GetPosition().x * PhysiVals.RATIO;
			wheelSprite1.y = wheelBody.GetPosition().y * PhysiVals.RATIO;
			wheelSprite1.rotation = rotation1;
			
			
			rotation2 = (wheelBody2.GetAngle() * 180 / Math.PI) % 360;
			wheelSprite2.x = wheelBody2.GetPosition().x * PhysiVals.RATIO;
			wheelSprite2.y = wheelBody2.GetPosition().y * PhysiVals.RATIO;
			wheelSprite2.rotation = rotation2;
		}
		
		public function getRotation():Number
		{
			return carSprite.rotation;
		}
		
		public function getX():Number
		{
			return _costume.x;
		}
	}
}