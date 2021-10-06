-- Case Study Cyber Physical Production Systems using AI (SS21)
-- Group: Internal Gears (MS)
-- Assel Kopeyeva (00816421)
-- Megha Singh (00816009)

-- The project creates a demonstration model of an internal gear assembly

-- Creating a UI box components for the parameters

num_of_teeth=ui_number("Number Of Teeth",24,20,50);				-- number of teeth
module_gear=ui_number("Module Of Gear",3,2,25);					-- module
pressure_angle=ui_scalar("Pressure Angle",20,20,25);			-- pressure angle
width=ui_scalar("Width",15,5,20);								-- face width
profile_shift=ui_scalar("Profile Shift Factor",0,0,2.7);		-- profile shift coefficient
rotation = ui_numberBox ("Rotation of gear",0)*2;				-- 
f_r=ui_number("Fillet radius", 2,0,3)							-- fillet radius

--------------------------------------


involute_curve = function(base_radius, involute_angle)			
    return v(base_radius *
                 (math.sin(involute_angle) - involute_angle *
                     math.cos(involute_angle)), base_radius *
                 (math.cos(involute_angle) + involute_angle *
                     math.sin(involute_angle)))					-- returns the x- and y-coordinate of the involute function with respect to the base radius and involute angle
end

--------------------------------------

Mirror = function(coord) return v(-coord.x, coord.y) end		-- mirrors the involute function with respect to the y-axis

--------------------------------------

Rotation = function(rotate, coord)
    return v(math.cos(rotate) * coord.x + math.sin(rotate) * coord.y,
             math.cos(rotate) * coord.y - math.sin(rotate) * coord.x)
end																-- rotates the single tooth profile with respect to the origin/circle center

circle = function(a, b, r, th)
    return (v(a + r * math.cos(th), b + r * math.sin(th)))
end																--

circle1 = function(a, b, r)
    local xy = {}
    n = 30
    for i = 1, n do
        xy[i] = v(a + r * math.cos(2 * math.pi * i / n),
                  b + r * math.sin(2 * math.pi * i / n))
    end
    return xy													--
end

--------------------------------------

Angle = function(b, a) return (math.sqrt((a * a - b * b) / (b * b))) end		--

--------------------------------------

slope1 = function(contour) 
    return ((contour[2].y - contour[1].y) / (contour[2].x - contour[1].x))		-- creates a slope of -- line
end

-- Input parameters needed for gear design

gear_whole = function(z, m_t, alpha_t, c, x_coef, f_r, width)

    local inv_xy = {}

    m_t = m_t					-- transverse module of gear
    alpha_t = alpha_t			-- pressure angle
    z = z						-- number of teeth
    x_coef = x_coef				-- profile shift coefficient
    c = 0.167 * m_t				-- clearance of tooth
    f_r =  f_r					-- fillet radius 
	
    ----------------------------------
	
	d_p = z * m_t							-- pitch diameter
	r_p = d_p / 2							-- pitch radius
	
	d_b = d_p * math.cos(alpha_t)			-- base diameter of gear
	r_b = d_b / 2							-- base radius
	
	d_a = (d_p + (2 * m_t * (1 + x_coef)))	-- addendum diameter
	r_a = d_a / 2							-- addendum radius
	h_a = m_t + c							-- addendum height
	
	d_f = m_t * (z - 2) - 2 * c				-- root diameter
	r_f = d_f / 2							-- root_radius
	
	if	r_b < r_f	then	r_f = r_b - f_r	end -- a base radius that is smaller than a root radius is a condition for an internal gear
	
	h_r = m_t + c							-- root height

	d_TIF = math.sqrt(math.pow(d_p * math.sin(alpha_t) - 2 *
                                   (h_a - (m_t * x_coef) - h_r *
                                       (1 - math.sin(alpha_t))), 2) + d_b * d_b)	-- true involute diameter
	
    r_TIF = d_TIF / 2						-- true form radius

-- Tooth thickness calculation on the form circle

    s = m_t*((math.pi/2)+ 2*x_coef* math.tan(alpha_t))					-- tooth thickness on the pitch circle
	inv_a = math.tan(alpha_t) - alpha_t									-- involute function
    alpha_f = math.acos((d_p*math.cos(alpha_t))/d_TIF)					-- involute angle along the form ciecle
    inv_Ff = math.tan(alpha_f) - alpha_f;                          		-- involute function of the involute angle
    s_f = d_TIF*((s/d_p)+inv_a - inv_Ff)+(x_coef*math.tan(alpha_f));    -- thickness of the gear teeth 
    omega = (s_f)/(0.5*d_TIF);                                          -- angle swept along the form circle 
    
-- Function for starting and ending of an involute between two radii

    tooth_ang = (((math.pi * m_t / 2) + 2 * m_t * x_coef * math.tan(alpha_t)) /
                    r_p + 2 * math.tan(alpha_t) - 2 * alpha_t)

    start_angle = Angle(r_b, r_b)
    stop_angle = Angle(r_b, r_a)

    points1 = 100	-- for better accuracy 

    res = 30		-- for iterating the points

