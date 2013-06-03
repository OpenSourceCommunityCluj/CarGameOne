package {
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.text.*;
	public class game_won extends Sprite {
		public var main_class:the_game;
		public var last_level:int;
		public var shared:SharedObject;
		public function game_won(passed_class:the_game, level:int) 
		{
			shared = SharedObject.getLocal("savegame");
			shared.data.level_passed=level+1
			shared.close();
			last_level = level;
			if (level == 8)
				next_level_button.visible = false;
			else	 
				next_level_button.visible = true;
			main_class = passed_class;
			congratztext.text = "Level "+level+" completed";
			next_level_button.addEventListener(MouseEvent.CLICK, next_level_button_clicked);
			level_select_button.addEventListener(MouseEvent.CLICK, level_select_button_clicked);
			main_menu_button.addEventListener(MouseEvent.CLICK, on_main_menu_button_clicked);
		}
		public function next_level_button_clicked(event:MouseEvent) {
			main_class.play_the_game(last_level+1);
		}
		public function level_select_button_clicked(event:MouseEvent) {
			main_class.select_the_level();
		}
		public function on_main_menu_button_clicked(event:MouseEvent) {
			main_class.show_splash();
		}
	}
}