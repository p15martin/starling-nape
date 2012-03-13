package
{
	import flash.display.Sprite;

	import net.hires.debug.Stats;

	import starling.core.Starling;

	[SWF(frameRate=60, width=1024, height=748, backgroundColor=0x000000)]
	public class StarlingNape extends Sprite
	{
		public function StarlingNape()
		{
			var star : Starling = new Starling( Main, stage );
			star.simulateMultitouch = true;
//			Starling.multitouchEnabled = true;
			star.start();

			addChild( new Stats() );
		}
	}
}