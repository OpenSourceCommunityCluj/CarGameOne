package CGEngine 
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.b2ContactListener;
	/**
	 * ...
	 * @author Andrei Elvedi
	 */
	public class CGEngineContactListener extends b2ContactListener
	{
		private var main_class:the_game_itself;
		
		public function CGEngineContactListener(passed_class:the_game_itself) 
		{
			main_class = passed_class;
		}
		
		override public function Add(point:b2ContactPoint):void 
		{
			super.Add(point);
			
			if (point.shape1.GetBody().GetUserData() is CarActor && point.shape2.GetBody().GetUserData() is ArbiStaticActor)
			{
				main_class.gameOver = true;
			}	
			else
				main_class.gameOver = false;
		}
	}

}