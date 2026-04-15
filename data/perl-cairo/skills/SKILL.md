---
name: perl-cairo
description: This tool provides a Perl interface to the Cairo 2D graphics library for device-independent vector drawing. Use when user asks to render graphics to image buffers, create PDF or SVG files, draw vector paths, or handle typography within Perl scripts.
homepage: http://gtk2-perl.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/perl-cairo:1.109--pl5321hb0b1468_2"
---

# perl-cairo

## Overview
The `perl-cairo` skill provides a Perlish interface to the powerful Cairo 2D graphics library. It allows for device-independent drawing, meaning the same code can be used to render graphics to various targets like image buffers or vector files. This skill is essential for Perl developers building GUI applications (often alongside Gtk2/Gtk3) or standalone scripts that require precise control over vector paths, gradients, and typography.

## Core Usage Patterns

### Basic Drawing Workflow
To use Cairo in Perl, you typically follow these steps:
1. Create a **Surface** (the target, e.g., Image, PDF, or SVG).
2. Create a **Context** (`Cairo::Context`) which holds the state of the drawing.
3. Set drawing attributes (source color, line width, etc.).
4. Define a **Path** (lines, arcs, rectangles).
5. **Stroke** (outline) or **Fill** the path.

### Common Code Snippets

**Creating a PNG Image:**
```perl
use Cairo;

my $surface = Cairo::ImageSurface->create('argb32', 100, 100);
my $cr = Cairo::Context->create($surface);

$cr->set_source_rgb(0, 0, 0); # Black
$cr->rectangle(10, 10, 80, 80);
$cr->stroke;

$surface->write_to_png('output.png');
```

**Rendering Text:**
```perl
$cr->select_font_face("Sans", 'normal', 'bold');
$cr->set_font_size(20);
$cr->move_to(10, 50);
$cr->show_text("Hello Cairo");
```

**Creating a PDF:**
```perl
my $surface = Cairo::PdfSurface->create("output.pdf", 595, 842); # A4 size in points
my $cr = Cairo::Context->create($surface);
# ... drawing commands ...
$cr->show_page;
```

## Best Practices
- **Coordinate System**: Cairo uses a floating-point coordinate system. The default origin (0,0) is at the top-left. Use `$cr->translate`, `$cr->scale`, and `$cr->rotate` to manipulate the user space rather than calculating complex coordinates manually.
- **State Management**: Use `$cr->save` and `$cr->restore` to push and pop the current drawing state (color, transformation matrix, etc.). This is critical for modular drawing functions.
- **Memory Management**: While Perl handles most garbage collection, ensure surfaces are finished correctly when writing to files (especially for PDF/SVG) by letting the surface object go out of scope or using explicit finish methods if available in the specific binding version.
- **Integration**: When using with Gtk3, you will often receive a Cairo context during a "draw" signal. Do not create a new surface in these cases; use the provided context to draw directly to the widget.

## Reference documentation
- [Cairo (MetaCPAN)](./references/gtk2-perl_sourceforge_net_index.md)
- [Bioconda perl-cairo Overview](./references/anaconda_org_channels_bioconda_packages_perl-cairo_overview.md)