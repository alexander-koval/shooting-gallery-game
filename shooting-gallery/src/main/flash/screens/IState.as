/**
 * @author: alexander
 */
package screens {
public interface IState {
    /**
     * Обработчик входа в состояние
     */
    function enter():void;

    /**
     * Обработчик обновления состояния
     */
    function update():void;

    /**
     * Обработчик выхода из состояния
     */
    function exit():void;

    /**
     * Названия состояний из которых можно перейти в текущее
     * @param value
     */
    function set from(value:Vector.<String>):void;
    function get from():Vector.<String>;
}
}
