/**
 * Created by alexander on 9/28/14.
 */
package events {
import starling.events.Event;

public class GameEvent extends Event {
    public static const GAME_COMPLETE:String = "GAME_COMPLETE";

    public function GameEvent(type:String, data:Object = null) {
        super(type, false, data);
    }
}
}
