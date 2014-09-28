/**
 * Created by alexander on 9/28/14.
 */
package {
import screens.GameScreen;

public interface IWorld {
    /**
     * Установить экран как текущий
     * @param name
     */
    function setScreen(name:String):void;

    /**
     * Добавить новый экран в список экранов
     * @param name имя состояния
     * @param state инстанс состояния
     * @param fromStates названия состояний из которых возможен переход к этому состоянию
     */
    function addScreen(name:String, state:GameScreen, fromStates:Vector.<String>):void;

    /**
     * Обновить установленный экран
     */
    function update():void;

    /**
     * Удалить экран из списка
     * @param name
     */
    function removeScreen(name:String):void;

    function get current():String;

    function get previous():String

}
}
