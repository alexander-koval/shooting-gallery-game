package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Rectangle;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

import starling.core.Starling;

[SWF(width=768, height=1024, frameRate = "60", backgroundColor = "0x000000")]
public class Main extends Sprite {
    public static var config:Dictionary = new Dictionary();
    public static const MONSTERS:String = "CountTarget";
    public static const SPEED:String = "Speed";
    public static const TIME:String = "Time";
    public static const STAGE_WIDTH:int = 768;
    public static const STAGE_HEIGHT:int = 1024;
    public static const GRAVITY:Number = 0.5;
    public static var FRAME_RATE:int;

    private static var MONSTER_COUNTS:int = 10;
    private static var BALL_SPEED:int = 50;
    private static var GAME_TIME:int = 30;

    public function Main() {
        if (this.stage) this.init();
        else this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public function init(e:Event = null):void {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        this.removeEventListener(Event.ADDED_TO_STAGE, init);
        FRAME_RATE = stage.frameRate;
        //TODO: akoval Fix for Flash Player on Linux
        setTimeout(function():void {
            var starling:Starling = new Starling(GameMain, stage, new Rectangle(0, 0, 768, 1024));
            starling.start();
            starling.stage.stageWidth = 768;
            starling.stage.stageHeight = 1024;
        }, 0.5);
        var loader:URLLoader = new URLLoader();
        loader.dataFormat = URLLoaderDataFormat.TEXT;
        loader.addEventListener(Event.COMPLETE, onLoadingComplete);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        loader.load(new URLRequest("config"));

        function onLoadingComplete(e:Event):void {
            var str:String = loader.data as String;
            var array:Array = str.split("\n");
            for (var index:int = 0; index < array.length; index++) {
                array[index] = array[index].split('=');
                config[array[index][0]] = int(array[index][1]);
            }
        }

        function onIOError(event:ErrorEvent):void {
            config[MONSTERS] = MONSTER_COUNTS;
            config[SPEED] = BALL_SPEED;
            config[TIME] = GAME_TIME;
        }
    }
}
}
