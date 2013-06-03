package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Andrei Elvedi
	 */
	public class HowToPlayScreen extends MovieClip
	{
		public var main_class:TheEngine;
		
		public function HowToPlayScreen(passed_class:TheEngine) 
		{
			main_class = passed_class;
			play_button.addEventListener(MouseEvent.CLICK, on_play_b_click);
			back_button.addEventListener(MouseEvent.CLICK, on_back_button_click);
		}
		
		private function on_back_button_click(e:MouseEvent):void 
		{
			main_class.show_splash();
		}
		
		private function on_play_b_click(e:MouseEvent):void 
		{
			main_class.play_the_game();
		}
		
	}

}