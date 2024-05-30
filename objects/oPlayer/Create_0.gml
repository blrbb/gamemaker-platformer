/// @description Initialize variables 


//speeds
hsp = 0; // horizontal speed
vsp = 0; // vertical speed
max_hsp = 10; // Max horizontal speed
grav = 0.7; //gravity
max_vsp = 13.5;

//player inputs
key_left = 0;
key_right = 0;
key_jump = 0;
key_jump_held = 0;


//momentum 
accel = 0.8;
decel = 0.6;

// Jumping
onground = false;
groundbuffer = 3; // Lets you jump if you are within 3 px of ground.
jumpspeed = -max_vsp; // A jump height - more negative = higher
jumpbuffer = 10; // Frames after leaving ground that we can still jump.
