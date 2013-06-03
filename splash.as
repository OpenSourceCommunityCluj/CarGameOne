package {
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	public class splash extends Sprite {
		public var main_class:the_game;
		public function splash(passed_class:the_game) {
			main_class = passed_class;
			play_button.addEventListener(MouseEvent.CLICK, on_play_button_clicked);
			how_to_button.addEventListener(MouseEvent.CLICK, on_how_to_button_clicked);
		}
		public function on_play_button_clicked(event:MouseEvent) {
			main_class.select_the_level();
		}
		public function on_how_to_button_clicked(event:MouseEvent) {
			main_class.show_how_to_play();
		}
	}
}