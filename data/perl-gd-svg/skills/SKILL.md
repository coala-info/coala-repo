---
name: perl-gd-svg
description: This Perl module enables the generation of SVG files by wrapping the GD library and translating its method calls into vector graphics. Use when user asks to generate SVG output from existing GD scripts, convert raster graphics to scalable vector formats, or create high-quality data visualizations in Perl.
homepage: http://metacpan.org/pod/GD::SVG
---


# perl-gd-svg

## Overview
The `perl-gd-svg` module (GD::SVG) acts as a wrapper for the standard Perl GD library. It allows developers to generate SVG files by making minimal changes to existing code that uses `GD::Image`. Instead of pixel-based rendering, it translates GD method calls into SVG elements via the `SVG.pm` backend. This is particularly useful for bioinformatics and data visualization tasks where scalable, high-quality output is required from existing Perl infrastructure.

## Usage Guidelines

### Basic Conversion
To convert a script from GD to SVG output, replace the class constructors:

1.  **Change the module import**:
    Replace `use GD;` with `use GD::SVG;`.
2.  **Update the Image constructor**:
    Replace `GD::Image->new($width, $height)` with `GD::SVG::Image->new($width, $height)`.
3.  **Update the Font constructor**:
    Replace `GD::Font->...` calls with `GD::SVG::Font->...`.
4.  **Change the output method**:
    Replace `$img->png` or `$img->jpeg` with `$img->svg`.

### Dynamic Output Selection
If you need to support both raster and vector output based on user input or environment, use an `eval` block to load the package dynamically:

```perl
my $package = $use_svg ? 'GD::SVG' : 'GD';
eval "use $package";

my $image_pkg = "${package}::Image";
my $font_pkg  = "${package}::Font";

my $img = $image_pkg->new(800, 600);
# ... drawing commands ...

my $output = $use_svg ? $img->svg : $img->png;
```

### Supported and Unsupported Features
*   **Polygons**: `GD::Polygon` and `GD::Polyline` work with `GD::SVG` without modification.
*   **Colors**: Standard color allocation (`colorAllocate`) works as expected.
*   **Text**: Font heights and widths are defined explicitly in SVG; some manual tweaking of text positioning may be required compared to GD's pixel-perfect rendering.
*   **Unsupported**: Flood fill methods (`fill()` and `fillToBorder()`) are not supported because SVG is not canvas-aware in the same way as a raster buffer.
*   **Unsupported**: `getPixel()` and `newFrom...` (loading from existing files) methods are currently unavailable.

### Best Practices
*   **Unique IDs**: SVG elements require unique IDs. While `GD::SVG` generates these automatically, you can pass an optional `id` parameter to most drawing methods for better DOM organization.
*   **Performance**: Since this is an "API-to-API" wrapper, it is slower than calling `SVG.pm` directly. Use it for convenience and migration rather than high-performance real-time rendering.
*   **Debugging**: If output is unexpected, ensure you are not using "Special Colors" like `gdTiled` or complex brushes, as these have limited support.

## Reference documentation
- [GD::SVG - Seamlessly enable SVG output from scripts written using GD](./references/metacpan_org_pod_GD__SVG.md)
- [perl-gd-svg - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-gd-svg_overview.md)