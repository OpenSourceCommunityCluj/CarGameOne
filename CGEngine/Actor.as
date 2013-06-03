package  CGEngine
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Andrei Elvedi
	 */
	public class Actor extends EventDispatcher
	{
		protected var _body:b2Body;
		protected var _costume:DisplayObject;
		
		public function Actor(myBody:b2Body, myCostume:DisplayObject) 
		{
			_body = myBody;
			_body.SetUserData(this);
			_costume = myCostume;
			
			updateMyLook();
		}
		
		public function updateNow():void
		{
			updateMyLook();
			childSpecificUpdating();
		}
		
		protected function childSpecificUpdating():void 
		{
			//This function does shit
			//TODO: inherited by child classes
			//their bussines now >:)
		}
		
		
		protected function updateMyLook():void
		{
			_costume.x =  _body.GetPosition().x * PhysiVals.RATIO;
			_costume.y =  _body.GetPosition().y * PhysiVals.RATIO;
			_costume.rotation = _body.GetAngle() * 180 / Math.PI;
		}
		public function destroy():void
		{
			//Remove the Actor from the world
			//TODO: Finish this later
		}
		
	}

}