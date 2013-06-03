package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	public class level_selection extends Sprite 
	{
		public var main_class:the_game;
		private var level_thumb:level_thumbnail;
		private var incrementX:Number = 0;
		private var incrementY:Number = 100;
		
		public function level_selection(passed_class:the_game) 
		{
			main_class = passed_class;
			for (var i:int = 1; i <= 8; i++) 
			{
				level_thumb = new level_thumbnail(i, main_class);
				level_thumb.x = 120 + incrementX;
				level_thumb.y = incrementY;
				addChild(level_thumb);
				incrementX += 120;
				if (incrementX % 480 == 0)
				{
					incrementY += 100;
					incrementX = 0;
				}
			}
			main_menu_button.addEventListener(MouseEvent.CLICK, on_main_menu_button_clicked);
		}
		public function on_main_menu_button_clicked(event:MouseEvent) {
			main_class.show_splash();
		}
	}
}