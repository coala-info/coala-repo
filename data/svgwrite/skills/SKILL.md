---
name: svgwrite
description: "svgwrite is a pure-Python library for creating SVG documents through an object-oriented interface. Use when user asks to generate vector graphics, create SVG files programmatically, or draw shapes and text using Python."
homepage: https://github.com/mozman/svgwrite
---


# svgwrite

## Overview

`svgwrite` is a lightweight, pure-Python library designed for the creation of SVG documents. It provides an object-oriented interface to build SVG files by adding elements like shapes, text, and paths to a drawing object. It is a "write-only" tool, meaning it is optimized for generating new files rather than parsing or modifying existing ones. It is particularly useful in environments where you need to generate vector graphics dynamically without relying on heavy graphics engines or external C-libraries.

## Usage Instructions

### Basic Workflow
The standard workflow involves initializing a drawing object, adding elements to it, and then saving the file.

```python
import svgwrite

# 1. Create the drawing
# Profiles: 'tiny' (basic) or 'full' (advanced features)
dwg = svgwrite.Drawing('output.svg', profile='tiny', size=('200px', '200px'))

# 2. Add elements
# Coordinates are (x, y)
dwg.add(dwg.line((0, 0), (100, 100), stroke=svgwrite.rgb(10, 10, 16, '%')))
dwg.add(dwg.text('Hello SVG', insert=(10, 20), fill='red'))

# 3. Save the file
dwg.save()
```

### Common Elements and Styling
*   **Shapes**: Use methods like `dwg.rect()`, `dwg.circle()`, `dwg.ellipse()`, `dwg.polyline()`, and `dwg.polygon()`.
*   **Styling**: Most elements accept keyword arguments for SVG attributes such as `stroke`, `fill`, `stroke_width`, `opacity`, and `transform`.
*   **Colors**: Colors can be defined as standard CSS strings (e.g., `'red'`, `'#FF0000'`) or using the `svgwrite.rgb()` helper for percentage or integer-based RGB values.

### Grouping and Organization
Use the Group element (`dwg.g()`) to apply styles or transformations to multiple elements at once.

```python
group = dwg.g(stroke='blue', stroke_width=2)
group.add(dwg.line((0, 0), (50, 50)))
group.add(dwg.circle(center=(25, 25), r=10))
dwg.add(group)
```

## Expert Tips and Best Practices

*   **Profile Selection**: Use `profile='tiny'` for maximum compatibility with mobile devices and basic SVG viewers. Use `profile='full'` if you require advanced features like gradients, filters, or clipping paths.
*   **Coordinate Systems**: Remember that SVG coordinates start at (0,0) in the top-left corner. Use the `viewBox` attribute in the `Drawing` constructor to create responsive graphics that scale to their container.
*   **Units**: While pixels are the default, you can specify units explicitly (e.g., `'10cm'`, `'5mm'`, `'2in'`) by passing them as strings.
*   **Embedding Images**: Since `svgwrite` cannot import existing SVG paths directly into the DOM, use the `<image>` entity if you need to include external raster or vector assets within your generated file.
*   **Performance**: For complex paths with thousands of points, use the `svgwrite.path.Path` object and its path commands (`M` for move, `L` for line, etc.) rather than creating thousands of individual line objects.

## Reference documentation
- [svgwrite Abstract and Examples](./references/github_com_mozman_svgwrite.md)
- [Known Issues and Limitations](./references/github_com_mozman_svgwrite_issues.md)