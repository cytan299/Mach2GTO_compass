# OpenSCAD source code

by C.Y. Tan 2024

This directory contains the OpenSCAD source code:
_mach2gto_compass.scad_. This code has been successfully compiled with
[OpenSCAD](https://openscad.org/downloads.html) version 2024.11.04.

Since all cell phones have different dimensions, the user can update
the code at the top of _mach2gto_compass.scad_ for their cell phone+case.

  ```cpp
  iphone_l = 140.5; // mm, length of the iPhone includes case. See photo.
iphone_w = 71; // mm, width of the iPhone includes case. See photo.
iphone_H = 10; // mm  height of the iPhone
iphone_button_l = 13; //mm, length of the iPhone button indent. See photo.
iphone_onoff_x = 29; // mm, from reference position. See photo.
iphone_vol_x = 29; // mm, from reference position. See photo.
iphone_vol_l = 26; //mm length of the iPhone volume buttons. See photo
  ```
The photo here: 

![phone_dimensions](https://github.com/cytan299/Mach2GTO_compass/blob/main//pics/phone_dimensions.jpeg)

shows what the dimensions that is required for the OpenSCAD program.

The user can choose what _STL_ files to generate by setting the
variable to "1":

```cpp

// Choose what you want to print by setting it to 1

MAKE_ATTACHMENT = 0;
MAKE_COMPASS_TRAY = 0;
MAKE_IPHONE_TRAY = 0;
MAKE_CLAMP_SCREW = 1;

```

## Support

All the software have been successfully compiled with OpenSCAD version
2024.10.28.

This is unsupported software and hardware. Build at your own peril! :)

You can submit questions or bug reports using the
[issues](https://github.com/cytan299/Mach2GTO_compass/issues) tab 
and then clicking on **New Issue**.

## License

All software is released under GPLv3.

All documentation is released under Creative Commons
Attribution-ShareAlike 3.0 Unported License or GNU Free
Documentation License, Version 1.3


    
  
  
  
  







