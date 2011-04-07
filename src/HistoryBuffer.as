package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG
	import flash.display.BitmapData
	import flash.geom.Rectangle
	import flash.geom.Point
	import flash.geom.ColorTransform
	/**
	 * ...
	 * @author robots
	 */
	public class HistoryBuffer extends FlxGroup
	{
		protected var buffer:FlxSprite
		protected var temp_buffer:BitmapData
		public var player:FlxSprite
		protected var previous_x:Number = 0
		public function HistoryBuffer(Player:FlxSprite) 
		{
			buffer = new FlxSprite()
			buffer.makeGraphic(FlxG.width, FlxG.height, 0x00000000);
			player = Player
		}
		
		override public function update():void {
			super.update()
			for each(var m:Stock in members) {
				m.x = player.x
			}
		}
		override public function draw():void {
			super.draw()
				//fade alpha of ether buffer
			//_fx.fill(0x10000000)
			buffer.pixels.colorTransform(new Rectangle(0, 0, FlxG.width, FlxG.height), new ColorTransform(1, 1, 1, 0.999	));
			buffer.pixels.scroll(previous_x - player.x, 0)
			previous_x = player.x
			//save FlxG.buffer
			temp_buffer = FlxG.camera.buffer;
			
			//point FlxG.buffer at our ether sprite so the bullets gets drawn onto this instead of FlxG.buffer
			FlxG.camera.buffer = buffer.pixels;
			
			super.draw();
			
			//put the buffer back
			FlxG.camera.buffer = temp_buffer;
			
			// copy our ether buffer to the main flxel buffer
			FlxG.camera.buffer.copyPixels(buffer.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(), null, null, true);
		}

		
	}

}