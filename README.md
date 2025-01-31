# GodotProtonScatterNoise
A script for godot add-on called Proton Scatter (https://github.com/HungryProton/scatter) to create inside of a shape with a noise

# Usage:
Put the create_inside_noise.gd script into -> res://addons/proton_scatter/src/modifiers
Add the modifier and edit it however you want!

# Parameters:
- You can easily understand it with tweaking them but anyways:
- Noise Scale : float = Basically noise scale (bigger you enter, more the detail)
- Noise Threshold : float = A value compared with noise value.
- Except Density : bool = If true, objects will be able placed that cant be placed according to noise threshold.
- Except Chance : int = An object will be placed that cant be placed before in 1/except_chance chance.
