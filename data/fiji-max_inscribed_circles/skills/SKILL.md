---
name: fiji-max_inscribed_circles
description: The `fiji-max_inscribed_circles` plugin provides a robust method for filling binary shapes with the largest possible non-touching circles.
homepage: https://imagej.net/plugins/max-inscribed-circles
---

# fiji-max_inscribed_circles

## Overview
The `fiji-max_inscribed_circles` plugin provides a robust method for filling binary shapes with the largest possible non-touching circles. Unlike simple distance maps that find a single center, this tool iteratively identifies candidate circles from largest to smallest until a user-defined minimum diameter is reached. It is particularly useful for analyzing the width of irregular biological structures, packing problems, or generating a simplified "spine" of an object.

## Usage Instructions

### GUI Access
In Fiji/ImageJ, the tool is located at:
`Plugins > BIOP > Image Analysis > Binary > Max Inscribed Circles...`

### ImageJ Macro Scripting
To automate the process within a standard ImageJ macro, use the `run` command. The plugin is macro-recordable.

```javascript
// Basic usage: fits circles down to 20 pixels in diameter
run("Max Inscribed Circles...", "minimum=20");

// To find only the single largest inscribed circle
run("Max Inscribed Circles...", "minimum=0");
```

### Advanced Scripting (Groovy/Python)
For complex workflows, use the Java API via the Builder pattern. This allows access to advanced features like "spine" extraction which are not available in the basic macro command.

**Key Parameters:**
- `minimumDiameter(double)`: The stopping criterion for the iterative process.
- `useSelectionOnly(boolean)`: If true, ignores the full image mask and only processes the active ROI.
- `getSpine(boolean)`: Enables the calculation of a central spine based on circle centers.

**Groovy Example:**
```groovy
import ch.epfl.biop.MaxInscribedCircles

// Initialize the builder with an ImagePlus object (imp)
def mic = MaxInscribedCircles.builder(imp)
    .minimumDiameter(5.0)
    .useSelectionOnly(true)
    .getSpine(true)
    .build()

mic.process()

// Retrieve results
def circles = mic.getCircles() // List of ROI objects
def spines = mic.getSpines()
```

### Best Practices and Tips
- **Input Format**: Ensure the input image is an **8-bit binary image**. The plugin does not support stacks directly in the basic call; iterate through slices manually if processing a stack.
- **Accuracy**: The tool relies on a Euclidean Distance Map (EDM). While highly accurate for most biological applications, accuracy may decrease for circles with a diameter smaller than 2 pixels due to the finite nature of the pixel grid.
- **Performance**: The plugin uses a Local Maxima Finder to place multiple circles of the same size in a single pass, making it significantly faster than older implementations that recalculated the EDM for every single circle.
- **ROI Management**: Found circles are automatically added to the ROI Manager when run via the GUI or standard macro. When scripting, you must manually add the returned ROIs to the manager or overlay.

## Reference documentation
- [Max Inscribed Circles - ImageJ Wiki](./references/imagej_net_plugins_max-inscribed-circles.md)
- [fiji-max_inscribed_circles - Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fiji-max_inscribed_circles_overview.md)