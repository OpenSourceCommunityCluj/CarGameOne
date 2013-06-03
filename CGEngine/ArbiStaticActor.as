package  CGEngine
{
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Andrei Elvedi
	 */
	public class ArbiStaticActor extends Actor
	{
		var univBody:b2Body;
		var costume:Sprite = new Sprite();
		public function ArbiStaticActor(parent:Sprite, location:Point, arrayOfCoords:Array, Type:Class = null) 
		{ 
			var myBody:b2Body = createBodyFromCoords(arrayOfCoords, location);
			univBody = myBody;
			
			if (Type != null)
			{
				costume = new Type();
				parent.addChild(costume);
			}
			
			super(myBody, costume);
		}
		
		private function createBodyFromCoords(arrayOfCoords:Array, location:Point):b2Body
		{
			//Define a shape
			var allShapesDefs:Array = [];
			
			for each(var listOfPoints:Array in arrayOfCoords)
			{
				var newShapeDef:b2PolygonDef = new b2PolygonDef();
				newShapeDef.vertexCount = listOfPoints.length;
				for (var i:int = 0; i < listOfPoints.length; i++)
				{
					var nextPoint:Point = listOfPoints[i];
					b2Vec2(newShapeDef.vertices[i]).Set(nextPoint.x / PhysiVals.RATIO, nextPoint.y / PhysiVals.RATIO);
					
				}
				newShapeDef.density = 0;
				newShapeDef.friction = 30;
				
				allShapesDefs.push(newShapeDef);
			}
			
			//Define a body
			var arbiBodyDef:b2BodyDef = new b2BodyDef();
			arbiBodyDef.position.Set(location.x / PhysiVals.RATIO, location.y / PhysiVals.RATIO);
			
			//Create the body
			var arbiBody:b2Body = PhysiVals.world.CreateBody(arbiBodyDef);
			
			//Create the shapes
			for each (var newShapeDefToAdd:b2ShapeDef in allShapesDefs)
			{
				arbiBody.CreateShape(newShapeDefToAdd);
			}
			
			arbiBody.SetMassFromShapes();
			
			return arbiBody;
			
		}
		override protected function updateMyLook():void 
		{
			super.updateMyLook();
			
			costume.x =  univBody.GetPosition().x * PhysiVals.RATIO;
			costume.y =  univBody.GetPosition().y * PhysiVals.RATIO;
			costume.rotation = univBody.GetAngle() * 180 / Math.PI;
		}
		
		public function getX():Number
		{
			return costume.x;
		}
	}

}