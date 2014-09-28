/**
 * Created by alexander on 9/28/14.
 */
package dialogs {
import starling.display.Image;
import starling.display.Sprite;

public class FailDlg extends Sprite {
    private var background:Image;
    private var failed:Image;

    public function FailDlg() {
        super();
        background = Resources.getMoriBG();
        background.alignPivot();
        failed = Resources.getFailed();
        failed.alignPivot();
        addChild(background);
        addChild(failed);
    }
}
}
