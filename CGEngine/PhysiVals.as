package  CGEngine
{
	import Box2D.Dynamics.b2World;
	/**
	 * ...
	 * @author Andrei Elvedi
	 */
	public class PhysiVals 
	{
		public static const RATIO:Number = 30;
		private static var _world:b2World;
		
		public function PhysiVals() 
		{
			
		}
		
		static public function get world():b2World 
		{
			return _world;
		}
		
		static public function set world(value:b2World):void 
		{
			_world = value;
		}
	}

}