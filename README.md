# Internal Gear with with IceSl as Lua script

Development of a demonstration model of a gear based machine element used for an animated education video and fabricable with additive manufacturing designed parametrically with IceSl as Lua script

## IcesL as Lua Script (Forge and slicer)
IceSL forge is a software which is resposible for Modelling and Slicing and it is a flexible for modelling and fabricating complex shapes and designs. 
Modelling in ICesl is done with the help of Lua Script. Modelling of the different shapes are done with customization of parameters. 
Using the same technology, printer instructions (for example, G-code) can be generated efficiently without having to create a mesh. 
On the other hand, IcesL Slicer is used to generate a the printng command of the STL file or a Lua script model. Using the slicing technology, it generates G-code for the printer
https://icesl.loria.fr/features/

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



