---
name: perl-postscript-simple
description: The `perl-postscript-simple` skill enables the programmatic creation of PostScript documents.
homepage: https://metacpan.org/pod/PostScript::Simple
---

# perl-postscript-simple

## Overview
The `perl-postscript-simple` skill enables the programmatic creation of PostScript documents. It provides a high-level Perl interface for drawing geometric primitives (lines, boxes, circles, curves, polygons), managing colors (RGB, CMYK, or named colors), and placing text using standard PostScript fonts. It is particularly useful for automated report generation, data visualization, and creating assets for LaTeX or other typesetting systems.

## Core Workflow

### 1. Initialization
Always start by creating a new `PostScript::Simple` object. Define your units and paper size early to ensure consistent scaling.

```perl
use PostScript::Simple;

# Create a standard A4 document in millimeters
my $p = new PostScript::Simple(
    papersize => "A4",
    colour    => 1,
    units     => "mm"
);
```

### 2. Page Management
For standard PostScript files, use `newpage` to start drawing. For EPS files (the default), `newpage` is not required and should generally be avoided.

```perl
$p->newpage; # Starts page 1
# ... drawing commands ...
$p->newpage; # Starts page 2
```

### 3. Drawing Primitives
Coordinates are relative to the origin (default: Bottom-Left).

*   **Lines & Paths:** Use `line(x1, y1, x2, y2)` for single segments. Use `linextend(x, y)` to continue from the last point.
*   **Shapes:** `box(x1, y1, x2, y2)` and `circle(x, y, radius)`.
*   **Curves:** `curve(x1, y1, x2, y2, x3, y3, x4, y4)` uses Bezier points.
*   **Polygons:** Pass an array of coordinates: `$p->polygon(x1, y1, x2, y2, x3, y3, ...)`.

### 4. Styling and Color
*   **Width:** `setlinewidth(width)` sets the stroke thickness in the chosen units.
*   **RGB Color:** `setcolour(r, g, b)` (0-255) or `setcolour("name")` (e.g., "red", "blue").
*   **CMYK Color:** `setcmykcolour(c, m, y, k)` (0.0-1.0) for professional print output.

### 5. Text Handling
Standard PostScript fonts (Helvetica, Times-Roman, Courier) are supported.

```perl
$p->setfont("Helvetica", 12);
$p->text(20, 280, "Document Title");
```

### 6. Output
Finalize the process by writing to a file or capturing the string output.

```perl
$p->output("output.ps");
# OR get as a string
my $ps_data = $p->get;
```

## Expert Tips
*   **Coordinate Systems:** If you prefer a screen-like coordinate system (origin at top-left), initialize with `coordorigin => "LeftTop", direction => "RightDown"`.
*   **EPS for Embedding:** If the goal is to insert the graphic into a LaTeX document, ensure `eps => 1` is set in the constructor (this is the default).
*   **Encoding:** To support accented Western European characters, use `reencode => "ISOLatin1Encoding"` and append `-iso` to your font names (e.g., `Helvetica-iso`).
*   **Landscape Mode:** Use `landscape => 1` to rotate the page 90 degrees; the module automatically adjusts clipping boundaries.

## Reference documentation
- [PostScript::Simple - Produce PostScript files from Perl](./references/metacpan_org_pod_PostScript__Simple.md)