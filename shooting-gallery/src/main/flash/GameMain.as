/**
 * Created by alexander on 9/28/14.
 */
package {
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;

import screens.GameScreen;

import screens.MenuScreen;
import screens.PlayScreen;

public class GameMain extends Sprite {
    private var world:World;

    public function GameMain() {
        world = new World();
        world.addScreen(GameScreen.MENU, new MenuScreen(this), Vector.<String>([GameScreen.PLAY]));
        world.addScreen(GameScreen.PLAY, new PlayScreen(this), Vector.<String>([GameScreen.MENU]));
        addEventListener(Event.ADDED_TO_STAGE, initialize);
    }

    private function initialize(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, initialize);
        addChild(world);
        addEventListener(Event.ENTER_FRAME, update);
        this.setScreen(GameScreen.MENU);
    }

    private function update(event:EnterFrameEvent):void {
        world.update();
    }

    public function setScreen(screen:String):void {
        world.setScreen(screen);
    }
}
}
