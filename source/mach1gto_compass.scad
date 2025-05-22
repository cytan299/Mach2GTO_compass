/*
  
    mach1gto_compass.scad is the code to generate a tray for an iPhone
    or map compass
    
    Copyright (C) 2025  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the Mach1gto compass tray distribution.

    mach1gto_compass.scad is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    mach1gto_compass.scad is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with mach1gto_compass.scad.  If not, see
    <http://www.gnu.org/licenses/>.

*/

$fn=100;

// Choose what you want to print by setting it to 1

MAKE_ATTACHMENT = 0;  
MAKE_COMPASS_TRAY = 0;
MAKE_IPHONE_TRAY = 1;


// parameters

/*
  This is the definition of an iPhone SE *including* its case.
  Users can change these numbers to match their phone.
*/

iphone_l = 140.5; // mm, length of the iPhone includes case. See photo.
iphone_w = 71; // mm, width of the iPhone includes case. See photo.
iphone_H = 10; // mm  height of the iPhone
iphone_button_l = 13; //mm, length of the iPhone button indent. See photo.
iphone_onoff_x = 29; // mm, from reference position. See photo.
iphone_vol_x = 29; // mm, from reference position. See photo.
iphone_vol_l = 26; //mm length of the iPhone volume buttons. See photo


/*
  For heavier phones, the gusset length can be increased
*/

gusset_l = 0; //mm


// Do not change the following parameters

base_t = 5; // mm, base thickness

// rectangular part of the base
base_rect_x = 105.4; //mm
base_rect_y0 = 35.35; // mm, left top edge
base_rect_y1 = 37.8382; // mm, right top edge

// dy translation so that the nothing actually hits the base of the Mach1 mount
dyR = 5.5515; //mm

// slot
slot_r = 16.5; //mm

// bracket
bracket_space = 9.25;//mm spacing
bracket_t = 3; //mm thickness of bracket wall

// screw holes
screw_r = 1; // mm

// curved wall
curved_wall_x0 = 2.9004;
curved_wall_y0 = 89.8863;
curved_wall_inner_r = 90; //mm
curved_wall_outer_r = 93; //mm
curved_wall_h = 10; //mm

// back wall
back_wall_l = 69.8927; //mm
back_wall_h = 29.8;
back_wall_t = base_t;
back_wall_curve_r = 7;


// compass tray length
compass_tray_l = base_rect_x + 8.5; //mm, length of the compass tray

module make_base()
{
  union(){

    //  the polygon shape of the base that does not have angled walls
    //  or slots yet or wings
    translate([-base_rect_x/2,-dyR,0]){
      linear_extrude(height=base_t, v=[0,0,1], center=false){

	polygon(points=[[0,0.00],[105.4, 0],[105.4, 40.9015],
			[80.8176,41.4818],[80.8176,53.9502],
			[10.9250,53.9502], [10.9250, 43.1318],
			[0,43.3897],[0,0]]);

	
      } // linear_extrude
    } // translate   



  }// union
}

module make_back_wall()
{
  translate([-41.7750 ,  48.3987, base_t]){
    rotate([90, 0, 0]){
      union(){
	difference(){

	  linear_extrude(height=back_wall_t, v=[0,0,1], center=false){

	    polygon(points=[[0,0.00],[back_wall_l, 0],[69.4166, back_wall_h],
			    [3.5817,back_wall_h],[0,0]]);

	
	  } // linear_extrude	  

	  block_l = 14.5903;
          //remove the top edges for rounding
	  union(){
            //left top edge
	    translate([0, 19.1, -2*back_wall_t]){
	      cube([block_l, 2*block_l, 4*back_wall_t], center = false);
	    }

	    block_r = 12.6;
            // right top edge
	    translate([57.2927, 19.1, -2*back_wall_t]){
	      cube([block_r, 2*block_r, 4*back_wall_t], center = false);
	    }

	    } // union


	} // difference

        // add in the rounded edges which are ellipses
	// create ellipses by changing scale

        // top left rounded edge

	lc_r = 12.2946;
	translate([14.5903, 19.1, back_wall_t/2]){
	  scale([1,10.7/lc_r, 1]){
	    cylinder(r=lc_r, h=back_wall_t, center=true);
	  }
	}

	//top right rounded edge
	rc_r = 12.2949;
	translate([57.2927, 19.1, back_wall_t/2]){
	  scale([1, 10.7/rc_r, 1]){
	    cylinder(r=rc_r, h=back_wall_t, center=true);
	  }
	}

      } // union
    } // rotate
  } // translate
}

