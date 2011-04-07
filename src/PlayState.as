package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author robots
	 */
	public class PlayState extends FlxState
	{
		private var stock_market:HistoryBuffer
		private var stock_a:Stock
		private var stock_b:Stock
		private var stock_c:Stock
		
		private var player:FlxSprite
		
		private var money:Number = 100
		private var money_text:FlxText
		public static var tickers:FlxGroup = new FlxGroup()
		
		private var stock_buffer:HistoryBuffer
		private var temp_buffer:BitmapData
		
		public function PlayState() {
			super()
		}
		
		override public function create():void {
			add(tickers)
			player = new FlxSprite()
			stock_market = new HistoryBuffer(player)
			stock_a = new Stock("MSFT", 0xffff0000, 19)
			stock_b = new Stock("GOOG", 0xff00ff00, 20)
			stock_c = new Stock("AAPL", 0xff0000ff, 21)
			
			
			
			add(stock_market)
			stock_market.add(stock_a)
			stock_market.add(stock_b)
			stock_market.add(stock_c)
			
			money_text = new FlxText(0, 0, 200, "")
			money_text.color = 0xffffff00
			addTicker(money_text)
			add(player)
			
			//FlxG.addCamera()
			//FlxG.camera.target = player
			//FlxG.camera = new FlxCamera( -200, 0, FlxG.width, FlxG.height)
			FlxG.camera.follow(player)

			trace(FlxG.cameras.length)
		}
		override public function update():void {
			super.update()
			player.x += 0.5
			
			compute_profits(FlxG.keys.Z, stock_a)
			compute_profits(FlxG.keys.X, stock_b)
			compute_profits(FlxG.keys.C, stock_c)
			
			money_text.text = printf("Money: %.02f", money)
			//FlxG.camera.focusOn(new FlxPoint(player.x, player.y))
		}

		private function compute_profits(holding:Boolean, stock:Stock):void {
			if (holding) {
				if (stock.owned) {
					money += stock.profit
					trace(stock.profit)
				} else {
					stock.owned = true
					money -= stock.price
				}
			} else {
				if (stock.owned) {
					stock.owned = false
					money += stock.price
				}
			}

		}
		private static var ticker_height:Number = 0
		public static function addTicker(Symbol:FlxText):void {
			tickers.add(Symbol)
			Symbol.y = ticker_height
			Symbol.scrollFactor.x = Symbol.scrollFactor.y = 0
			ticker_height += Symbol.height
		}
	}
	
}