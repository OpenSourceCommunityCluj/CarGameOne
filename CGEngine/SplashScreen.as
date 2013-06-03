package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Andrei Elvedi
	 */
	public class SplashScreen extends MovieClip
	{
		public var main_class:TheEngine;
		public function SplashScreen(passed_class:TheEngine) 
		{
			main_class = passed_class;
			play_button_first.addEventListener(MouseEvent.CLICK, on_play_button_first_click);
			how_to_play_button.addEventListener(MouseEvent.CLICK, on_how_to_play_button_click);
		}
		
		private function on_play_button_first_click(e:MouseEvent):void 
		{
			main_class.play_the_game();
		}
		private function on_how_to_play_button_click(e:MouseEvent):void
		{
			main_class.show_how_to_play();
		}
		
	}

}