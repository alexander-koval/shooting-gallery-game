/**
 * Created by alexander on 9/25/14.
 */
package utils {
import entities.IPhysicalEntity;

import flash.geom.Point;
import flash.geom.Rectangle;

import starling.core.Starling;

public class CollisionUtils {

    static public function isCircleCollision(entity0:IPhysicalEntity, entity1:IPhysicalEntity):Boolean {
        var dx:Number = entity1.x - entity0.x;
        var dy:Number = entity1.y - entity0.y;
        var dist:Number = Math.sqrt(dx * dx + dy * dy);
        return (dist < entity0.radius + entity1.radius);
    }

    static public function isWallCollision(monster:IPhysicalEntity, area:Rectangle):Boolean {
        return  (monster.x + monster.radius > area.width) ||
                (monster.x - monster.radius < area.left) ||
                (monster.y + monster.radius > area.height) ||
                (monster.y - monster.radius < area.top);
    }

    static public function onWallCollision(entity:IPhysicalEntity, area:Rectangle):Boolean {
        var result:Boolean = false;
        if (entity.x + entity.radius > area.width) {
            entity.x = area.width - entity.radius;
            entity.velocity.x *= entity.bounce;
            result = true;
        }
        else if (entity.x - entity.radius < area.left) {
            entity.x = entity.radius;
            entity.velocity.x *= entity.bounce;
            result = true;
        }
        if (entity.y + entity.radius > area.height) {
            entity.y = area.height - entity.radius;
            entity.velocity.y *= entity.bounce;
            result = true;
        }
        else if (entity.y - entity.radius < area.top) {
            entity.y = entity.radius;
            entity.velocity.y *= entity.bounce;
            result = true;
        }
        return result;
    }

    static public function onCircleCollision(entity0:IPhysicalEntity, entity1:IPhysicalEntity):Boolean {
        var dx:Number = entity1.x - entity0.x;
        var dy:Number = entity1.y - entity0.y;
        var dist:Number = Math.sqrt(dx*dx + dy*dy);
        if (dist < entity0.radius + entity1.radius) {
            var angle:Number = Math.atan2(dy, dx);
            var sin:Number = Math.sin(angle);
            var cos:Number = Math.cos(angle);

            var pos0:Point = new Point(0, 0);

            var pos1:Point = rotate(dx, dy, sin, cos, true);

            var vel0:Point = rotate(entity0.velocity.x, entity0.velocity.y, sin, cos, true);

            var vel1:Point = rotate(entity1.velocity.x, entity1.velocity.y, sin, cos, true);

            var vxTotal:Number = vel0.x - vel1.x;
            vel0.x = ((entity0.mass - entity1.mass) * vel0.x + 2 * entity1.mass * vel1.x) / ((entity0.mass + entity1.mass));
            vel1.x = vxTotal + vel0.x;

            var absV:Number = Math.abs(vel0.x) + Math.abs(vel1.x);
            var overlap:Number = (entity0.radius + entity1.radius) - Math.abs(pos0.x - pos1.x);
            pos0.x += vel0.x / absV * overlap;
            pos1.x += vel1.x / absV * overlap;

            var pos0F:Object = rotate(pos0.x, pos0.y, sin, cos, false);

            var pos1F:Object = rotate(pos1.x, pos1.y, sin, cos, false);

            entity1.x = entity0.x + pos1F.x;
            entity1.y = entity0.y + pos1F.y;
            entity0.x = entity0.x + pos0F.x;
            entity0.y = entity0.y + pos0F.y;

            var vel0F:Point = rotate(vel0.x, vel0.y, sin, cos, false);
            var vel1F:Point = rotate(vel1.x, vel1.y, sin, cos, false);
            entity0.velocity.x = vel0F.x;
            entity0.velocity.y = vel0F.y;
            entity1.velocity.x = vel1F.x ;
            entity1.velocity.y = vel1F.y ;
            return true;
        }
        return false;
    }

    static public function rotate(x:Number, y:Number, sin:Number, cos:Number, reverse:Boolean):Point {
        var result:Point = new Point();
        if (reverse) {
            result.x = x * cos + y * sin;
            result.y = y * cos - x * sin;
        } else {
            result.x = x * cos - y * sin;
            result.y = y * cos + x * sin;
        }
        return result;
    }

}
}
