/**
 * Created by alexander on 9/28/14.
 */
package {
import flash.utils.Dictionary;

import screens.GameScreen;

import starling.display.Sprite;
import starling.events.Event;

import screens.GameScreen;

public class World extends Sprite implements IWorld {
    protected var _current:String;
    protected var _previous:String;
    protected var screens:Dictionary;

    public function World() {
        screens = new Dictionary(true);
    }

    public function setScreen(name:String):void {
        var screen:GameScreen;
        if (!_current) {
            _current = name;
            screen = screens[_current];
            screen.addEventListener(Event.ADDED_TO_STAGE,
                    function(event:Event):void {
                        screen.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
                        screen.enter();
                    });
            this.addChild(screen);
            return;
        }
        if (_current == name) {
            trace("this object is already in the " + name + " screen.");
            return;
        }
        if (GameScreen(screens[name]).from.indexOf(_current) != -1) {
            screen = screens[_current];
            screen.addEventListener(Event.REMOVED_FROM_STAGE,
                    function(event:Event):void {
                        screen.removeEventListener(Event.REMOVED_FROM_STAGE, arguments.callee);
                        screen.exit();
                    });
            this.removeChild(screens[_current]);
            _previous = _current;
            _current = name;
            screen = screens[_current];
            screen.addEventListener(Event.ADDED_TO_STAGE,
                    function(event:Event):void {
                        screen.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
                        screen.enter();
                    });
            this.addChild(screen);
        } else {
            trace("screen " + name + " cannot be used while in the " + _current + " state.");
            return;
        }
        GameScreen(screens[_current]).enter();
    }

    public function addScreen(name:String, screen:GameScreen, fromScreens:Vector.<String>):void {
        screen.from = fromScreens;
        screens[name] = screen
    }

    public function update():void {
        var screen:GameScreen = GameScreen(screens[_current]);
        if (screen.stage) screen.update();
    }

    public function removeScreen(name:String):void {
        delete screens[name];
    }

    public function get current():String {
        return _current;
    }

    public function get previous():String {
        return _previous;
    }
}
}
