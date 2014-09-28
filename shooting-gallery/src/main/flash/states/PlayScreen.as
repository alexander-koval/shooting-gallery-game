/**
 * Created by alexander on 9/28/14.
 */
package states {
import starling.display.Image;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class PlayScreen extends GameScreen {
    private var game:Game;
    private var menu:Image;
    protected var _fromStates:Vector.<String>;

    public function PlayScreen(context:GameMain) {
        super(context);
        menu = Resources.getMenu();
        game = new Game();
    }

    override public function enter():void {
        addChild(game);
        menu.scaleX = menu.scaleY = 0.5;
        menu.x = (stage.stageWidth - menu.width);
        menu.y = 10;//(stage.stageHeight - menu.height);
        menu.addEventListener(TouchEvent.TOUCH, onTouch);
        addChild(menu);
    }

    override public function update():void {
        game.update();
    }

    override public function exit():void {
        removeChild(game);
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
            context.setScreen(GameScreen.MENU);
        }
    }
}
}
