// Basic player
package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Player extends FlxSprite {

		var currentState: PlayState;
	
	public function new(startX:Float, startY:Float):Void {
		super(startX, startY);
		loadGraphic("assets/ships.png",true,false,32,32);
		addAnimation("idle",[0]);
		addAnimation("left",[1]);
		addAnimation("right",[2]);

		currentState = cast(FlxG.state, PlayState);
	}

	override public function update():Void {
		super.update();
		currentState.lThruster.x = x;
		currentState.lThruster.y = y + height;

		currentState.rThruster.x = x + 20;
		currentState.rThruster.y = y + height;

		velocity.x = 0;

		if (FlxG.keys.LEFT == true){
			play("left");
			currentState.rThruster.play("fire");
			currentState.lThruster.play("idle");
			velocity.x = -300;
		}
		else if (FlxG.keys.RIGHT == true){
			play("right");
			currentState.rThruster.play("idle");
			currentState.lThruster.play("fire");
			velocity.x = 300;
		}
		else{
			play("idle");
			currentState.rThruster.play("idle");
			currentState.lThruster.play("idle");
		}



		if(FlxG.keys.justPressed("SPACE") == true){
			FlxG.play("Shoot");
			cast(FlxG.state, PlayState).bullets.add(new Bullet(x+10, y-25));
		}

		if (x < 0){
			x = 0;
		}
		if (x > FlxG.width-width){
			x = FlxG.width-width;
		}
	}
}