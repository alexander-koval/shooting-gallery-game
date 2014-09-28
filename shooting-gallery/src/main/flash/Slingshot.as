/**
 * Created by alexander on 9/25/14.
 */
package {
import flash.geom.Point;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Slingshot extends Sprite {
    private static const CONTROL_POINT_1:Point = new Point(30, 47);
    private static const CONTROL_POINT_2:Point = new Point(170, 60);
    private static const FRICTION:Number = 0.5;
    private static var CONTROL_POINT_3:Point;
    private static var ROPE_SIZE:Point;

    private var rope1:Image;
    private var rope2:Image;
    private var arrow:Image;
    private var holder:Image;
    private var spring:Number = 0.0;
    private var velocity:Point = new Point();
    private var _projectile:Projectile;

    public function Slingshot() {
        var slingshot:Image = Resources.getSlingshot();
        var mask:Image = Resources.getMask();
        rope1 = Resources.getRope();
        rope1.alignPivot();
        rope2 = Resources.getRope();
        rope2.alignPivot();
        arrow = Resources.getArrow();
        arrow.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
        ROPE_SIZE = new Point(rope1.width, rope1.height);
        holder = Resources.getPangci();
        holder.alignPivot();
        mask.x = (slingshot.width - mask.width) / 2;
        mask.y = -15;
        holder.x = slingshot.width / 2 + 3;
        holder.y = 80;
        CONTROL_POINT_3 = new Point(holder.x, holder.y);
        addChild(slingshot);
        addChild(rope1);
        addChild(rope2);
        addChild(mask);
        addChild(holder);
        addChild(arrow);
        arrow.visible = false;
        holder.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    public function update():void {
        var toPoint1:Point = new Point(holder.x - holder.width / 3, holder.y);
        var toPoint2:Point = new Point(holder.x + holder.width / 3, holder.y);
        var distance:Number;
        rope1.x = (toPoint1.x + CONTROL_POINT_1.x) / 2;
        rope1.y = (toPoint1.y + CONTROL_POINT_1.y) / 2;
        rope1.rotation = Math.atan2(toPoint1.y - CONTROL_POINT_1.y, toPoint1.x - CONTROL_POINT_1.x) + Math.PI / 2;
        distance = Math.sqrt((toPoint1.x - CONTROL_POINT_1.x) * (toPoint1.x - CONTROL_POINT_1.x) +
                (toPoint1.y - CONTROL_POINT_1.y) * (toPoint1.y - CONTROL_POINT_1.y));
        distance = distance / ROPE_SIZE.y;
        rope1.scaleY = distance;

        rope2.x = (toPoint2.x + CONTROL_POINT_2.x) / 2;
        rope2.y = (toPoint2.y + CONTROL_POINT_2.y) / 2;
        rope2.rotation = Math.atan2(toPoint2.y - CONTROL_POINT_2.y, toPoint2.x - CONTROL_POINT_2.x) + Math.PI / 2;
        distance = Math.sqrt((toPoint2.x - CONTROL_POINT_2.x) * (toPoint2.x - CONTROL_POINT_2.x) +
                (toPoint2.y - CONTROL_POINT_2.y) * (toPoint2.y - CONTROL_POINT_2.y));
        distance = distance / ROPE_SIZE.y;
        rope2.scaleY = distance;

        if (arrow.visible) {
            arrow.x = (holder.x + CONTROL_POINT_3.x) / 2;
            arrow.y = (holder.y + CONTROL_POINT_3.y) / 2;// - arrow.height / 2;
            distance = Math.sqrt(((holder.x - CONTROL_POINT_3.x)) * (holder.x - CONTROL_POINT_3.x) +
                    (holder.y - CONTROL_POINT_3.y) * (holder.y - CONTROL_POINT_3.y));
            var delta:Point = new Point((holder.x - CONTROL_POINT_3.x), (holder.y - CONTROL_POINT_3.y));
            delta.x /= distance;
            delta.y /= distance;
            arrow.rotation = Math.atan2(delta.y, delta.x) - Math.PI / 2;
        }

        if (_projectile) {
            var position:Point = new Point(holder.x, holder.y - 28);
            var global:Point = localToGlobal(position);
            _projectile.x = global.x;
            _projectile.y = global.y;
        }

        var dx:Number = CONTROL_POINT_3.x - holder.x;
        var dy:Number = CONTROL_POINT_3.y - holder.y;
        var ax:Number = dx * spring;
        var ay:Number = dy * spring;
        velocity.x += ax;
        velocity.y += ay;

        holder.x += velocity.x;
        holder.y += velocity.y;

        velocity.x *= FRICTION;
        velocity.y *= FRICTION;
    }

    private function onTouch(event:TouchEvent):void {
        var touch:Touch;
        var position:Point;
        var distanceX:Number;
        var distanceY:Number;
        touch = event.getTouch(this, TouchPhase.MOVED);
        if (touch) {
            spring = 0.0;
            arrow.visible = true;
            position = touch.getLocation(this);
            holder.x = position.x;
            holder.y = position.y;
            distanceX = holder.x - CONTROL_POINT_3.x;
            distanceY = holder.y - CONTROL_POINT_3.y;
            if (distanceX * distanceX + distanceY * distanceY > 10000) {
                var angle:Number = Math.atan2(distanceY, distanceX);
                holder.x = CONTROL_POINT_3.x + 100 * Math.cos(angle);
                holder.y = CONTROL_POINT_3.y + 100 * Math.sin(angle);
            }
        }
        touch = event.getTouch(this, TouchPhase.ENDED);
        if (touch) {
            if (_projectile) {
                _projectile.play();
                position = touch.getLocation(this);
                holder.x = position.x;
                holder.y = position.y;
                distanceX = holder.x - CONTROL_POINT_3.x;
                distanceY = holder.y - CONTROL_POINT_3.y;
                var deltaX:Number = distanceX / (CONTROL_POINT_3.x + 100);
                var deltaY:Number = distanceY  / (CONTROL_POINT_3.y + 100);
                _projectile.velocity.x = (-Main.BALL_SPEED * deltaX);
                _projectile.velocity.y = (-Main.BALL_SPEED * deltaY);
                dispatchEvent(new SlingshotEvent(SlingshotEvent.SHOOT, _projectile));
            }
            arrow.visible = false;
            _projectile = null;
            spring = 0.9;
        }
    }

    public function get projectile():Projectile {
        return _projectile;
    }

    public function set projectile(value:Projectile):void {
        _projectile = value;
    }
}
}