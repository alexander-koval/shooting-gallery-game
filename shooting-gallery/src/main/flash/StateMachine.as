/**
 * @author: alexander
 */
package {
import flash.utils.Dictionary;

import states.IState;

public class StateMachine implements IStateMachine {
    protected var _current:String;
    protected var _previous:String;
    protected var states:Dictionary;

    public function StateMachine() {
        states = new Dictionary(true);
    }

    /**@inheritDoc*/
    public function setState(name:String):void {
        if (!_current) {
            _current = name;
            IState(states[_current]).enter();
            return;
        }
        if (_current == name) {
            trace("this object is already in the " + name + " state.");
            return;
        }
        if (IState(states[name]).from.indexOf(_current) != -1) {
            IState(states[_current]).exit();
            _previous = _current;
            _current = name;
        } else {
            trace("state " + name + " cannot be used while in the " + _current + " state.");
            return;
        }
        states[_current].enter();
    }

    /**@inheritDoc*/
    public function addState(name:String, state:IState, fromStates:Vector.<String>):void {
        state.from = fromStates;
        states[name] = state;
    }

    /**@inheritDoc*/
    public function removeState(name:String):void {
        delete states[name];
    }

    /**@inheritDoc*/
    public function update():void {
        IState(states[_current]).update();
    }

    /**@inheritDoc*/
    public function get current():String {
        return _current;
    }

    /**@inheritDoc*/
    public function get previous():String {
        return _previous;
    }
}
}
