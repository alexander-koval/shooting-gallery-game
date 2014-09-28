package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.utils.setTimeout;

import starling.core.Starling;

[SWF(width=768, height=1024, frameRate = "60", backgroundColor = "0x000000")]
public class Main extends Sprite {
    public static const STAGE_WIDTH:int = 768;
    public static const STAGE_HEIGHT:int = 1024;
    public static const MONSTER_COUNTS:int = 2;
    public static const BALL_SPEED:int = 50;
    public static const GRAVITY:Number = 0.5;
    public static var FRAME_RATE:int;

    public function Main() {
        if (this.stage) this.init();
        else this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public function init(e:Event = null):void {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        this.removeEventListener(Event.ADDED_TO_STAGE, init);
        FRAME_RATE = stage.frameRate;
        setTimeout(function():void {
            var starling:Starling = new Starling(GameMain, stage, new Rectangle(0, 0, 768, 1024));
            starling.start();
            starling.stage.stageWidth = 768;
            starling.stage.stageHeight = 1024;
            starling.showStats = true;
        }, 0.5);
    }
}
}
