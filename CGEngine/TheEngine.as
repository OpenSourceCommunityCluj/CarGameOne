package 
{
	import flash.display.MovieClip;
	
	public class TheEngine extends MovieClip
	{
		public var splash_screen:SplashScreen;
		public var play_screen:CGEngine;
		public var game_over_screen:GameOver;
		public var how_to_play_screen:HowToPlayScreen;
		
		public function TheEngine() 
		{
			show_splash();
		}
		public function show_splash() 
		{
			splash_screen = new SplashScreen(this);
			if (how_to_play_screen) 
			{
				removeChild(how_to_play_screen);
				how_to_play_screen = null;
			}
			addChild(splash_screen);
		}
		public function show_how_to_play() 
		{
			how_to_play_screen = new HowToPlayScreen(this);
			removeChild(splash_screen);
			splash_screen = null;
			addChild(how_to_play_screen);
		}
		public function show_game_over()
		{
			game_over_screen = new GameOver(this);
			removeChild(play_screen);
			play_screen = null;
			addChild(game_over_screen);
 
		}
		public function play_the_game() 
		{
			play_screen = new CGEngine(this,stage);
			if (splash_screen) 
			{
				removeChild(splash_screen);
				splash_screen = null;
			}
			if (how_to_play_screen) 
			{
				removeChild(how_to_play_screen);
				how_to_play_screen = null;
			}
			if (game_over_screen)
			{
				removeChild(game_over_screen);
				game_over_screen = null;
			}
			addChild(play_screen);
		}
	}
}