/**
 * Created by alexander on 9/27/14.
 */
package entities {
import flash.geom.Point;

public interface IPhysicalEntity {
    function initialize(onWall:Function = null, onEnemy:Function = null):void;

    function update():void;

    function clear():void;

    function get bounce():int;

    function set bounce(value:int):void;

    function get velocity():Point;

    function set velocity(value:Point):void;

    function get acceleration():Point;

    function set acceleration(value:Point):void;

    function get radius():int;

    function set radius(value:int):void;

    function get mass():int;

    function set mass(value:int):void;

    function get x():Number;

    function set x(value:Number):void;

    function get y():Number;

    function set y(value:Number):void;

    function get isAlive():Boolean;

    function collideWithWall():void;

    function collideWithEnemy(enemy:IPhysicalEntity):void;
}
}
