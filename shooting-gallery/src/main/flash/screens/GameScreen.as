/**
 * Created by alexander on 9/28/14.
 */
package screens {
import starling.display.Sprite;

public class GameScreen extends Sprite implements IState {
    public static const MENU:String = "MENU";
    public static const PLAY:String = "PLAY";

    protected var context:GameMain;

    public function GameScreen(context:GameMain) {
        this.context = context;
    }

    public function enter():void {
    }

    public function update():void {
    }

    public function exit():void {
    }

    public function set from(value:Vector.<String>):void {
    }

    public function get from():Vector.<String> {
        return null;
    }
}
}
