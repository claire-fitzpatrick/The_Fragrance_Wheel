package  {
	import feathers.controls.Panel;
	import feathers.controls.Button;
	import feathers.events.FeathersEventType;
	import starling.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import starling.utils.AssetManager;
	import starling.display.Button;
	
	public class TabA extends Panel
	{

		protected var button:Button;
		private var theAssetManager:AssetManager;
		
		public function TabA() {
			// constructor code
			super()
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
	public function setAssetManager(am:AssetManager):void
		{
			if (am is AssetManager)
			{
				this.theAssetManager = am;
			}
		}
		private function initializeHandler(e:Event):void
		{
			this.button = new Button();
			this.button.label="Click Me";
			
			this.button.addEventListener(Event.TRIGGERED, button_TriggeredHandle);
			this.addChild(this.button);
			this.button.validate();
			
			this.button.x = (this.stage.stageWidth - this.button.width) /2;
			this.button.y = (this.stage.stageHeight - this.button.height) /2;
		}
		private function button_TriggeredHandle(e:Event):void
		{
			trace ("Button clicked");
			theAssetManager.playSound("beep");
		}
	}
	
}
