package
{
	import nape.phys.Body;

	import starling.display.Image;
	import starling.display.Sprite;

	public class Basketball extends Sprite
	{
		[Embed(source="basketball.png")]
		private var basketball : Class;

		public function Basketball()
		{
			addChild( Image.fromBitmap( new basketball() ) );
			this.pivotX = this.width >> 1;
			this.pivotY = this.height >> 1;
		}
	}
}