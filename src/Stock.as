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
	import org.flixel.FlxText;
	import org.flixel.FlxU
	/**
	 * ...
	 * @author robots
	 */
	 public class Stock extends FlxSprite {

		 private var _symbol:String 
		 //private var _color:uint 
		 private var _price:Number
		 private var _previous_price:Number
		 private var _profit:Number
		 
		 public var symbol_text:FlxText
		 public var owned:Boolean = false
		 private static var volatility:Number = 4
		public function Stock(Symbol:String, Color:uint, StartingPrice:Number = 20):void {
			super()
			_symbol = Symbol
			_color = Color
			_price = StartingPrice
			trace(_price, _symbol)
			makeGraphic(1, 1, _color)
			symbol_text = new FlxText(0, 0, 200, _symbol)
			PlayState.addTicker(symbol_text)
        }
		override public function update():void {
			super.update()
			if(price > 0) {
				_price = _price + ((FlxG.random() * (1 * volatility)) - (0.5 * volatility))
				y = -_price
				_profit = _price - _previous_price
				_previous_price = _price
				symbol_text.text = printf("%s: %.02f", _symbol, _price)
			} else {
				symbol_text.text = printf("%s: BANKRUPT", _symbol)
			}
		}
		
		public function get symbol():String {
			return _symbol
		}
		public function get price():Number {
			return _price
		}
		public function get profit():Number {
			return _profit
		}
    }

}