/*
  
    mach2gto_compass.scad is the code to generate a tray for an iPhone
    or hiking compass
    
    Copyright (C) 2024  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the Mach2GTO compass tray distribution.

    mach2gto_compass.scad is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    mach2gto_compass.scad is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with mach2gto_compass.scad.  If not, see
    <http://www.gnu.org/licenses/>.

*/

$fn=100;

// Choose what you want to print by setting it to 1

MAKE_ATTACHMENT = 0;  
MAKE_COMPASS_TRAY = 0;
MAKE_IPHONE_TRAY = 0;
MAKE_CLAMP_SCREW = 1;


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

gusset_l = 10; //mm


// Do not change the following parameters

base_t = 5; // mm, base thickness

// rectangular part of the base
base_rect_x = 105.4; //mm
base_rect_y0 = 35.35; // mm, left top edge
base_rect_y1 = 37.8382; // mm, right top edge

// slot
slot_r = 15.0; //mm

// bracket
bracket_space = 9.25;//mm spacing
bracket_t = 3; //mm thickness of bracket wall

// screw holes
screw_r = 1; // mm

// clamp

clamp_screw_thread_r = 5;
clamp_screw_handle_h = 20;
clamp_screw_thread_len = base_t*2*0.75;


module make_base()
{
  union(){

    //  the polygon shape of the base that does not have angled walls
    //  or slots yet or wings
    linear_extrude(height=base_t, v=[0,0,1], center=false){
      polygon(points=[[0,0.00],[-base_rect_x/2, 0],[-base_rect_x/2, base_rect_y0],[base_rect_x/2,base_rect_y1],[base_rect_x/2,0], [0,0]]);
    }    

    // the wings of the base
    
    x0 = 38.4569; // left bottom edge of the wing
    y0 = 35.6862; 
      
    x1 = 32.7176; // left top edge of the wing
    y1 = 44.3; //

    x2 = 36.4917; // right top edge of the wing
    y2 = 45.7857;
    
    x3 = 41.775; // right bottom edge of the wing
    y3 = 37.5803;

    translate([0,0,0]){

	/*
	  The wings are made first.

	  (1) Left wall is translated to (-x0,y0)
	  (2) The angled left wall is cut by rotating about the angled side

	  (3) the right wall is translated to (+x0,0).
	  (4) The angled right wall is cut by rotating about the angled side

	  (5) The entire object is translated back to its final location
        
	 */


      difference(){ // right edge
	
        // left edge
	difference(){
	  // ******the wings are made first********
	  // the polygon
	  linear_extrude(height=base_t, v=[0,0,1], center=false){
	    polygon(points=[[-x0,y0],[-x1, y1],
			    [x2,y2],[x3,y3]]);
	    }

	  // left wedge for cutting the angled wall
	  translate([-x0,y0]){	
	    rotate(a=30, [-x1 - (-x0),y1-y0,0]){	    
	      linear_extrude(height=4*base_t, v=[0,0,1], center=false){
		polygon(points=[[0,0],[-14.2431, -0.3362], [-14.2431, 15.5638], [10.3701, 15.5638],[0,0]]);
	      }
	    }
	  }
	} // difference for making angled left edge


	
	translate([x3, y3, 0]){
	  rotate(a=-18, [x2-x3, y2-y3,0]){

	    linear_extrude(height=4*base_t, v=[0,0,1], center=false){
	      polygon(points=[[0,0],[-8.8017,13.6697], [11.4250, 13.6697], [11.4250, 0.2697],[0,0]]);
	    }	    
	    
	  } // rotate
	}
	  

      } // diference for making angled right edge

    
    } // translate for joining the base rectangle

  }// union
}

module make_slot()
{
  // coordinate of the circular slot  
  x0 = -0.08; 
  y0=23.24; 

  union(){

    // round hole
    translate([x0,y0, 0]){
      cylinder(r=slot_r, h = 4*base_t, center=true );
    }

    // the straight edges

    translate([x0,2*slot_r+y0, 0]){
      cube([2*slot_r, 4*slot_r, 4*base_t], center=true);
    }
    
  }
}

module make_brackets()
{

