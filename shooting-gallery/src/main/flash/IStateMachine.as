/**
 * @author: alexander
 */
package {

import states.IState;

/**
 * Машина состояний игры
 */
public interface IStateMachine {
    /**
     * Установить состояние как текущее
     * @param name
     */
    function setState(name:String):void;

    /**
     * Добавить новое состояние в список состояний
     * @param name имя состояния
     * @param state инстанс состояния
     * @param fromStates названия состояний из которых возможен переход к этому состоянию
     */
    function addState(name:String, state:IState, fromStates:Vector.<String>):void;

    /**
     * Обновить установленное состояние
     */
    function update():void;

    /**
     * Удалить состояние из списка
     * @param name
     */
    function removeState(name:String):void;

    function get current():String;

    function get previous():String
}
}
