---
name: colormap
description: "This tool maps normalized scalar data to high-quality color gradients using fragment shaders or a C++ library. Use when user asks to map float values to RGBA colors, integrate scientific palettes into shaders, or process heatmaps in C++."
homepage: https://github.com/kbinani/colormap-shaders
---


# colormap

## Overview
The colormap skill provides a standardized interface for mapping normalized scalar data to high-quality color gradients. It is designed for developers working on scientific visualization, heatmaps, or procedural rendering who need to integrate established palettes like Jet, Parula, or ColorBrewer. The skill covers the usage of a collection of fragment shaders and a C-style/C++ library that transforms a float input (0.0 to 1.0) into an RGBA color vector.

## Shader Integration (GLSL/Metal)
The primary way to use these colormaps in graphics pipelines is through the provided fragment shaders.

### Standard Function Signature
Most shaders in the `shaders/` directory provide a uniform function:
```glsl
vec4 colormap(float x);
```
- **Input**: A float `x` where `0.0 <= x <= 1.0`.
- **Output**: A `vec4` representing the RGBA color.

### Usage Pattern
To implement a colormap, you typically include the shader source directly into your fragment shader:
```glsl
void main() {
    // Map texture coordinates or data values to a color
    gl_FragColor = colormap(gl_TexCoord[0].x);
}
/* Append the content of "shaders/[palette_name].frag" here */
```

### Gnuplot Special Case
The `gnuplot.frag` shader emulates gnuplot's `rgbformulae` and requires three additional integer arguments to define the mapping logic:
```glsl
vec4 colormap(float x, int red_type, int green_type, int blue_type);
```

## C++ Library Usage
For CPU-side color mapping or data processing, use the header-only C++ library.

### Basic Implementation
1. **Include**: `#include <colormap/colormap.h>`
2. **Namespace**: Use the `colormap` namespace.
3. **Access**: Instantiate a specific palette class to access its properties.

```cpp
#include <colormap/colormap.h>

int main() {
    using namespace colormap;
    
    // Initialize a specific map
    MATLAB::Jet jet;
    
    // Get color at a specific point (0.0 to 1.0)
    Color c = jet.getColor(0.5f);
    
    // Access components: c.r, c.g, c.b
    return 0;
}
```

### Metadata and Discovery
You can programmatically list or query colormaps using the `ColormapList` class:
- `c->getCategory()`: Returns the source (e.g., "MATLAB", "IDL").
- `c->getTitle()`: Returns the specific palette name.
- `ColormapList::getAll()`: Returns a list of all available colormap objects.

## Available Palettes
The library organizes palettes by their origin:
- **MATLAB**: autumn, bone, cool, copper, hot, hsv, jet, parula, pink, spring, summer, winter.
- **IDL**: Includes standard linear maps, Rainbow, Plasma, and extensive ColorBrewer (CB) support (e.g., IDL_CB-Spectral).
- **Transform**: seismic, lava_waves, space, morning_glory, etc.
- **kbinani**: altitude.

## Best Practices
- **Normalization**: Always ensure the input value is clamped between `0.0` and `1.0` before passing it to the `colormap` function to avoid undefined behavior in specific shader implementations.
- **Performance**: In performance-critical shader code, prefer including the specific `.frag` file for the required palette rather than implementing a dynamic selection mechanism.
- **Header-Only**: The C++ library is header-only; ensure your include paths are correctly set to the `include/` directory of the repository.

## Reference documentation
- [Main Repository and Usage](./references/github_com_kbinani_colormap-shaders.md)
- [C++ Header Structure](./references/github_com_kbinani_colormap-shaders_tree_master_include_colormap.md)