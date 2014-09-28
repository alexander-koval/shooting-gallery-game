/**
 * Created by alexander on 9/26/14.
 */
package {
import starling.display.MovieClip;
import starling.display.Image;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class Resources {
    [Embed(source="../../../assets/Shooter_GameElements.xml", mimeType="application/octet-stream")]
    private static const AtlasXmlClass:Class;

    [Embed(source="../../../assets/Shooter_GameElements.png")]
    private static const AtlasTextureClass:Class;

    private static var texture:Texture = Texture.fromBitmap(new AtlasTextureClass());
    private static var xml:XML = XML(new AtlasXmlClass());
    private static var atlas:TextureAtlas = new TextureAtlas(texture, xml);

    static public function getArrow():Image {
        var texture:Texture = atlas.getTexture("arrow");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getSlingshot():Image {
        var texture:Texture = atlas.getTexture("default_dangong");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getMask():Image {
        var texture:Texture = atlas.getTexture("default_mask");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getRope():Image {
        var texture:Texture = atlas.getTexture("default_rope");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getPangci():Image {
        var texture:Texture = atlas.getTexture("default_pangci");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getMonster():MovieClip {
        var movie:MovieClip = new MovieClip(atlas.getTextures("bianfu1_"), 26);
        return movie;
    }

    static public function getSilverNut():MovieClip {
        var movie:MovieClip = new MovieClip(atlas.getTextures("silvernut_"), 11);
        return movie;
    }

    static public function getBackground():Image {
        var texture:Texture = atlas.getTexture("background");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getPlay():Image {
        var texture:Texture = atlas.getTexture("play");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getMenu():Image {
        var texture:Texture = atlas.getTexture("button_menu");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getMoriBG():Image {
        var texture:Texture = atlas.getTexture("mori_bg");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getFailed():Image {
        var texture:Texture = atlas.getTexture("failed");
        var image:Image = new Image(texture);
        return image;
    }

    static public function getCompleted():Image {
        var texture:Texture = atlas.getTexture("completed");
        var image:Image = new Image(texture);
        return image;
    }
}
}
