---
name: perl-gd
description: The perl-gd tool provides a Perl interface to the GD graphics library for programmatically creating and manipulating images. Use when user asks to create dynamic graphs, draw geometric shapes, render text on images, or process image files like PNG and JPEG.
homepage: http://metacpan.org/pod/GD
metadata:
  docker_image: "quay.io/biocontainers/perl-gd:2.84--pl5321hc25ab4d_0"
---

# perl-gd

## Overview
The `perl-gd` skill provides a specialized interface for the GD graphics library, enabling programmatic image creation and editing. This tool is essential for workflows requiring dynamic image generation, such as web-based graphing, automated report visualization, or batch processing of image assets. It supports a wide range of operations including primitive drawing (lines, polygons, arcs), color management (including alpha channels), and text rendering using both built-in and TrueType fonts.

## Core Usage Patterns

### Basic Image Initialization
Always start by creating a `GD::Image` object. For new images, specify dimensions; for existing images, use the appropriate constructor.

```perl
use GD;

# Create a new truecolor image (recommended for better quality)
my $img = GD::Image->newTrueColor(400, 300);

# Load an existing image
my $png_img = GD::Image->newFromPng('input.png');
my $jpg_img = GD::Image->newFromJpeg('input.jpg');
```

### Color Management
In palette-based images, the first color allocated becomes the background. In truecolor images, you must explicitly fill the background.

```perl
# Allocate colors
my $white = $img->colorAllocate(255, 255, 255);
my $black = $img->colorAllocate(0, 0, 0);
my $red   = $img->colorAllocateAlpha(255, 0, 0, 64); # Semi-transparent red

# Fill background for truecolor
$img->fill(0, 0, $white);
```

### Drawing and Text
*   **Anti-aliasing**: Use `$img->setAntiAliased($color)` to improve line quality.
*   **Brushes**: Use `$img->setBrush($brush_img)` to draw with patterns.
*   **Fonts**: Prefer `stringFT` (FreeType) for high-quality text over the basic `string` method.

```perl
# Draw a line
$img->line(10, 10, 100, 100, $black);

# Draw a filled rectangle
$img->filledRectangle(20, 20, 80, 80, $red);

# Render high-quality text
$img->stringFT($black, "/path/to/font.ttf", 12, 0, 50, 50, "Hello World");
```

### Image Output
Ensure the filehandle is in binary mode before outputting image data to prevent corruption on certain platforms.

```perl
binmode STDOUT;
print $img->png;

# Or save to a file
open my $out, '>', 'output.png' or die $!;
binmode $out;
print $out $img->png;
close $out;
```

## Expert Tips
*   **TrueColor vs. Palette**: Always use `newTrueColor` for modern applications to avoid color allocation limits and to support alpha blending properly.
*   **Memory Management**: GD images can be memory-intensive. If processing large batches, ensure image objects go out of scope or are explicitly undefined to trigger garbage collection.
*   **Interpolation**: When resizing images, use `$img->copyResampled()` instead of `copyResized()` for significantly better visual results through bilinear interpolation.
*   **Alpha Blending**: Use `$img->alphaBlending(1)` to enable transparency effects when drawing over existing pixels.

## Reference documentation
- [GD - Interface to Gd Graphics Library](./references/metacpan_org_pod_GD.md)
- [perl-gd - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-gd_overview.md)