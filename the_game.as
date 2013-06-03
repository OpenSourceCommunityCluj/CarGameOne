package {
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	public class the_game extends Sprite {
		public var splash_screen:splash;
		public var play_screen:the_game_itself;
		public var game_over_screen:game_over;
		public var level_select_screen:level_selection;
		public var how_to_play_screen:how_to_play;
		public var congratz_screen:game_won;
		public function the_game() {
			show_splash();
			stage.focus = play_screen;
		}
		public function show_splash() {
			splash_screen = new splash(this);
			how_to_play_screen=remove_movie_clip(how_to_play_screen);
			level_select_screen=remove_movie_clip(level_select_screen);
			game_over_screen=remove_movie_clip(game_over_screen);
			congratz_screen = remove_movie_clip(congratz_screen);
			addChild(splash_screen);
		}
		public function show_how_to_play() {
			how_to_play_screen = new how_to_play(this);
			splash_screen=remove_movie_clip(splash_screen);
			addChild(how_to_play_screen);
		}
		public function show_game_over(level) {
			game_over_screen = new game_over(this,level);
			play_screen = remove_movie_clip(play_screen);
			
			addChild(game_over_screen);
		}
		public function show_congratz(level) {
			congratz_screen = new game_won(this,level);
			play_screen=remove_movie_clip(play_screen);
			addChild(congratz_screen);
		}
		public function select_the_level() { 
			level_select_screen = new level_selection(this);
			splash_screen=remove_movie_clip(splash_screen);
			how_to_play_screen=remove_movie_clip(how_to_play_screen);
			game_over_screen=remove_movie_clip(game_over_screen);
			congratz_screen=remove_movie_clip(congratz_screen);
			addChild(level_select_screen);
		}
		public function play_the_game(level) { 	
			play_screen = new the_game_itself(this,level,stage);
			level_select_screen=remove_movie_clip(level_select_screen);
			game_over_screen=remove_movie_clip(game_over_screen);
			congratz_screen = remove_movie_clip(congratz_screen);
			addChild(play_screen);
		}
		
		private function remove_movie_clip(clip:*) 
		{
			if (clip) 
			{
				removeChild(clip);
			}
			return null;
		}
	}
}