  // left bracket spacer
  translate([-24.1174, 0, -bracket_space]){
    union(){
      // space part
      linear_extrude(height=bracket_space, v=[0,0,1], center=false){
	polygon(points=[[0,0],
			[-28.5826, 0], [-28.5826,9.9321],
			[-25.5826, 9.9321],[-25.5826,3],
			[-3,3], [0,0]]);
      }

      // triangle part
      translate([0,0, -bracket_t]){
	linear_extrude(height=bracket_t, v=[0,0,1], center=false){
	  polygon(points=[[0,0],
			  [-28.5826, 0], [-28.5826,25.5826],
			  [-25.5826, 25.5826],
			  [0,0]]);
	} // linear extrude
	
      } // translate
    } // union
  } // translate

    
  // right bracket spacer
  translate([11.7517, 0, -bracket_space]){
    union(){
      // spacer part
      linear_extrude(height=bracket_space, v=[0,0,1], center=false){
	polygon(points=[[0,0],
			[3.695, 3.0], [37.9483,3],
			[37.9483, 17.5009],[40.9483,17.5009],
			[40.9483,0], [0,0]]);
      }

      // triangle part
      translate([0,0, -bracket_t]){

	linear_extrude(height=bracket_t, v=[0,0,1], center=false){
	  polygon(points=[[0,0],
			  [34.46580, 27.9833],
			  [40.9483,27.9833],
			  [40.9483, 0], [0,0]]);
	} // linear extrude

      } // translate triangle
	
    } // union
      
  } // translate 

}

module make_clamp_hole(pos)
{
   // the hole for the clamp threads
   translate(pos){
     cylinder(r=5, h = 4*base_t, center = true);
   } // translate
}

module make_clamp_screw()
{
  dtol = 0.25; //mm
  // screw. Make it a little smaller
  RodStart(2*(clamp_screw_thread_r-dtol), clamp_screw_handle_h, clamp_screw_thread_len);
  
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
      linear_extrude(height=base_rect_x, v=[0,0,1], center=false){
	polygon(points=[[0,0], [-bracket_space, 0],
			[-bracket_space, bracket_t], [7,bracket_t],
			[7, -3.5],[5,-3.5],
			[5, -2+dtol], [bracket_t,-2+dtol],
			[bracket_t,-61-dtol], [5,-61-dtol],
			[5, -59.5],[7,-59.5],
			[7,-66],[0,-66],
			[0,0]
			]);
      }
    }
  }
}

module make_compass_tray_wedge()
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

/*
  Define your iphone or android dimensions here
*/



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

    onoff_x = iphone_l/2-(iphone_onoff_x + iphone_button_l);
    /*
    echo("**************");
    echo("on/off button x = ", onoff_x);    
    echo("**************");
    */
    
    onoff_button_w = iphone_button_l; //mm, width of slot for 1 button
    translate([-onoff_button_w - onoff_x,-bracket_t - bracket_t/2,bracket_t]){
      cube([onoff_button_w, bracket_t, 2*iphone_h], center=false);
    }

    // make slot for the volume buttons
    vol_x = iphone_l/2-(iphone_vol_x + iphone_vol_l);
    
    /*
    echo("**************");
    echo("vol button x = ", vol_x);    
    echo("**************");
    */
    
    vol_button_w = iphone_vol_l;
    translate([-vol_button_w - vol_x,(-(iphone_w+bracket_t) - bracket_t/2) ,bracket_t]){
      cube([vol_button_w, bracket_t, 2*iphone_h], center=false);
    }

    
  } // difference
}



/********
  Entry point
*********/

union(){

  clamp_hole_pos = [33.8058,23.24, 0];


  //********************************  
  // make the part that will be attached to the Mach2GTO
  //********************************

  if (MAKE_ATTACHMENT == 1){
    union(){
      difference(){
	make_base();
	make_slot();
	make_clamp_hole(clamp_hole_pos);
      }
      // hole with thread
      translate(clamp_hole_pos){
	RodEnd(2*clamp_screw_thread_r, base_t, base_t);      
      }
    }

    difference(){
      make_brackets();
      make_bracket_screw_holes();
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
	make_compass_tray_wedge();
	make_compass_tray_gussets();
      }

      make_bracket_screw_holes();    
    }
  }
  
  //--------------------------------
  // for iPhone or Android
  //--------------------------------

  if(MAKE_IPHONE_TRAY == 1){
    difference(){

      union(){
	make_iphone_tray();
	make_compass_tray_wedge();
	make_compass_tray_gussets();
      }

      make_bracket_screw_holes();    
    }
  }

 //********************************



  //********************************  
  // make the clamp screw
  //********************************
  
  if (MAKE_CLAMP_SCREW == 1){
    make_clamp_screw();
  }
  
  //********************************  
} // union

include <threads.scad>
