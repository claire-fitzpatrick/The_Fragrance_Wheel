﻿package {
	import starling.events.Event;
	import starling.display.Sprite;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.Panel;
	import feathers.controls.ImageLoader;
	import feathers.controls.TabBar;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.Image;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import starling.display.Button;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import feathers.data.ListCollection;
	import starling.utils.AssetManager;
	import flash.text.engine.TabAlignment;
	import flash.text.engine.EastAsianJustifier;


	public class Main extends Screen {
		[Embed(source = "TheFragranceWheel_Sprite.xml", mimeType = "application/octet-stream")]
		public static const ATLAS_XML: Class;

		[Embed(source = "TheFragranceWheel_Sprite.png")]
		public static const ATLAS_TEXTURE: Class;

		private var atlas: TextureAtlas;
		private var atlasTexture: Texture;
		private var bgTexture: Texture;
		private var bgImgLoader: ImageLoader;

		protected var button: Button;
		/*		protected var button2: Button;
		protected var button3: Button;*/
		private var contentPanel: Panel;
		private var buttonPanel: Panel;

		//Audio code

		private var tabA: TabA;
		private var tabBar: TabBar;

		private var contentPanelLayoutData: AnchorLayoutData;
		private var tabsLayoutData: AnchorLayoutData;

		private var assetMgr: AssetManager;

		//
		public function Main() {
			// constructor code
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(e: Event): void {


			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			assetMgr.enqueue(EmbeddedAssets);
			assetMgr.loadQueue(handleAssetsLoading);




			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);

			new MetalWorksMobileTheme();

			var screenLayout: AnchorLayout = new AnchorLayout();
			this.layout = screenLayout;

			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;

			atlasTexture = Texture.fromBitmap(new ATLAS_TEXTURE());

			var xml: XML = XML(new ATLAS_XML());
			atlas = new TextureAtlas(atlasTexture, xml);

			this.buttonPanel = new Panel();

			var buttonPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			buttonPanelLayoutData.left = 10;
			buttonPanelLayoutData.right = 10;
			buttonPanelLayoutData.bottom = 10;

			this.buttonPanel.layoutData = buttonPanelLayoutData;

			var buttonPanelLayout: HorizontalLayout = new HorizontalLayout();
			buttonPanelLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.buttonPanel.layout = buttonPanelLayout;
			this.addChild(this.buttonPanel);

			this.contentPanel = new Panel();

			var contentPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			contentPanelLayoutData.top = 10;
			contentPanelLayoutData.bottom = 10;
			contentPanelLayoutData.left = 10;
			contentPanelLayoutData.right = 10;

			contentPanelLayoutData.bottomAnchorDisplayObject = this.buttonPanel;

			contentPanel.layoutData = contentPanelLayoutData;

			this.addChild(contentPanel);
			//Getting sprite
			bgTexture = atlas.getTexture("ForHer0000");

			//ImageLoader created
			bgImgLoader = new ImageLoader();
			//Texture goes into ImageLoader

			bgImgLoader.source = bgTexture;
			bgImgLoader.width = this.stage.stageWidth;
			bgImgLoader.maintainAspectRatio = true;
			//bgImgLoader loaded into the contentPanel

			contentPanel.addChild(bgImgLoader);

			this.button = new Button();
			//End of screen buttons
			//	this.button1 = new Button();
			//	this.button1.label = "Page One!";
			//	this.button1.addEventListener(Event.TRIGGERED, button_TriggerHandle);
			//	/*		this.button2 = new Button();
			//this.button2.label = "Page Two!";
			//this.button2.addEventListener(Event.TRIGGERED, button_TriggerHandle);
			//this.button3 = new Button();
			//this.button3.label = "Page Three!";
			//this.button3.addEventListener(Event.TRIGGERED, button_TriggerHandle);*/

			//	this.buttonPanel.addChild(this.button1);
			//}
			this.button.label = "Click Me";

			this.button.addEventListener(Event.TRIGGERED, button_triggeredHandler);

			this.buttonPanel.addChild(this.button);
		}
		private function handleAssetsLoading(ratioLoaded: Number): void {
			trace("handleAssetsLoading: " + ratioLoaded);

			if (ratioLoaded == 1) {
				startApp();
			}
		}
		private function startApp() {
			new MetalWorksMobileTheme();

			this.layout = new AnchorLayout();

			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;

			tabBar = new TabBar();
			tabBar.dataProvider = new ListCollection(
				[{
					label: "One"
				}, {
					label: "Two"
				}, {
					label: "Three"
				}, {
					label: "Four"
				}, {
					label: "Five"
				}, ]);
			tabBar.selectedIndex = 1;
			tabBar.addEventListener(Event.CHANGE, tabs_changeHandler);

			tabsLayoutData = new AnchorLayoutData();
			tabsLayoutData.bottom = 5;
			tabsLayoutData.left = 5;
			tabsLayoutData.right = 5;

			tabBar.layoutData = tabsLayoutData;

			this.addChild(tabBar);

			contentPanelLayoutData = new AnchorLayoutData();
			contentPanelLayoutData.top = 5;
			contentPanelLayoutData.left = 5;
			contentPanelLayoutData.right = 5;
			contentPanelLayoutData.bottom = 1;

			contentPanelLayoutData.bottomAnchorDisplayObject = tabBar;

			tabA = new TabA();
			tabA.layoutData = contentPanelLayoutData;

			tabA.setAssetManager(assetMgr);
			this.contentPanel = tabA;
			this.addChild(contentPanel);
		}
		private function tabs_changeHandler(e: Event): void {
			trace("selectedIndex:", tabBar.selectedIndex);
		}
		/*		this.buttonPanel.addChild(this.button2);
		this.buttonPanel.addChild(this.button3);*/
		protected function button_triggeredHandler(event: Event): void {
			bgImgLoader.source = atlas.getTexture("ForHim0000");
		}
		//function button_TriggerHandle2(event: Event): void {
		//	//sources changed
		//	bgImgLoader.source = atlas.getTexture("DarkPink0000");

		//}
		//function button_TriggerHandle3(event: Event): void {
		//	//sources changed
		//	bgImgLoader.source = atlas.getTexture("Aromatic0000");

		//}
		protected function stageResized(event: Event): void {
			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;
			bgImgLoader.width = this.width;
		}

	}

}