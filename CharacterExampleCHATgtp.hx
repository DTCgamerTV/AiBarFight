import flixel.FlxSprite;

class Character extends FlxSprite {
  // Character properties
  public var name:String;
  public var maxHealth:Int;
  public var currentHealth:Int;
  public var attackPower:Int;
  public var defense:Int;
  public var speed:Int;
  public var jumpHeight:Int;
  public var isJumping:Bool;

  // Animation properties
  public var walkAnim:FlxAnimation;
  public var jumpAnim:FlxAnimation;
  public var attackAnim:FlxAnimation;
  public var hurtAnim:FlxAnimation;
  public var idleAnim:FlxAnimation;

  // Constructor function
  public function new(name:String, maxHealth:Int, attackPower:Int, defense:Int, speed:Int, jumpHeight:Int) {
    super();
    this.name = name;
    this.maxHealth = maxHealth;
    this.currentHealth = maxHealth;
    this.attackPower = attackPower;
    this.defense = defense;
    this.speed = speed;
    this.jumpHeight = jumpHeight;
    isJumping = false;

    // Load and set up character animations
    walkAnim = new FlxAnimation();
    walkAnim.add("assets/character_walk.png");
    walkAnim.add("assets/character_walk2.png");
    walkAnim.add("assets/character_walk3.png");
    walkAnim.delay = 0.1;
    addAnimation("walk", walkAnim);

    jumpAnim = new FlxAnimation();
    jumpAnim.add("assets/character_jump.png");
    addAnimation("jump", jumpAnim);

    attackAnim = new FlxAnimation();
    attackAnim.add("assets/character_attack.png");
    attackAnim.add("assets/character_attack2.png");
    attackAnim.delay = 0.1;
    addAnimation("attack", attackAnim);

    hurtAnim = new FlxAnimation();
    hurtAnim.add("assets/character_hurt.png");
    addAnimation("hurt", hurtAnim);

    idleAnim = new FlxAnimation();
    idleAnim.add("assets/character_idle.png");
    addAnimation("idle", idleAnim);
  }

  // Character behavior functions
  public function jump():Void {
    if (!isJumping) {
      velocity.y = -jumpHeight;
      isJumping = true;
      play("jump");
    }
  }

  public function attack():Void {
    play("attack");
  }

  public function takeDamage(damage:Int):Void {
    currentHealth -= damage;
    play("hurt");
  }

  public function heal(amount:Int):Void {
    currentHealth += amount;
    if (currentHealth > maxHealth) currentHealth = maxHealth;
  }

  public function isDead():Bool {
    return currentHealth <= 0;
  }

  // Update function
  override public function update():Void {
    super.update();

  // Update function (continued)
  override public function update():Void {
    super.update();

    // Check if character is on the ground
    isJumping = (touching & DOWN) == 0;

    // Update character's velocity based on player input
    if (FlxG.keys.LEFT) {
      velocity.x = -speed;
      facing = LEFT;
      play("walk");
    } else if (FlxG.keys.RIGHT) {
      velocity.x = speed;
      facing = RIGHT;
      play("walk");
    } else {
      velocity.x = 0;
      play("idle");
    }

    // Update character's position based on velocity
    x += velocity.x * FlxG.elapsed;
    y += velocity.y * FlxG.elapsed;
  }
}
