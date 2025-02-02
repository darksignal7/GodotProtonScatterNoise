# GodotProtonScatterNoise
A script for godot add-on called Proton Scatter (https://github.com/HungryProton/scatter) to create inside of a shape with a noise

# Usage:
Put the create_inside_noise.gd script into -> res://addons/proton_scatter/src/modifiers
Add the modifier and edit it however you want!

# Parameters:
You can easily understand it with tweaking them but anyways:
- Noise Scale : float = Basically noise scale (bigger you enter, more the detail)
- Noise Threshold : float = A value compared with noise value.
- Except Density : bool = If true, objects will be able placed that cant be placed according to noise threshold.
- Except Density Threshold : float = Distance from the main "object islands" to objects to be placed.
- Except Chance : int = An object will be placed that cant be placed before in 1/except_chance chance.
- Sorry for the variable names! :) 
 
![swappy-20250202-223156](https://github.com/user-attachments/assets/98a363e8-28e2-4420-8f97-17e0e301a4bc)

![swappy-20250202-223453](https://github.com/user-attachments/assets/0d7bd13d-2fe9-480d-bbe6-355868a83821)

![swappy-20250202-223453](https://github.com/user-attachments/assets/e8e6a735-e573-46e0-8bfd-efd43fd68757)