module make_slot()
{
  // coordinate of the circular slot  
  x0 = -0.08; 
  y0=19.24; 

  union(){

    // round hole
    translate([x0,y0, 0]){
      cylinder(r=slot_r, h = 4*base_t, center=true );
    }

    // the straight edges

    translate([x0,2*slot_r+y0, 0]){
      cube([2*slot_r, 4*slot_r, 8*base_t], center=true);
    }
    
  }
}

module make_curved_wall()
{
  difference(){
    translate([curved_wall_x0, curved_wall_y0, -curved_wall_h/2]){
      difference(){
	cylinder(r=curved_wall_outer_r, h = curved_wall_h, center = true);
	// remove in inside of the cylinder
	cylinder(r=curved_wall_inner_r, h = 4*curved_wall_h, center = true);
      }

    } // translate

    // remove stuff outside the base
    // outside right wall
    translate([2*curved_wall_outer_r + base_rect_x/2, 2*curved_wall_outer_r, 0]){
      cube([4*curved_wall_outer_r, 4*curved_wall_outer_r, 4*curved_wall_h], center=true);
    }
    // outside left wall
    translate([-2*curved_wall_outer_r - base_rect_x/2, 2*curved_wall_outer_r, 0]){
      cube([4*curved_wall_outer_r, 4*curved_wall_outer_r, 4*curved_wall_h], center=true);
    }

    // left over curved wall
    translate([0,3*curved_wall_outer_r,0]){
      cube([4*curved_wall_outer_r, 4*curved_wall_outer_r, 4*curved_wall_h], center=true);
    }

    // remove stuff to not block the dovetail

    dovetail_w = 42.5640+2; //mm
    wall_t = curved_wall_outer_r - curved_wall_inner_r;

    translate([-27.1174,-dyR,-2*curved_wall_h]){
      cube([dovetail_w, 4*wall_t, 4*curved_wall_h], center=false);
    }
    
  } //union
    

}

module make_brackets()
{

  // left bracket spacer
  translate([-24.1174, -dyR, -bracket_space]){
    union(){
      // space part
      linear_extrude(height=bracket_space, v=[0,0,1], center=false){
	polygon(points=[[0,0],
			[-28.5826, 0], [-28.5826,9.9321],
			[-25.5826, 9.9321],[-25.5826,3],
			[-3,3], [0,0]]);
      }


    } // union
  } // translate

    
  // right bracket spacer
  translate([11.7517, -dyR, -bracket_space]){
    union(){
      // spacer part
      linear_extrude(height=bracket_space, v=[0,0,1], center=false){
	polygon(points=[[0,0],
			[3.695, 3.0], [37.9483,3],
			[37.9483, 17.5009],[40.9483,17.5009],
			[40.9483,0], [0,0]]);
      }

	
    } // union
      
  } // translate 

}

module make_screw_hole(pos)
{
  translate(pos){
    rotate([90,0,0]){
      cylinder(r=screw_r, h=4*bracket_t, center=true);
    }    
  }
}

module make_bracket_screw_holes()
{
  make_screw_hole([-31.2630,0,-4.75]);
  make_screw_hole([-45.5542,0,-4.75]);
  make_screw_hole([19.4295,0,-4.75]);
  make_screw_hole([45.0222,0,-4.75]);      
}


