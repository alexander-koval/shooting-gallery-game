/**
 * Created by alexander on 9/27/14.
 */
package utils {
import starling.display.Sprite;

public final class SpritePool {
    private var growthValue:uint;
    private var counter:uint;
    private var pool:Vector.<Sprite>;

    public function initialize(clazz:Class, size:uint, growthValue:uint):void {
        this.growthValue = growthValue;
        counter = size;

        var i:int = size;

        pool = new Vector.<Sprite>(size);
        while (--i > -1)
            pool[i] = new clazz();
    }

    public function getSprite():Sprite {
        if (counter > 0)
            return pool[--counter];

        var i:int = growthValue;
        while (--i > -1)
            pool.unshift(new Sprite());
        counter = growthValue;
        return getSprite();

    }

    public function setSprite(sprite:Sprite):void {
        pool[counter++] = sprite;
    }
}
}