-- Fillet start
    
	local points = {}
    for i = 1, res do
        points[i] = involute_curve(r_b, (start_angle + (stop_angle - start_angle) * i / res))
    end
	
    m_s = slope1(points)
    slope_inv = math.atan(m_s)
    parral = {}	-- parallel line point 

    parral[1] = v(points[1].x + f_r * math.cos(slope_inv + math.pi / 2),
                  points[1].y + f_r * math.sin(slope_inv + math.pi / 2))

    d = (parral[1].y - m_s * parral[1].x) / math.sqrt(m_s * m_s + 1)
    th1 = math.asin(d / (f_r + r_b)) + slope_inv
    center_f = {}
    center_f[1] = v((f_r + r_f) * math.cos(th1), (f_r + r_f) * math.sin(th1))

-- Fillet

    th31 = 2 * math.pi + math.atan(center_f[1].y / center_f[1].x)
    th33 = 3 * math.pi / 2 + slope_inv

    for m = 1, z do
        th = 2* math.pi

        for i = 1, res do
            inv_xy[#inv_xy + 1] =Rotation(th*m/z,circle(center_f[1].x,
                                                          center_f[1].y, f_r,
                                                          (th31 + (th33 - th31) *
                                                              i / res)))			-- fillet radius
        end
	
		start_angle = Angle(r_b, r_TIF)
		stop_angle = Angle(r_b, r_a)

