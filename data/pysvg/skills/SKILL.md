---
name: pysvg
description: The pysvg tool enables the programmatic creation, modification, and parsing of Scalable Vector Graphics using a Python-based object model. Use when user asks to generate data visualizations, create algorithmic art, draw geometric shapes, or manipulate existing SVG files.
homepage: http://codeboje.de/pysvg/
metadata:
  docker_image: "quay.io/biocontainers/pysvg:0.2.2--py27_0"
---

# pysvg

## Overview
The `pysvg` skill enables the programmatic creation and modification of Scalable Vector Graphics (SVG) using a Python-based object model. It is particularly useful for generating data visualizations, algorithmic art (like fractals or L-systems), and automated image processing where vector precision is required. It provides a wrapper around SVG elements, allowing you to treat graphic components as Python objects with attributes for styling and transformation.

## Core Usage Patterns

### Basic Document Setup
To create an SVG, initialize an `Svg` container and add elements to it.
```python
from pysvg.structure import Svg
from pysvg.builders import ShapeBuilder

# Initialize document
svg_doc = Svg()
sb = ShapeBuilder()

# Add a simple rectangle
rect = sb.createRect(0, 0, "100px", "100px", fill="blue")
svg_doc.addElement(rect)

# Save to file
svg_doc.save("output.svg")
```

### Working with Shapes and Styles
The `ShapeBuilder` class is the most efficient way to generate standard primitives.
- **Circles/Ellipses**: `sb.createCircle(cx, cy, r, strokewidth, stroke, fill)`
- **Lines**: `sb.createLine(x1, y1, x2, y2, stroke, strokewidth)`
- **Polygons**: Use `sb.createPolygon(points, ...)` where points is a string of coordinates "x1,y1 x2,y2...".

### Complex Paths
For custom shapes, use the `Path` element and its path data commands.
```python
from pysvg.shape import Path

path = Path()
path.appendMoveTo(10, 10)
path.appendLineTo(50, 50, relative=False)
path.appendCubicCurveTo(100, 100, 150, 50, 200, 100)
```

### Transformations and Groups
Group elements using the `G` element to apply collective transformations (rotate, scale, translate).
```python
from pysvg.structure import G

group = G()
group.set_transform("rotate(45, 50, 50)")
group.addElement(rect_object)
svg_doc.addElement(group)
```

### Loading Existing SVGs
You can parse an existing SVG file to manipulate its contents.
```python
import pysvg.parser

svg_obj = pysvg.parser.parse("input.svg")
# Access elements via svg_obj.getElementAt(index)
```

## Expert Tips
- **Coordinate System**: Remember that SVG coordinates start at (0,0) in the top-left corner.
- **Style as Dictionary**: In newer versions of `pysvg`, styles can be managed as dictionaries, making it easier to update specific attributes like `stroke-dasharray` or `opacity` dynamically.
- **Turtle Graphics**: The library includes a turtle graphics module for those familiar with Logo-style drawing, which is excellent for recursive geometric patterns.
- **Validation**: `pysvg` does not strictly validate SVG attribute values or types. Ensure your inputs (colors, units, coordinate strings) conform to SVG standards to avoid broken output files.

## Reference documentation
- [pySVG - Creating SVG with Python](./references/codeboje_de_pysvg.md)