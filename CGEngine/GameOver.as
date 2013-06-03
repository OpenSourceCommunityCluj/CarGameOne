package 
{
	import fl.controls.dataGridClasses.HeaderRenderer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class GameOver extends MovieClip
	{
		public var main_class:TheEngine;
		public function GameOver(passed_class:TheEngine) 
		{
			main_class = passed_class;
			play_again.addEventListener(MouseEvent.CLICK, on_play_again_click);
		}
		
		private function on_play_again_click(e:MouseEvent):void 
		{
			main_class.play_the_game();
		}
	}
}