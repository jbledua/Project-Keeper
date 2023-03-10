import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Log;

class Keeper extends FlxSprite
{
	private var moveSpeed:Int = 10;
	private var rotateSpeed:Int = 10;
	private var jumpSpeed:Int = -500;
	private var gravity:Int = 800;

	private var maxLeft = 240;
	private var maxRight = 940;

	private var falling:Bool = true;
	private var rotated:Int = 0;

	public function new(_x:Float = 0, _y:Float = 0, _width:Int = 100, _height:Int = 300)
	{
		super(_x - Std.int(_width / 2), _y - Std.int(_height / 2));

		// Replace with Keeper Graphic
		// makeGraphic(_width, _height, FlxColor.BLUE);

		loadGraphic("assets/images/keeper.png", true, 200, 225);
		animation.add("idle", [0]);
		animation.add("idle-catch", [1]);
		animation.add("jump", [2]);
		animation.add("jump-catch", [3]);
		animation.add("block-left", [6]);
		animation.add("dive-right", [7]);
		animation.add("block-right", [4]);
		animation.add("dive-right", [5]);

		animation.play("idle");

		// Set
		this.acceleration.y = gravity;

		this.origin.set(Std.int(_width / 2), _height);
	}

	public function jump()
	{
		if (this.falling)
		{
			Log.trace("Can not Jump");
		}
		else
		{
			this.falling = true;

			animation.play("jump");
			Log.trace("Jumping");
			// this.y = this.y - moveSpeed;
			this.velocity.y = jumpSpeed;
			this.acceleration.y = gravity;
		}
		// this.y = this.y - moveSpeed;
		// this.velocity.y
	}

	public function onGround():Void
	{
		this.falling = false;

		this.velocity.y = 0;
		this.acceleration.y = 0;

		animation.play("idle");
		Log.trace("Landed ");

		if (rotated != 0)
		{
			FlxTween.angle(this, rotated, 0, 1, {type: FlxTweenType.ONESHOT});
			rotated = 0;
		}
	}

	public function moveLeft()
	{
		if (this.x >= maxLeft)
		{
			this.x = this.x - moveSpeed;
			Log.trace("Move Left. At " + x);

			if (this.falling)
			{
				animation.play("block-left");
				// this.rotateLeft();
			}
		}
	}

	public function moveRight()
	{
		if (this.x <= maxRight)
		{
			this.x = this.x + moveSpeed;
			Log.trace("Move Right. At " + x);

			if (this.falling)
			{
				animation.play("block-right");
				// this.rotateRight();
			}
		}
	}

	public function rotateLeft()
	{
		Log.trace("Rotate Left");

		FlxTween.angle(this, 0, -90, 0.3, {type: FlxTweenType.ONESHOT});

		rotated = -90;
	}

	public function rotateRight()
	{
		Log.trace("Rotate Right");

		FlxTween.angle(this, 0, 90, 0.3, {type: FlxTweenType.ONESHOT});

		rotated = 90;
	}
}
