/**
 * Created by alexander on 9/27/14.
 */
package events {
import starling.events.Event;

public class SlingshotEvent extends Event {
    public static const SHOOT:String = "SHOOT";

    public function SlingshotEvent(type:String, data:Object = null) {
        super(type, false, data);
    }
}
}