-- Gear tooth starts
    
		for i = 1, res do
			inv_xy[#inv_xy + 1] =Rotation(th*m/z, involute_curve(r_b, (start_angle +(stop_angle -start_angle) *i / res)))	-- first involute                                                                                                                                                                                                        
        end
    
		for i = res, 1, -1 do
			inv_xy[#inv_xy + 1] =Rotation(th*m/z,Rotation(tooth_ang, Mirror(involute_curve(r_b,(start_angle +(stop_angle -start_angle) *i / res)))))	-- second involute                                                                                                                                                                                                                                                                                                                                                                         
        end

        for i = res, 1, -1 do
            inv_xy[#inv_xy + 1] =Rotation(th*m/z,Rotation(tooth_ang,Mirror(circle(center_f[1].x,center_f[1].y, f_r,(th31 + (th33 - th31) *i / res)))))	-- second fillet                                                                                                                                                                     
        end
    end

    inv_xy[#inv_xy + 1] = inv_xy[1]
	output = linear_extrude(v(0,0,width),inv_xy)
    return output
end

--------------------------------------

function gear(params)
	return gear_whole(
		params.z or 24,
		params.m_t or 3,
		params.alpha_t or 20,
		params.c or 0.2,
          params.x_coef or 0,
		params.f_r or 0,
		params.width or 15    
    )
end

function circle_test(r)
	local x, y = 0, 0
	local XY={}
	for i = 1, 360 do
		local angle = i * math.pi / 180
		XY[i] = v(x + r * math.cos( angle ), y + r * math.sin( angle ))
  end  
  return XY
end
 
--------------------------------------

function extrude(Contour, angle, dir_v, scale_v, z_steps)
   -- extrude a Contour to a shape by turning the contour to angle in z_steps
   -- extrude a Contour in a dircetion given by the vector dir_v
   -- extrude a Contour with a scaling factor given by vector scale_v 
   -- Contour: a table of vectors as a closed contour (start point and end point is the same)
   -- angle: roation angle of contour along z_steps in deg
   -- dir_v: vector(x,y,z) direction of extrusion
   -- sacle_v: vector(x,y,z) scaling factors for extrudion
   -- z_steps: number of steps for the shape, mostly z_steps=2 if angle is equal zero 
   local n_cont= #Contour
   local angle= angle/180*math.pi

   local Vertex= {}
   for j= 0,z_steps-1 do
      local phi= angle*j/(z_steps-1)
      local dir_vh= dir_v*j/(z_steps-1)
      local scale_vh= (scale_v - v(1,1,1))*(j/(z_steps-1)) + v(1,1,1)
      for i= 1,n_cont-1 do
          Vertex[i+j*n_cont]= v((dir_vh.x + scale_vh.x * (Contour[i].x*math.cos(phi) - Contour[i].y*math.sin(phi))),
                                (dir_vh.y + scale_vh.y * (Contour[i].x*math.sin(phi) + Contour[i].y*math.cos(phi))),
                                (dir_vh.z * scale_vh.z))
      end
      table.insert(Vertex,Vertex[1+j*n_cont])
   end

   local vertex_sum_1 = v(0,0,0)
   local vertex_sum_m = v(0,0,0)
   for i= 1,n_cont-1 do
      vertex_sum_1= vertex_sum_1 + Vertex[i]
      vertex_sum_m= vertex_sum_m + Vertex[i+n_cont*(z_steps-1)]
   end    
   table.insert(Vertex,vertex_sum_1/(n_cont-1)) 
   table.insert(Vertex,vertex_sum_m/(n_cont-1)) 

   Tri= {}	-- the index on table with Vertex starts with zero !!!
   local k = 1
   for j=0,z_steps-2 do
      for i= 0,n_cont-2 do
         Tri[k]=   v(i, i+1, i+n_cont) + v(1,1,1)*n_cont*j
         Tri[k+1]= v(i+1, i+n_cont+1, i+n_cont) + v(1,1,1)*n_cont*j
         k= k+2
      end
   end
   for i= 0,n_cont-2 do
      Tri[k]= v(i+1,i,n_cont*z_steps)
      k= k+1
   end
   for i= 0,n_cont-2 do
      Tri[k]= v(i+n_cont*(z_steps-1),i+1+n_cont*(z_steps-1),n_cont*z_steps+1)
      k= k+1
   end
   return(polyhedron(Vertex,Tri))
end

--------------------------------------

function internal_gear()  
  b = gear({z=num_of_teeth;m_t=module_gear;alpha_t=pressure_angle*math.pi/180;c=clearance;width=width;x_coef=profile_shift;f_r=f_r})
end

internal_gear()

-- Calculation for the centre distance between gears using the profile shift coefficients
   
-- Involute function - Operating pressure angle

	x_coef_int = 0;     				-- profile shift coefficient of internal gear
	x_coef_ext = 0.5; 					-- profile shift coefficient of external gear
	z_2 = num_of_teeth;     			-- number of teeth of internal gear    
	z_1 = z_2-8;						-- number of teeth of external gear
	alpha_t = 20*math.pi/180 				-- pressure angle
	inv_a = math.tan(alpha_t) - alpha_t;	-- involute function of pressure  angle
	inv_aw = ((2*math.tan(alpha_t) * (x_coef_int - x_coef_ext))/(z_2 - z_1)) + inv_a	--

alpha_aw = 19*math.pi/180;	-- working pressure angle

y_c = ((z_2 - z_1) *(math.cos(alpha_t) - math.cos(alpha_aw)))/ (2* math.cos(alpha_aw));	-- centre distance incremental factor

-- Center distance: Gears

a = (((z_2 - z_1)/2)+y_c) * module_gear;

print("a:" .. a)

meshing = a;
addOn_distance= module_gear * 2;
radius=(num_of_teeth*module_gear)/2;
internal_radius=r_a;

function external_gear()
	ext_gr = gear({z=num_of_teeth-8;m_t=module_gear;alpha_t=pressure_angle*math.pi/180;c=clearance;width=width;x_coef=profile_shift;f_r=f_r})
end

external_gear()  

d_p = num_of_teeth * module_gear 
	
	-- pitch radius
    r_p = d_p / 2      
angle = (((math.pi * module_gear / 2) + 2 * module_gear * profile_shift * math.tan(alpha_t)) /
                    r_p + 2 * math.tan(alpha_t) - 2 * alpha_t)
--rotation3 = rotate(0,0,angle*90/math.pi)					
rotation3 = rotate(0,0, angle*90/math.pi)

d_p = z_1 * module_gear 
	
	-- pitch radius
    r_p = d_p / 2      
angle = (((math.pi * module_gear / 2) + 2 * module_gear * profile_shift * math.tan(alpha_t)) /
                    r_p + 2 * math.tan(alpha_t) - 2 * alpha_t)




rotation4 = rotate(0,0, (angle*90/math.pi))
-- Formation of an internal gear

r1= rotate(0,0,rotation)
radius=(num_of_teeth*module_gear)/2;
p= extrude(circle_test(internal_radius+5), 0, v(0,0,width), v(1,1,1), 20)

-- Internal gear base formation

casing_cyl=difference(cylinder(internal_radius+16,width),cylinder(internal_radius+2,width))

-- Formation of an external gear

diff = num_of_teeth - 8
r2 = rotate(0,0,rotation*z_2/z_1)

--------------------------------------

bore_externalGear=extrude(circle_test(addOn_distance*2),0,v(0,0,width), v(1,1,1),20)	-- Bore formation of external gear
slot_cube=translate(0,-meshing,0)*cube(addOn_distance*2,addOn_distance*2,width)
shaft_cyl=cylinder(addOn_distance*2,width+50)
cube_flange=translate(0,-meshing,0)*cube(addOn_distance*2,addOn_distance*2,width+5)
bore_diff=difference(bore_externalGear,slot_cube)
bore_full=difference(ext_gr,bore_diff)


bore_internalgear= extrude(circle_test(internal_radius+16),0,v(0,0,addOn_distance),v(1,1,1),20)
internalcylinder=cylinder(addOn_distance*2,width+50)

--------------------------------------

emit(translate(0,0,0)*r1*rotation3*difference(p,b),0);								-- creates an internal gear
emit(translate(0,meshing,0)*r2*rotation4*difference(bore_full,bore_diff),3)			-- creates an external gear
emit(translate(0,0,0)*casing_cyl,1)											-- creates an internal gear casing
emit(r1*translate(0,0,-6)*difference(bore_internalgear,internalcylinder),1)	-- creates a casing base
emit(translate(0,0,-65)*r1*shaft_cyl,2)								-- creates an internal gear casing shaft


emit(translate(0,meshing,-0.1)*r2*difference(shaft_cyl,cube_flange),2)	-- creates a shaft of an external gear