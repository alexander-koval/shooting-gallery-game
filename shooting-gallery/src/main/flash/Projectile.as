/**
 * Created by alexander on 9/27/14.
 */
package {
import flash.geom.Point;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;

public class Projectile extends Sprite implements IPhysicalEntity {
    private var _bounce:int = -1;
    private var _velocity:Point;
    private var _acceleration:Point;
    private var _radius:int;
    private var _mass:int = 1;
    private var area:Rectangle;
    private var _isAlive:Boolean;
    private var movie:MovieClip;
    private var onWall:Function;
    private var onEnemy:Function;

    public function Projectile() {
        movie = Resources.getSilverNut();
        movie.alignPivot();
        area = new Rectangle(0, 0, Main.STAGE_WIDTH, Main.STAGE_HEIGHT);
        _velocity = new Point();
        _acceleration = new Point();
        addChild(movie);
    }

    public function initialize(onWall:Function = null, onEnemy:Function = null):void {
        _isAlive = true;
        this.onWall = onWall;
        this.onEnemy = onEnemy;
    }

    public function play():void {
        Starling.juggler.add(movie);
        movie.play();
    }

    public function stop():void {
        Starling.juggler.remove(movie);
        movie.stop();
    }

    public function update():void {
        _radius = (this.width * 0.2);
        _velocity.x += _acceleration.x;
        _velocity.y += _acceleration.y;
        x += _velocity.x;
        y += _velocity.y;
    }

    public function get bounce():int {
        return _bounce;
    }

    public function set bounce(value:int):void {
        _bounce = value;
    }

    public function get velocity():Point {
        return _velocity;
    }

    public function set velocity(value:Point):void {
        _velocity = value;
    }

    public function get radius():int {
        return _radius;
    }

    public function set radius(value:int):void {
        _radius = value;
    }

    public function get mass():int {
        return _mass;
    }

    public function set mass(value:int):void {
        _mass = value;
    }

    public function clear():void {
        _isAlive = false;
        _velocity.x = 0;
        _velocity.y = 0;
        _acceleration.x = 0;
        _acceleration.y = 0;
        this.stop();
        onWall = null;
        onEnemy = null;
    }

    public function collideWithWall():void {
        if (_isAlive) {
            if (CollisionUtils.isWallCollision(this, area)) {
                onWall && onWall(this);
                this.clear();
            }
        }
    }

    public function collideWithEnemy(enemy:IPhysicalEntity):void {
        if (enemy is Monster) {
            enemy.collideWithEnemy(this);
            onEnemy && onEnemy(this);
        }
    }

    public function get isAlive():Boolean {
        return _isAlive;
    }

    public function get acceleration():Point {
        return _acceleration;
    }

    public function set acceleration(value:Point):void {
        _acceleration = value;
    }
}
}
