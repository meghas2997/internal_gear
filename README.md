# Internal Gear with with IceSl as Lua script

Development of a demonstration model of a gear based machine element used for an animated education video and fabricable with additive manufacturing designed parametrically with IceSl as Lua script

## IcesL as Lua Script (Forge and slicer)
IceSL forge is a software which is resposible for Modelling and Slicing and it is a flexible for modelling and fabricating complex shapes and designs. 
Modelling in ICesl is done with the help of Lua Script. Modelling of the different shapes are done with customization of parameters. 
Using the same technology, printer instructions (for example, G-code) can be generated efficiently without having to create a mesh. 
On the other hand, IcesL Slicer is used to generate a the printng command of the STL file or a Lua script model. Using the slicing technology, it generates G-code for the printer
[icesl Loria] https://icesl.loria.fr/features/

## What is an Internal Gear?
An internal gear is a gear which has its teeth cut into the internal surface of a cylinder and meshes with a spur gear.Alternatively, an internal gear may be referred to as a ring gear. An internal gear is an important component of planetary gearboxes, but it can also be utilized elsewhere. Planetary gear trains are advantageous in terms of low vibrations, high speed reduction ratios, and cost effectiveness. Since the centers of the mating wheels can be closer than those of external gears, internal spur gears are preferred in applications where space is limited. Power transmissions in hybrid vehicles, robotic arms, and turbine generators are examples of planetary gear transmissions. Just like external gears, internal gears can also be cut in helical gears. Internal gears like these can be found in some internal gear drives, pair drives, differential drives, and planetary drives. It is necessary to design special housings to house the internal gear. https://www.marplesgears.com/2019/11/internal-gears/

## Description of the Script
We have paramtrically designed the Internal gears assembly including an internal gear and the external gear. 
The assembly consists of the meshing of the internal and external gear which have an involute tooth profile and simplified fillet geometry. The code allows to input various values in order to get the desired output that ensures proper meshing of the gear. 

### Defined Parameters
Before the functional part, the defined parameters are mentioned. The base parameters are considered to be the first step for modelling in the code. Some of these parameters are user defined and the other parameters are derived from the inputs given. Through the tweak box the user can change the values to analyze the variations in the model. 

There is a User Interface Box in IcesL with has the components with the following parameters:

1. Number of teeth (Default value, Minimum value, Maximum Value)
2. Module of gear (Default value, Minimum value, Maximum Value)
3. Pressure angle (Default value, Minimum value, Maximum Value)
4. width (Default value, Minimum value, Maximum Value)
5. Profile shift (Default value, Minimum value, Maximum Value)
6. Fillet Radius (Default value, Minimum value, Maximum Value)

