!
! Qweak coordinate frames to be respected in this file
!
! Global coordinate system:
! - global origin is the center of QTOR
! - global x is beam left (this is the origin of the global azimuthal angle phi)
! - global y is vertical upwards
! - global z is downstream along the beam line
!
! Octant assignments:
! - octant 1 (9 o'clock) is the octant at global phi = 0
! - octant 3 (12 o'clock) is the octant at global phi = 90 deg = pi/2 rad
! - ...
!
! Local coordinate systems:
! - local origin is the specified position of the detector
! - local x is radially outward in the global system
! - local y is azimuthally towards increasing phi in the global system
! - local z is identical to global z
! Only in octant 1 are local x, y, z direction == global x, y, z direction!
! In octants at phi the local coordinate system is rotated over phi around z.
!
! The local system can be rotated around the local y axis such that local x
! remains in the plane of the detector (region 2 HDCs are not rotated, but
! region 3 VDCs are rotated over a *negative* angle of 24 degrees).

!
! Order of the variables has to be preserved.
!

! Fields:
!   name,
!   type, local origin in global z {REGION 3 VDCs ONLY ---- (Package 2 on MD 1),
!   global z (P2 on MD2), global z (P2 on MD3), global z (P2 on MD8), global z (P2 on MD7) ---- }, 
!   rotation around local y, spatial resolution, tracking resolution, slope matching,
!   package, region, type, direction,
!   local origin in global x {REGION 3 VDCs ONLY ---- (Package 2 on MD1),
!   x (P2 on MD2), x (P2 on MD3), x (P2 on MD8), x (P2 on MD7), ----} 
!   y {REGION 3 VDCs ONLY ---- (Package 2 on MD1), x (P2 on MD2),
!   x (P2 on MD3), x (P2 on MD8), x (P2 on MD7), ----} 
!   active width in local x, y, z,
!   wire spacing, position of first wire,
!   cos of x/u/v axis angle with respect to local x and y,
!   sin of x/u/v axis angle with respect to local x and y,
!   tilt of chamber in xy about Z axis in Degrees {REGION 3 VDCs ONLY ---- (Package 2 on MD1),
!   tilt (P2 on MD2), tilt (P2 on MD3), tilt (P2 on MD8), tilt (P2 on MD7), ----} 
!   number of wires, ID
!
! Note that the x/u/v axis is perpendicular to the wires.  Wires are strung
! at constant x/u/v.
!
! This might change, notably the treatment of up/down package could be replaced
! by the global octant number, an intermediate local origin could be shifted to
! the beam line, and the detector origin specified in that coordinate system.
!

! For region 3: package right is u, package left is d
!Yoda v
NAME=VDC_LeftFront
 drift, 443.13, 442.83, 442.83, 443.54, 443.62, -24.55, -24.45, -24.41, -24.62, -24.64, 7e-2, 9e-2, 1e-1, d, 3, d, v, 1.13, 0.87, 0.83, 0.46, 0.05, 273.74, 273.99, 273.94, 273.45, 273.42, 204.47, 53.34, 2.98, 0.496965, -69.9, 0.894427, 0.447214, 0.23, 0.21, 0.25, 0.13, 0.1, 279, 0
!Yoda u
NAME=VDC_LeftFront
 drift, 445.44, 445.14, 445.15, 445.85, 445.92, -24.55, -24.45, -24.41, -24.62, -24.64, 7e-2, 9e-2, 1e-1, d, 3, d, u, 1.13, 0.87, 0.82, 0.46, 0.05, 272.68, 272.94, 272.89, 272.40, 272.36, 204.47, 53.34, 2.98, 0.496965, -69.9, 0.894427, -0.447214, 0.23, 0.21, 0.25, 0.13, 0.1, 279, 1
!Han v
NAME=VDC_LeftBack
 drift, 496.31, 495.98, 495.99, 496.74, 496.84, -24.61, -24.52, -24.48, -24.69, -24.71, 7e-2, 9e-2, 1e-1, d, 3, d, v, 1.32, 0.99, 0.90, 0.56, 0.07, 295.57, 295.89, 295.83, 295.23, 295.14, 204.47, 53.34, 2.98, 0.496965, -68.95, 0.894427, 0.447214, 0.23, 0.21, 0.25, 0.13, 0.1, 279, 2
!Han u
NAME=VDC_LeftBack
 drift, 498.62, 498.29, 498.30, 499.05, 499.15, -24.61, -24.52, -24.48, -24.69, -24.71, 7e-2, 9e-2, 1e-1, d, 3, d, u, 1.32, 0.99, 0.89, 0.56, 0.06, 294.52, 294.83, 294.78, 294.17, 294.08, 204.47, 53.34, 2.98, 0.496965, -69.3, 0.894427, -0.447214, 0.23, 0.21, 0.25, 0.13, 0.1, 279, 3
!Vader v
NAME=VDC_RightFront
 drift, 443.45, 443.83, 443.91, 443.16, 442.98, -24.33, -24.37, -24.24, -24.21, -24.2, 7e-2, 9e-2, 1e-1, u, 3, d, v, -0.08, -0.10, 0.45, -0.63, -0.60, 272.78, 272.44, 272.39, 273.11, 273.15, 204.47, 53.34, 2.98, 0.496965, -69.3, -0.894427, -0.447214, 0.16, 0.09, 0.08, 0.2, 0.27, 279, 4
!Vader u
NAME=VDC_RightFront
 drift, 445.77, 446.15, 446.23, 445.48, 445.29, -24.33, -24.37, -24.24, -24.21, -24.2, 7e-2, 9e-2, 1e-1, u, 3, d, u, -0.08, -0.09, 0.46, -0.62, -0.59, 271.73, 271.40, 271.34, 272.07, 272.11, 204.47, 53.34, 2.98, 0.496965, -69.3, -0.894427, 0.447214, 0.16, 0.09, 0.08, 0.2, 0.27, 279, 5
!Leia v
NAME=VDC_RightBack
 drift, 496.51, 496.90, 496.93, 496.17, 495.98, -24.41, -24.46, -24.33, -24.50, -24.28, 7e-2, 9e-2, 1e-1, u, 3, d, v, -0.02, -0.04, 0.58, -0.61, -0.57, 294.80, 294.43, 294.49, 295.24, 295.29, 204.47, 53.34, 2.98, 0.496965, -69.63, -0.894427, -0.447214, 0.16, 0.09, 0.08, 0.2, 0.27, 279, 6
!Leia u
NAME=VDC_RightBack
 drift, 498.82, 499.21, 499.24, 498.49, 498.29, -24.41, -24.46, -24.33, -24.50, -24.28, 7e-2, 9e-2, 1e-1, u, 3, d, u, -0.02, -0.04, 0.59, -0.61, -0.56, 293.75, 293.38, 293.45, 294.19, 294.25, 204.47, 53.34, 2.98, 0.496965, -69.38, -0.894427, 0.447214, 0.16, 0.09, 0.08, 0.2, 0.27, 279, 7


NAME=TS_Left
 scint, 539.74, 0, -9999, -9999, -9999, u, 4, t, y, 0, 317.34, 218.45, 30.48, 1.0, -9999, -9999, -9999, -9999, -9999, -9999, 8
NAME=TS_Right
 scint, 539.74, 0, -9999, -9999, -9999, d, 4, t, y, 0, -317.34, 218.45, 30.48, 1.0, -9999, -9999, -9999, -9999, -9999, -9999, 9

!NAME=MD1
! cerenkov, 576.665, 0, -9999, -9999, -9999, u, 5, c, y, 0, 334.724, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 10
!NAME=MD2
! cerenkov, 576.705, 0, -9999, -9999, -9999, d, 5, c, y, 0, 334.742, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 11
NAME=MD3
 cerenkov, 577.020, 0, -9999, -9999, -9999, u, 5, c, y, 0, 334.738, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 10
!NAME=MD4
! cerenkov, 577.425, 0, -9999, -9999, -9999, d, 5, c, y, 0, 335.036, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 11
!NAME=MD5
! cerenkov, 577.515, 0, -9999, -9999, -9999, u, 5, c, y, 0, 335.074, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 10
!NAME=MD6
! cerenkov, 577.955, 0, -9999, -9999, -9999, d, 5, c, y, 0, 335.252, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 11
NAME=MD7
 cerenkov, 577.885, 0, -9999, -9999, -9999, u, 5, c, y, 0, 335.224, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 10
!NAME=MD8
! cerenkov, 577.060, 0, -9999, -9999, -9999, d, 5, c, y, 0, 334.888, 200.0, 18.0, 1.25, -9999, -9999, -9999, -9999, -99, -9999, 11


! Beam right upstream HDC (octant 5,pkg1)
NAME=HDC
 drift, -342.300, -342.300, -342.300, -342.300,-342.300, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, x, -0.276, -0.305, -0.092, -0.381, -0.3, 51.013, 51.202, 50.894, 50.943, 51.113, 28.575, 37.39, -9999, 1.1684, -18.1102, 1.000, 1.000, 1.000, 1.000, 1.000,-0.004,0.005,-0.001,0.003,0, 0, 32, 12
NAME=HDC
 drift, -340.322, -340.322, -340.322, -340.322,-340.322, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, u, -0.275, -0.304, -0.093, -0.381, -0.3, 50.951, 51.100, 50.791, 50.841, 51.011, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.597,0.604,0.599,0.602,0.6, -0.802,  -0.797,-0.801, -0.798, -0.8, 0, 32, 13
NAME=HDC
 drift, -338.344, -338.344, -338.344, -338.344,-338.344, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, v, -0.276, -0.305, -0.092, -0.381, -0.3, 51.195, 51.344, 51.036, 51.085, 51.255, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.603, 0.596, 0.601, 0.597, 0.6, 0.798, 0.803, 0.799, 0.802, 0.8, 0, 32, 14
NAME=HDC
 drift, -336.366, -336.366, -336.366, -336.366,-336.366, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, x, -0.276, -0.305, -0.092, -0.381, -0.3, 51.013, 51.202, 50.894, 50.943, 51.113, 28.575, 37.39, -9999, 1.1684, -18.1102, 1.000, 1.000, 1.000, 1.000, 1.000, -0.004, 0.005, -0.001,0.003, 0, 0, 32, 15
NAME=HDC
 drift, -334.388, -334.388, -334.388, -334.388,-334.388, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, u, -0.275, -0.304, -0.093, -0.381, -0.3, 50.951, 51.100, 50.791, 50.841, 51.011, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.597,0.604,0.599, 0.602,0.6, -0.802, -0.797, -0.801, -0.798, -0.8, 0, 32, 16
NAME=HDC
 drift, -332.410, -332.410, -332.410, -332.410,-332.410, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, v, -0.276, -0.305, -0.092, -0.381, -0.3, 51.195, 51.344, 51.036, 51.085, 51.255, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.603, 0.596, 0.601, 0.597, 0.6, 0.798, 0.803, 0.799, 0.802, 0.8,  0, 32, 17
 ! Beam left upstream HDC (octant 1,pkg2)
NAME=HDC
 drift, -341.700, -341.700, -341.700, -341.700, -341.700, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, x, -0.857, -0.912, -0.238, 0.057, 0.082, 51.254, 51.045, 51.342, 51.298, 51.123, 28.575, 37.39, -9999, 1.1684, -18.1102, 1, 1, 1, 1, 1, -0.015,-0.016, -0.005, -0.005, -0.002,0, 32, 18
NAME=HDC
 drift, -339.722, -339.722, -339.722, -339.722, -339.722, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, u, -0.857, -0.910, -0.238, 0.057, 0.082, 51.192, 50.943, 51.240, 51.196, 51.021, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.588, 0.587, 0.596, 0.596, 0.598, -0.809, -0.809,  -0.803, -0.803,-0.801, 0, 32, 19
NAME=HDC
 drift, -337.744, -337.744, -337.744, -337.744, -337.744, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, v, -0.857, -0.914, -0.240, 0.057, 0.082, 51.436, 51.187, 51.484, 51.440, 51.265, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.612,0.612,0.604,0.604,0.602, 0.791, 0.790, 0.797, 0.797, 0.799, 0, 32, 20
NAME=HDC
 drift, -335.766, -335.766, -335.766, -335.766, -335.766, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, x, -0.857, -0.912, -0.238, 0.057, 0.082, 51.254, 51.045, 51.342, 51.298, 51.123, 28.575, 37.39, -9999, 1.1684, -18.1102, 1, 1, 1, 1, 1, -0.015, -0.016, -0.005, -0.005, -0.002,0, 32, 21
NAME=HDC
 drift, -333.788, -333.788, -333.788, -333.788, -333.788, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, u, -0.857, -0.910, -0.238, 0.057, 0.082, 51.192, 50.943, 51.240, 51.196, 51.021, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.588, 0.587, 0.596, 0.596, 0.598, -0.809,-0.809, -0.803, -0.803,  -0.801, 0, 32, 22
NAME=HDC
 drift, -331.810, -331.810, -331.810, -331.810, -331.810, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, v, -0.857, -0.914, -0.240, 0.057, 0.082, 51.436, 51.187, 51.484, 51.440, 51.265, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.612,0.612,0.604,0.604,0.602, 0.791, 0.790, 0.797, 0.797, 0.799, 0, 32, 23
 ! Beam right downstream HDC (octant 5,pkg1)
 NAME=HDC
 drift, -299.600, -299.600, -299.600, -299.600, -299.600, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, x, -0.141, -0.199, 0.101, -0.266, -0.138, 54.903, 55.093, 54.770, 54.853, 54.983, 28.575, 37.39, -9999, 1.1684, -18.1102, 1.000,  1.000, 1.000, 1.000, 1.000,-0.004,0.003,-0.001,0.004,0, 0, 32, 24
NAME=HDC
 drift, -297.622, -297.622, -297.622, -297.622, -297.622, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, u, -0.140, -0.199, 0.101, -0.266, -0.138, 54.841, 54.991, 54.668, 54.751, 54.881, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.597, 0.603, 0.599, 0.602, 0.6, -0.802, -0.798, -0.801, -0.798, -0.8, 0, 32, 25
NAME=HDC
 drift, -295.644, -295.644, -295.644, -295.644, -295.644, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, v, -0.141, -0.200, 0.102, -0.267, -0.138, 55.085, 55.235, 54.912, 54.995, 55.125, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.603, 0.597, 0.601, 0.597, 0.6, 0.798,0.802, 0.799, 0.802,  0.8, 0, 32, 26
NAME=HDC
 drift, -293.666, -293.666, -293.666, -293.666, -293.666, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, x, -0.141, -0.199, 0.101, -0.266, -0.138, 54.903, 55.093, 54.770, 54.853, 54.983, 28.575, 37.39, -9999, 1.1684, -18.1102, 1.000,  1.000, 1.000, 1.000, 1.000,-0.004,0.004,-0.001,0.003,0,0, 32, 27
NAME=HDC
 drift, -291.688, -291.688, -291.688, -291.688, -291.688, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, u, -0.140, -0.199, 0.101, -0.266, -0.138, 54.841, 54.991, 54.668, 54.751, 54.881, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.597, 0.603, 0.599, 0.602, 0.6, -0.802, -0.798, -0.801, -0.798, -0.8, 0, 32, 28
NAME=HDC
 drift, -289.710, -289.710, -289.710, -289.710, -289.710, 0, 1e-2, 0.5e-1, 1e-2, u, 2, d, v, -0.141, -0.200, 0.102, -0.267, -0.138, 55.085, 55.235, 54.912, 54.995, 55.125, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.603, 0.597, 0.601, 0.597, 0.6, 0.798, 0.802,  0.799, 0.802,0.8, 0, 32, 29
! Beam left downstream HDC (octant 1,pkg2)
 NAME=HDC
 drift, -298.850, -298.850, -298.850, -298.850, -298.850, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, x, -0.857, -0.93, -0.216, 0.101, 0.224, 55.254, 55.088, 55.373, 55.323, 55.123, 28.575, 37.39, -9999, 1.1684, -18.1102, 1, 1,  1, 1, 1,-0.015, -0.016,-0.005,-0.003,-0.002,0, 32, 30
NAME=HDC
 drift, -296.872, -296.872, -296.872, -296.872, -296.872, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, u, -0.857, -0.928, -0.216, 0.101, 0.224, 55.192, 54.986, 55.271, 55.221, 55.021, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.588, 0.587, 0.596, 0.598,0.598,-0.809,-0.809,-0.803,-0.802,-0.802, 0, 32, 31
NAME=HDC
 drift, -294.894, -294.894, -294.894, -294.894, -294.894, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, v, -0.857, -0.932, -0.216, 0.101, 0.224, 55.436, 55.239, 55.515, 55.465, 55.265, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.612, 0.612 0.604, 0.602, 0.602, 0.791,0.790,0.797,0.798,0.798, 0, 32, 32
NAME=HDC
 drift, -292.916, -292.916, -292.916, -292.916, -292.916, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, x, -0.857, -0.93, -0.216, 0.101, 0.224, 55.254, 55.088, 55.373, 55.323, 55.123, 28.575, 37.39, -9999, 1.1684, -18.1102, 1, 1,  1, 1, 1,-0.015, -0.016,-0.005,-0.003,-0.002,0, 32, 33
NAME=HDC
 drift, -290.938, -290.938, -290.938, -290.938, -290.938, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, u, -0.857, -0.928, -0.216, 0.101, 0.224, 55.192, 54.986, 55.271, 55.221, 55.021, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.588,  0.587,0.596, 0.598,0.598,-0.809,-0.809,-0.803,-0.802,-0.802,0, 32, 34
NAME=HDC
 drift, -288.960, -288.960, -288.960, -288.960, -288.960, 0, 1e-2, 0.5e-1, 1e-2, d, 2, d, v, -0.857, -0.932, -0.216, 0.101, 0.224, 55.436, 55.239, 55.515, 55.465, 55.265, 28.575, 37.39, -9999, 1.1684, -18.1102, 0.612, 0.612, 0.604, 0.602, 0.602, 0.791,0.790,0.797,0.798,0.798, 0, 32, 35

!GEM Z location: -558 cm (in actual Qweak), -542.2 cm (in MC simulation, front chamber), -534.0 cm (in MC simulation, back chamber), chamber thickness (unknown)
NAME=GEM
 drift, -542.2, 0, 0.4, 0.4, -9999, u, 1, g, r, 0, 19.19, 12.0, 24.42, 1.0, 0.477886, 68.1, -9999, -9999, 0, 512, 36
NAME=GEM
 drift, -542.2, 0, 0.4, 0.4, -9999, u, 1, g, y, 0, 19.19, 12.0, 15.585, 1.0, 0.31373, -40.0, -9999, -9999, 0, 256, 37
NAME=GEM
 drift, -542.2, 0, 0.4, 0.4, -9999, d, 1, g, r, 0, -19.19, 12.0, 24.42, 1.0, 0.477886, -68.1, -9999, -9999, 0, 512, 38
NAME=GEM
 drift, -542.2, 0, 0.4, 0.4, -9999, d, 1, g, y, 0, -19.19, 12.0, 15.585, 1.0, 0.31373, 40.0, -9999, -9999, 0, 256, 39

! sType, Zpos, Rot, Spatial Res., Track Res, slope matching, up/low, region, type, plane dir, detector originx, y, active width x, y, z, wire spacing, 1st wire pos., rcos of wire oirentation w.r.t x, rsin, no.of wires, ID

!END
