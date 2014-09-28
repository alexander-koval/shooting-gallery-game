package entities {

import flash.geom.Rectangle;
import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import flash.geom.Point;

import utils.CollisionUtils;

public class Monster extends Sprite implements IPhysicalEntity {
    private var _bounce:int = -1;
    private var _velocity:Point;
    private var _acceleration:Point;
    private var _radius:int;
    private var _mass:int;
    private var area1:Rectangle;
    private var area2:Rectangle;
    private var movie:MovieClip;
    private var onWall:Function;
    private var onEnemy:Function;
    private var _isAlive:Boolean;
    private var _isDieing:Boolean;
    private var _wanderAngle:Number = 0;
    private var _steeringForce:Point;
    private var maxSpeed:Number = 3;
    private var _wanderDistance:Number = 1;
    private var _wanderRadius:Number = .5;
    private var _wanderRange:Number = 1;

    public function Monster() {
        movie = Resources.getMonster();
        movie.alignPivot();
        area1 = new Rectangle(0, 0, Main.STAGE_WIDTH, Main.STAGE_WIDTH);
        area2 = new Rectangle(0, 0, Main.STAGE_WIDTH, Main.STAGE_HEIGHT);
        addChild(movie);
    }

    public function initialize(onWall:Function = null, onEnemy:Function = null):void {
        _isAlive = true;
        _isDieing = false;
        _acceleration = new Point();
//        _velocity = new Point((Math.random() * 3) + 2, (Math.random() * 3) + 2);
        _velocity = new Point();
        _steeringForce = new Point();
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
        if (!_isDieing) {
            wander();
            _velocity = _velocity.add(_steeringForce);
            _steeringForce = new Point();
            _velocity.x += _acceleration.x;
            _velocity.y += _acceleration.y;
            _velocity.normalize(maxSpeed);
        } else {
            _velocity.x += _acceleration.x;
            _velocity.y += _acceleration.y;
        }
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

    public function get acceleration():Point {
        return _acceleration;
    }

    public function set acceleration(value:Point):void {
        _acceleration = value;
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

    public function get isAlive():Boolean {
        return _isAlive;
    }


    public function get isDieing():Boolean {
        return _isDieing;
    }

    public function collideWithWall():void {
        if (_isDieing) {
            if (CollisionUtils.onWallCollision(this, area2)) {
                _isAlive = false;
                onWall && onWall(this);
                this.clear();
            }
        } else {
            if (CollisionUtils.onWallCollision(this, area1)) {
                onWall && onWall(this);
            }
        }
    }

    public function collideWithEnemy(enemy:IPhysicalEntity):void {
        if (!_isDieing) {
            if (CollisionUtils.onCircleCollision(this, enemy)) {
                onEnemy && onEnemy(this);
                if (enemy is Projectile) {
                    _isDieing = true;
                    _acceleration.y = Main.GRAVITY;
                }
            }
        }
    }

    public function wander():void {
        var velClone:Point = _velocity.clone();
        velClone.x /= velClone.length || 1;
        velClone.y /= velClone.length || 1;
        var center:Point = new Point(velClone.x * _wanderDistance, velClone.y * _wanderDistance);
        var offset:Point = new Point(0, 1);
        offset.x *= _wanderRadius;
        offset.y *= _wanderRadius;
        var len :Number = offset.length;
        offset.x = Math.cos(_wanderAngle) * len;
        offset.y = Math.sin(_wanderAngle) * len;
        _wanderAngle += Math.random() * _wanderRange - _wanderRange * .5;
        var force:Point = center.add(offset);
        _steeringForce = _steeringForce.add(force);
    }
}
}