The above parameters are defined as a user interface in the following way: 
![image](https://user-images.githubusercontent.com/92062404/143454775-c0246d67-c877-4ba9-9aff-96e47c89a0aa.png)

Some Parameters are user defined. And the other parameters that are also required for the gear modelling are defined using the Derived Inputs. 
![image](https://user-images.githubusercontent.com/92062404/143454939-1f31e7aa-0759-4f6f-9e07-b19177f44b45.png)
![image](https://user-images.githubusercontent.com/92062404/143454966-5e2922d3-e537-48f9-b12f-9df5871beed0.png)

### Parameters with Some dependencies: 
For the calculation of Involute function of the pressure angle, the difference between the number of teeth of internal gears and that of external gear is taken to be 8 so as to avoid any interference during the meshing of the gears. 
![image](https://user-images.githubusercontent.com/92062404/143455044-59777a52-453e-47e7-9079-1c472d827743.png)

#### Function 1: inserting the involute curve with the base radius and the involute angle. And rotating the contour. 
![image](https://user-images.githubusercontent.com/92062404/143466282-352689af-5f82-4d4d-8978-e2b4eb8f0496.png)

#### Function 2: To Mirror the Involute Curve 
![image](https://user-images.githubusercontent.com/92062404/143466269-4ef86626-6c8a-4fcc-860c-60f0e445fd4e.png)

#### Function 3: To Rotate the Contour of the Involute 
![image](https://user-images.githubusercontent.com/92062404/143466238-1caaabc8-8165-433a-9cd7-adb268e2d874.png)

#### Function 4: This function gives a point at a given angle theta of a circle.
![image](https://user-images.githubusercontent.com/92062404/143466214-e509fec8-d8b9-4435-8bc8-81b4fcfdff5b.png)

#### Function 5: This function is intended to create a circle with a radius r. Using the command ‘v’ to fill the table with vectors. When function is called it takes the input of radius r and the ab points are required for the generation of circle. 
![image](https://user-images.githubusercontent.com/92062404/143466202-68391605-bda2-4003-988e-9465f91743d4.png)

#### Function 6: This function is intended for calculating the involute angle. The radius of the Addendum circle and base circle are passed as an input for obtaining corresponding involute angle. And then the slope of one line is defined for determining the fillet radius. 
![image](https://user-images.githubusercontent.com/92062404/143466186-93c282b4-8485-4619-af9c-193dce672ee0.png)

#### Function 7: This function is intended to start and stop the involute tooth between addendum radius and base radius.
![image](https://user-images.githubusercontent.com/92062404/143466167-af5ac4cd-0cc8-4f75-bbd8-05f2657a4470.png)

#### Function 8: Fillet formation of the bottom profile of the gear with slope of the line and with fillet radius and base radius. A line parallel to the slope of line is formed so as to find the point to form the circle. The point of intersection of the fillet circle and the base radius gives the fillet radius. 
![image](https://user-images.githubusercontent.com/92062404/143466138-d2bc157e-4b72-490d-b795-461f0b0ff417.png)

To iterate the points for the fillet, a for loop is mentioned
![image](https://user-images.githubusercontent.com/92062404/143466113-3a260ffd-3f27-490a-b707-c16996a9e0ad.png)

To iterate the points for the fillet, a for loop is mentioned
![image](https://user-images.githubusercontent.com/92062404/143466090-184fb5df-1a92-46a1-8ac8-ad380099dfa3.png)

For Loop: The Gear tooth with the Involute and fillet is made by iterating the points in loop
![image](https://user-images.githubusercontent.com/92062404/143466075-65e1a40b-af7d-4609-9a65-26e1128645c5.png)

#### Function 9: Circle Formation for the teeth to form around the gear 
![image](https://user-images.githubusercontent.com/92062404/143466055-496d6140-59d6-4351-bcb4-6c95b7340b97.png)

#### Function 10: this function extrudes the Internal Gear
![image](https://user-images.githubusercontent.com/92062404/143466026-53804b85-2027-4fb5-891d-c642300fdf19.png)

Applying the Involute extrude to the gear, and emitting it with the translation of the gear position.
![image](https://user-images.githubusercontent.com/92062404/143466006-b730e102-3be8-486e-853b-0e885695504d.png)

#### Formation of internal gear: Applying the extrude and taking the difference and emitting the Internal gear with the rotation of gear
![image](https://user-images.githubusercontent.com/92062404/143465979-fd6fe187-33cf-4df3-aaf9-68203756548e.png)

#### Formation of external gear: Applying the extrude and emitting the external gear with translation of the gear and its rotation. 
![image](https://user-images.githubusercontent.com/92062404/143465940-15b5e1c8-7851-4420-b93f-ccd07ac6f490.png)
![image](https://user-images.githubusercontent.com/92062404/143466476-dbf15400-2f70-45c0-8d14-b51b1d92f01f.png)



## Assembly Description:
#### Part List:

1.	External Gear	
2.	Shaft	
3.	Internal Gear	
4.	Casing of Internal Gear	
5.	Shaft with splines

•	The internal gear and the external gear can be printed by the user by following the above given instructions and Parameters and inputs. For the further Assembly parts, a part list is stated above so as to assemble the gear for the desired functioning of gears. 

•	The Internal Gear is mounted in the cylindrical casing. The gear is mounted in casing using the bolts for that the user needs to drill holes on the internal Gear. On the center of the casing there is shaft mounted. The center of the casing that is cut with splines to fit the shaft in the casing. 

•	The external gear is made out of the shaft 


