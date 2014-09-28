/**
 * Created by alexander on 9/28/14.
 */
package states {
import starling.display.Image;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MenuScreen extends GameScreen {
    private var play:Image;
    private var background:Image;
    protected var _fromStates:Vector.<String>;

    public function MenuScreen(context:GameMain) {
        super(context);
        play = Resources.getPlay();
        background = Resources.getBackground();
    }

    override public function enter():void {
        background.scaleX = background.scaleY = stage.stageWidth / background.width;
        addChild(background);
        play.x = (stage.stageWidth - play.width) / 2;
        play.y = (stage.stageHeight - play.height) / 2;
        play.addEventListener(TouchEvent.TOUCH, onTouch);
        addChild(play);
    }

    override public function exit():void {
        removeChild(background);
    }

    override public function set from(value:Vector.<String>):void {
        _fromStates = value;
    }

    override public function get from():Vector.<String> {
        return _fromStates;
    }

    private function onTouch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
        if (touch) {
            context.setScreen(GameScreen.PLAY);
        }
    }
}
}
