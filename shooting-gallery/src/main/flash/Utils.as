/**
 * Created by alexander on 9/28/14.
 */
package {
public class Utils {
    public static function randomRange(min:Number = 0.0, max:Number = 1.0):Number {
        return min + (max - min) * Math.random();
    }
}
}
