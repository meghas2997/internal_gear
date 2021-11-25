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

## Description of the Code
We have paramtrically designed the Internal gears assembly including an internal gear and the external gear. There is a User Interface Box in IcesL with has the components with the following parameters:
*Number of teeth (Default value, Minimum value, Maximum Value)
*Module of gear (Default value, Minimum value, Maximum Value)
Pressure angle (Default value, Minimum value, Maximum Value)
width (Default value, Minimum value, Maximum Value)
Profile shift (Default value, Minimum value, Maximum Value)
Fillet Radius (Default value, Minimum value, Maximum Value)


