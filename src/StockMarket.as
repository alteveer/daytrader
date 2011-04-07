package  
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.FlxObject;
	import org.flixel.FlxGroup
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite
	import org.flixel.FlxG
	import org.flixel.FlxU
	/**
	 * ...
	 * @author robots
	 */
	 public class StockMarket extends FlxSprite {
		private var _fx:FlxSprite;
		/**
         * @param   ang This is the angle that the starField will be rotating (in degrees)
         * @param   speedMultiplier
         */
        override public function StockMarket(Color:uint):void {
			
			_fx = new FlxSprite()
			_fx.createGraphic(FlxG.width, FlxG.height, 0x00000000, true);

        }
 
        override public function update():void {			
			super.update()
			
        }
		override public function render():void {
		
		//fade alpha of ether buffer
			//_fx.fill(0x10000000)
			_fx.pixels.colorTransform(new Rectangle(0, 0, FlxG.width, FlxG.height), new ColorTransform(1, 1, 1, 0.8));
			
			//save FlxG.buffer
			var tmp:BitmapData = FlxG.buffer;
			
			//point FlxG.buffer at our ether sprite so the bullets gets drawn onto this instead of FlxG.buffer
			FlxG.buffer = _fx.pixels;
			
			
			super.render();
			
			//put the buffer back
			FlxG.buffer = tmp;
			
			// copy our ether buffer to the main flxel buffer
			FlxG.buffer.copyPixels(_fx.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), null, null, true);
		}
    }

}