module make_compass_tray()
{
  dtol = 0.025;
  
  translate([base_rect_x/2,-bracket_t,0]){
    rotate([0,-90,0]){
      linear_extrude(height=compass_tray_l, v=[0,0,1], center=false){
	polygon(points=[[0,0], [-bracket_space, 0],
			[-bracket_space, bracket_t],
			[8.75,bracket_t],[8.75, -3.5],
			[6.75,-3.5],[6.75, -2+dtol],
			[bracket_t,-2+dtol],
			[bracket_t,-63-dtol],
			[6.75,-63-dtol],
			[6.75, -61], [8.75,-61],
			[8.75,-68],[0,-68],
			[0,0]
			]);
      }
    }
  }
}

module make_compass_tray_dovetail()
{
  dtol = 0.025;
  
  translate([-24.1174, 0, -(bracket_t*0 + bracket_space)]){
    linear_extrude(height=bracket_space, v=[0,0,1], center=false){
      polygon(points=[[dtol,0],
		      [-3+dtol, bracket_t], 
		      [-3+dtol, 5.5515],
		      [39.5640-dtol, 5.5515], [39.5640-dtol,bracket_t],
		      [35.8691-dtol, 0],
		      [dtol,0]
		      ]);
    }
  }
}

module make_compass_tray_gussets()
{
  dx = compass_tray_l - base_rect_x; // extra length of the tray
  union(){
    translate([bracket_t-base_rect_x/2-dx,-bracket_t,0]){
      rotate([0,-90,0]){
	linear_extrude(height=bracket_t, v=[0,0,1], center=false){
	  polygon(points=[[0,0],
			  [0, -(bracket_space + gusset_l)],
			  [-bracket_space, -gusset_l],
			  [-bracket_space, 0],
			  [0,0]
			  ]);
	}
      }
    }

    translate([bracket_t + base_rect_x/2 - bracket_t,-bracket_t,0]){
      rotate([0,-90,0]){
	linear_extrude(height=bracket_t, v=[0,0,1], center=false){

	  polygon(points=[[0,0],
			  [0, -(bracket_space + gusset_l)],
			  [-bracket_space, -gusset_l],
			  [-bracket_space, 0],
			  [0,0]
			  ]);	  
	}
      }
    }
  }    
}

module make_compass_tray_catch()
{
  catch_x_w = bracket_t; // x width
  catch_y_w = 3.6; // y width
  catch_z_w = 11.1; // z height

  catch_ypos = 35.5; // measured

  echo("******yyy = ", catch_y_w/2 - catch_ypos);

  union(){

  dx = compass_tray_l - base_rect_x; // extra length of the tray    
    //     translate([(-catch_x_w +base_rect_x/2)*0 +bracket_t, -catch_y_w/2 - catch_ypos, bracket_t]){        
    // new
    translate([-base_rect_x/2-dx+bracket_t, -catch_y_w/2 - catch_ypos, bracket_t]){        
      rotate([90,0,180]){
	linear_extrude(height=catch_y_w, v=[0,0,1], center=false){
	  polygon(points=[[0,0], 
			  [-2,7.1], [-5.4,7.1],
			  [-5.4,5.1],[-7.1,5.1],
			  [-8.8,7.1],[-8.8,catch_z_w],
			  [3,catch_z_w],[3,0],
			  [0,0]
			  ]
		  );
	} // extrude
      } // rotate
    } // translate

    guss_l = 13.6; // length of the gusset
    translate([-base_rect_x/2-dx, -catch_ypos-guss_l/2,0]){
      cube([catch_x_w,guss_l,catch_z_w + bracket_t], center=false);
    }

  } // union

}

module make_iphone_tray_gussets()
{
  union(){
    translate([bracket_t-base_rect_x/2,-bracket_t,0]){
      rotate([0,-90,0]){
	linear_extrude(height=bracket_t, v=[0,0,1], center=false){
	  polygon(points=[[0,0],
			  [0, -(bracket_space + gusset_l)],
			  [-bracket_space, -gusset_l],
			  [-bracket_space, 0],
			  [0,0]
			  ]);
	}
      }
    }

