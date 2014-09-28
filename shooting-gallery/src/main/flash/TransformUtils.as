/**
 * Created by alexander on 9/25/14.
 */
package {
import flash.display.DisplayObject;
import flash.filters.DisplacementMapFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class TransformUtils {
    static public function rotate(object:DisplayObject, parent:DisplayObject, angle:int):void {
        var matrix:Matrix = object.transform.matrix;
        var rect:Rectangle = object.getBounds(parent);
        matrix.translate(-(rect.left + (rect.width / 2)), -(rect.top + (rect.height / 2)));
        matrix.rotate((angle / 180) * Math.PI);
        matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
        object.transform.matrix = matrix;
    }

    static public function translate(object:DisplayObject, parent:DisplayObject, position:Point):void {
        var matrix:Matrix = object.transform.matrix;
        var rect:Rectangle = object.getBounds(parent);
        matrix.translate(-(rect.left + (rect.width / 2)), -(rect.top + (rect.height / 2)));
        matrix.translate(position.x, position.y);
        matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
        object.transform.matrix = matrix;
    }

    static public function scale(object:DisplayObject, parent:DisplayObject, scaleX:Number, scaleY:Number):void {
        var matrix:Matrix = object.transform.matrix;
        var rect:Rectangle = object.getBounds(parent);
        matrix.translate(-(rect.left + (rect.width / 2)), -(rect.top + (rect.height / 2)));
        matrix.scale(scaleX, scaleY);
        matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
        object.transform.matrix = matrix;
    }
}
}
