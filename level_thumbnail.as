package {
	import CGEngine.PhysiVals;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.net.SharedObject;
	
	public class level_thumbnail extends Sprite 
	{
		public var main_class:the_game;
		public var level_number:int;
		public var shared:SharedObject;
		
		public function level_thumbnail(i:int, passed_class:the_game) 
		{
			shared = SharedObject.getLocal("savegame");
			
				
			if (shared.data.level_passed == undefined) 
			{
				shared.data.level_passed=1;
			}
			if (shared.data.level_passed < i) 
			{
				alpha = 0.5;
			}
			else 
			{
				this.buttonMode = true;
				
				this.mouseChildren = false;
				addEventListener(MouseEvent.CLICK, on_level_clicked);
			}
			main_class = passed_class;
			level_number = i;
			leveltext.text = "  " + i;
			shared.close();
		}
		public function on_level_clicked(event:MouseEvent) 
		{
			main_class.play_the_game(level_number);
		}
	
	}
}