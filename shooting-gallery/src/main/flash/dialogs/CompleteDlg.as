/**
 * Created by alexander on 9/28/14.
 */
package dialogs {
import starling.display.Image;
import starling.display.Sprite;

public class CompleteDlg extends Sprite {
    private var background:Image;
    private var completed:Image;

    public function CompleteDlg() {
        super();
        background = Resources.getMoriBG();
        background.alignPivot();
        completed = Resources.getCompleted();
        completed.alignPivot();
        completed.scaleX = completed.scaleY = 0.8;
        addChild(background);
        addChild(completed);

    }
}
}
