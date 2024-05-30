/// @description 
// get inputs
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_jump = keyboard_check_pressed(vk_space);
key_jump_held = keyboard_check(vk_space)

// Calculate horizontal movement

// get move directions (-1 left, 1 right, 0 nothing)
var dir = key_right - key_left;

//get horizontal speed (negative hsp = left, positive = right)
hsp += dir * accel;

// Slow down if no direction
if (dir == 0) 
{
	
	if (hsp < 0) //going left
	{ 
		hsp = min(hsp + decel, 0);
	}
	
	else //going right
	{
		hsp = max(hsp-decel,0);
	}
}

// Set max speed
hsp = clamp(hsp,-max_hsp,max_hsp);

//Calculate vertical movement

vsp += grav;

// Ground jump
if (jumpbuffer > 0) 
{
	jumpbuffer--; 
	if (key_jump)
	{
		jumpbuffer = 0;
		vsp = jumpspeed; // Jump up!
	}
}

if (vsp < 0 && !key_jump_held) // If going up & not holding jump key
{
	vsp = max(vsp,-3)
}

vsp = clamp(vsp, -max_vsp, max_vsp);

// Horizontal collision
if (place_meeting(x+hsp,y,oBlock))
{
	var onePixel = sign(hsp);
	while (!place_meeting(x+onePixel,y,oBlock)) x+= onePixel;
	hsp=0;
}

x += hsp;

// Vertical collision
if (place_meeting(x,y+vsp,oBlock))
{
	var onePixel = sign(vsp);
	while (!place_meeting(x,y+onePixel,oBlock)) y+= onePixel;
	vsp = 0;
}

y += vsp;

// Calculate current status
onground = place_meeting(x,y+groundbuffer,oBlock);
if(onground) jumpbuffer = 10;

// Adjust sprite
image_speed = 1; // 100% of animation speed
	// If moving, orient sprite according to direction fo movement
if (hsp != 0) image_xscale = sign(hsp);
if (!onground)
{
	sprite_index = sPlayerAir;
	image_speed = 0; //stop animation
	image_index = (vsp > 0); //falling = 1, else = 0
}
else
{
	if (hsp != 0) {
		sprite_index = sPlayerRun;
	}
	else
	{
		sprite_index = sPlayer;
	}
}

// Quick restart game
if(keyboard_check_pressed(vk_enter)){
	game_restart();	
}