    translate([bracket_t + base_rect_x/2 - bracket_t,-bracket_t,0]){
      rotate([0,-90,0]){
	linear_extrude(height=bracket_t, v=[0,0,1], center=false){

	  polygon(points=[[0,0],
			  [0, -(bracket_space + gusset_l)],
			  [-bracket_space, -gusset_l],
			  [-bracket_space, 0],
			  [0,0]
			  ]);	  
	}
      }
    }
  }    
}




module make_iphone_tray()
{
  dtol = 0.025;
  iphone_h = iphone_H/2; // make the retaining walls half the height
			 // of the iPhone

  difference(){
    translate([base_rect_x/2,-bracket_t,0]){
      rotate([0,-90,0]){
	linear_extrude(height=base_rect_x, v=[0,0,1], center=false){
	  polygon(points=[[0,0], [-bracket_space, 0],
			  [-bracket_space, bracket_t],
			  [iphone_h + bracket_t,bracket_t],
			  [iphone_h + bracket_t, 0],
			  [bracket_t,0],[bracket_t, -iphone_w],
			  [iphone_h + bracket_t, -iphone_w],
			  [iphone_h + bracket_t, -(iphone_w+bracket_t)],
			  [0, -(iphone_w + bracket_t)],
			  [0,0]
			  ]);
	} // linear extrude
      }// rotate
    } // translate

    // make slot for on/off button

    // the y position has to be shifted because my (0,0) position
    // is at the centre of the phone

    onoff_x = iphone_l/2 - (iphone_onoff_x + iphone_button_l); 
    onoff_button_w = iphone_button_l; //mm, width of slot for 1 button
    /*    
    echo("**************");
    echo("on/off button x pos = ", onoff_x);
    echo("**************");
    */
    translate([onoff_x,(-(iphone_w+bracket_t) - bracket_t/2), bracket_t]){    
      cube([onoff_button_w, bracket_t, 2*iphone_h], center=false);
    }

    // make slot for the volume buttons
    vol_x = iphone_l/2-(iphone_vol_x + iphone_vol_l);
    
    /*
    echo("**************");
    echo("vol button x pos = ", vol_x);    
    echo("**************");
    */

    vol_button_w = iphone_vol_l;
    translate([vol_x, -bracket_t - bracket_t/2,bracket_t]){        
      cube([vol_button_w, bracket_t, 2*iphone_h], center=false);
    }

  } // difference
}



/********
  Entry point
*********/

union(){

  //********************************  
  // make the part that will be attached to the Mach1gto
  //********************************

  if (MAKE_ATTACHMENT == 1){
    translate([0, dyR, 0]){
    union(){
      difference(){
	union(){
	  make_base();
	  make_back_wall();
	}
	make_slot();
      }


      make_curved_wall();

      difference(){
	make_brackets();
	make_bracket_screw_holes();
      }
      
    } //union
    }
  }
  //********************************    




  //********************************  
  // make the part for the compass or iphone
  //********************************

  //--------------------------------
  // for compass
  //--------------------------------

  if(MAKE_COMPASS_TRAY == 1){
    difference(){

      union(){
	make_compass_tray();
	make_compass_tray_dovetail();
	make_compass_tray_gussets();

	make_compass_tray_catch();
      }

      make_bracket_screw_holes();
      /*
      translate([-100-70,-100,-25]){
	cube([200, 150, 50], center = false);
      
	}
      */
      
    }
  }
  
  //--------------------------------
  // for iPhone or Android
  //--------------------------------

  if(MAKE_IPHONE_TRAY == 1){
    difference(){

      union(){
	make_iphone_tray();
	make_compass_tray_dovetail();
	make_iphone_tray_gussets();
      }

      make_bracket_screw_holes();

    }
  }


} // union


