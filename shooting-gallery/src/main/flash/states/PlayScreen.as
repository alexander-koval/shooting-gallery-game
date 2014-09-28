/**
 * Created by alexander on 9/28/14.
 */
package states {
import dialogs.CompleteDlg;
import dialogs.FailDlg;

import events.GameEvent;

import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class PlayScreen extends GameScreen {
    private var game:Game;
    private var menu:Image;
    private var timer:Timer;
    private var failDlg:FailDlg;
    private var completeDlg:CompleteDlg;
    protected var _fromStates:Vector.<String>;

    public function PlayScreen(context:GameMain) {
        super(context);
        timer = new Timer(Main.config[Main.TIME] * 1000);
        completeDlg = new CompleteDlg();
        failDlg = new FailDlg();
        menu = Resources.getMenu();
        game = new Game();
    }

    override public function enter():void {
        timer.addEventListener(TimerEvent.TIMER, onTimer);
        game.addEventListener(GameEvent.GAME_COMPLETE, onGameComplete);
        menu.scaleX = menu.scaleY = 0.5;
        menu.x = (stage.stageWidth - menu.width);
        menu.y = 10;
        menu.addEventListener(TouchEvent.TOUCH, onTouch);
        addChild(game);
        addChild(menu);
        timer.start();
    }

    private function onGameComplete(event:GameEvent):void {
        timer.stop();
        showCompleteDlg();
    }

    private function onTimer(event:TimerEvent):void {
        timer.stop();
        showFailDlg();
    }

    override public function update():void {
        game.update();
    }

    override public function exit():void {
        removeChild(game);
        game.touchable = true;
        game.removeEventListener(GameEvent.GAME_COMPLETE, onGameComplete);
        timer.removeEventListener(TimerEvent.TIMER, onTimer);
        timer.stop();
        timer.reset();
    }

    override public function set from(value:Vector.<String>):void {
        _fromStates = value;
    }

    override public function get from():Vector.<String> {
        return _fromStates;
    }

    private function showFailDlg():void {
        game.touchable = false;
        failDlg.x = stage.stageWidth / 2;
        failDlg.y = -failDlg.height / 2;
        addChild(failDlg);
        var tween:Tween = new Tween(failDlg, 0.5, Transitions.EASE_OUT_BACK);
        tween.moveTo(stage.stageWidth / 2, stage.stageHeight / 2);
        Starling.juggler.add(tween);
    }

    private function showCompleteDlg():void {
        game.touchable = false;
        completeDlg.x = stage.stageWidth / 2;
        completeDlg.y = -completeDlg.height / 2;
        addChild(completeDlg);
        var tween:Tween = new Tween(completeDlg, 0.5, Transitions.EASE_OUT_BACK);
        tween.moveTo(stage.stageWidth / 2, stage.stageHeight / 2);
        Starling.juggler.add(tween);
    }

    private function onTouch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
        if (touch) {
            context.setScreen(GameScreen.MENU);
        }
    }
}
}
