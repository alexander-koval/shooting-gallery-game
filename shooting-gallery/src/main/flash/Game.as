package {
import events.GameEvent;
import events.SlingshotEvent;

import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.display.Image;
import starling.events.Event;
import starling.display.Sprite;

import starlingBox.game.pooling.LinkedList;
import starlingBox.game.pooling.LinkedListNode;

public class Game extends Sprite {
    private static var MonsterNum:int;
    private static const Min:Number = 0.8;
    private static const Max:Number = 1.0;
    private var timer:Timer;
    private var pool1:SpritePool;
    private var pool2:SpritePool;
    private var physics:LinkedList;
    private var slingshot:Slingshot;
    private var background:Image;
    private var killed:int;

    public function Game() {
        timer = new Timer(500);
        pool1 = new SpritePool();
        pool1.initialize(Projectile, 4, 0);
        pool2 = new SpritePool();
        MonsterNum = Main.config[Main.MONSTERS];
        pool2.initialize(Monster, MonsterNum, 0);
        physics = new LinkedList(MonsterNum + 4);
        slingshot = new Slingshot();
        slingshot.x = (Main.STAGE_WIDTH - slingshot.width) / 2;
        slingshot.y = Main.STAGE_HEIGHT - slingshot.height / 2;
        background = Resources.getBackground();
        this.addEventListener(Event.ADDED_TO_STAGE, initialize);
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }

    public function initialize(event:Event):void {
        timer.addEventListener(TimerEvent.TIMER, onMonsterAdd);
        slingshot.addEventListener(SlingshotEvent.SHOOT, onShoot);
        background.scaleX = background.scaleY = 1.0;
        background.scaleX = background.scaleY = stage.stageWidth / background.width;
        addChildAt(background, 0);
        addChildAt(slingshot, 1);
        onSlingshotCharge();
        timer.start();
    }

    private function destroy(event:Event):void {
        killed = 0;
        timer.removeEventListener(TimerEvent.TIMER, onMonsterAdd);
        timer.removeEventListener(TimerEvent.TIMER, onSlingshotCharge);
        slingshot.removeEventListeners(SlingshotEvent.SHOOT);
        var item:LinkedListNode;
        var next:LinkedListNode;
        item = physics.head;
        while (item && item.data) {
            var entity:IPhysicalEntity = IPhysicalEntity(item.data);
            var sprite:Sprite = Sprite(entity);
            removeChild(sprite);
            entity.clear();
            if (entity is Monster) {
                pool2.setSprite(entity as Monster);
            } else if (entity is Projectile) {
                pool1.setSprite(entity as Projectile);
            }
            next = item.next;
            physics.removeNode(item);
            item = next;
        }
        removeChild(slingshot);
        removeChild(background);
        timer.stop();
        timer.reset();
    }

    private function onMonsterAdd(event:TimerEvent):void {
        var monster:Monster = Monster(pool2.getSprite());
        monster.scaleX = monster.scaleY = Utils.randomRange(Min, Max);
        monster.alignPivot();
        monster.x = Utils.randomRange(40, stage.stageWidth - monster.width);
        monster.y = 40;
        monster.mass = (monster.scaleX * 10);
        monster.initialize(
                function(monster:Monster):void {
                    if (!monster.isAlive) {
                        killed += 1;
                        pool2.setSprite(monster);
                        if (killed >= MonsterNum) {
                            dispatchEvent(new GameEvent(GameEvent.GAME_COMPLETE));
                        }
                    }
                });
        physics.append(monster);
        if (timer.currentCount == MonsterNum) {
            timer.removeEventListener(TimerEvent.TIMER, onMonsterAdd);
        }
        addChildAt(monster, 1);
        monster.play();
    }

    private function onShoot(event:SlingshotEvent):void {
        timer.addEventListener(TimerEvent.TIMER, onSlingshotCharge);
        var projectile:Projectile = Projectile(event.data);
        projectile.acceleration.y = Main.GRAVITY;
        physics.append(projectile);
    }

    private function onSlingshotCharge(event:TimerEvent = null):void {
        timer.removeEventListener(TimerEvent.TIMER, onSlingshotCharge);
        if (!slingshot.projectile) {
            var projectile:Projectile = Projectile(pool1.getSprite());
            projectile.initialize(
                    function(projectile:Projectile):void {
                        pool1.setSprite(projectile);
                    });
            slingshot.projectile = projectile;
            addChild(projectile);
        }
    }

    public function update():void {
        var item:LinkedListNode;
        item = physics.head;
        while (item && item.data) {
            var monsterA:IPhysicalEntity = IPhysicalEntity(item.data);
            if (!monsterA.isAlive) {
                var next:LinkedListNode = item.next;
                removeChild(monsterA as Sprite);
                physics.removeNode(item);
                item = next;
                continue;
            }
            monsterA.collideWithWall();
            var item2:LinkedListNode = item.next;
            while (item2 && item2.data) {
                var monsterB:IPhysicalEntity = IPhysicalEntity(item2.data);
                monsterA.collideWithEnemy(monsterB);
                item2 = item2.next;
            }
            monsterA.update();
            item = item.next;
        }
        slingshot.update();
    }
}
}