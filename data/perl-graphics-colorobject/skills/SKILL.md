---
name: perl-graphics-colorobject
description: This skill provides procedural knowledge for using the `Graphics::ColorObject` Perl library to perform accurate color conversions.
homepage: http://metacpan.org/pod/Graphics::ColorObject
---

# perl-graphics-colorobject

## Overview
This skill provides procedural knowledge for using the `Graphics::ColorObject` Perl library to perform accurate color conversions. While not optimized for high-speed image processing, it excels at completeness and precision. It supports a wide array of color models including luminance-chrominance spaces (YUV, YIQ, YCbCr) and perceptually uniform spaces (Lab, Luv). Use this when you need to transform color data between formats or adjust colors based on specific illuminants (white points).

## Core Usage Patterns

### Basic Color Conversion
To convert a color, create a new color object from a source space and export it to the target space. Data is typically handled as array references.

```perl
use Graphics::ColorObject;

# Convert RGB (0-1 range) to HSV
my $color = Graphics::ColorObject->new_RGB([0.5, 0.2, 0.9]);
my ($h, $s, $v) = @{ $color->as_HSV() };

# Convert Hex to CMYK
my $color_hex = Graphics::ColorObject->new_RGBhex("FF5733");
my ($c, $m, $y, $k) = @{ $color_hex->as_CMYK() };
```

### Working with RGB Spaces and White Points
The library defaults to sRGB and the D65 white point. You can specify alternatives during object creation or via setters.

```perl
# Create a color in the Adobe RGB space with a specific white point
my $color = Graphics::ColorObject->new_RGB([0.1, 0.8, 0.3], space => 'Adobe', white_point => 'D50');

# Change the white point (supports standard names or temperatures like "6500K")
$color->set_white_point("D65");

# Change the RGB working space
$color->set_rgb_space("NTSC");
```

### Handling Gamut and Clipping
Conversions may return values outside the standard range (e.g., R > 1.0) to maintain mathematical losslessness. Use the `clip` parameter to force values into the valid gamut.

```perl
# Get clipped RGB values (0 to 1 range)
my $rgb = $color->as_RGB(clip => 1);

# For 0-255 integer ranges, use the RGB255 methods
my ($r255, $g255, $b255) = @{ $color->as_RGB255() };
```

### Color Difference and Comparison
Measure the perceptual difference between two colors or check for equality within a specific tolerance.

```perl
my $color1 = Graphics::ColorObject->new_RGBhex("FFFFFF");
my $color2 = Graphics::ColorObject->new_RGBhex("F0F0F0");

# Perceptually uniform difference
my $delta = $color1->difference($color2);

# Equality check with optional accuracy (default 0.01%)
if ($color1->equals($color2, 0.05)) {
    print "Colors are effectively the same";
}
```

## Expert Tips
- **Angles**: All hue (H) values in HSL, HSV, LCHab, and LCHuv are expressed in degrees (0-360).
- **YUV Confusion**: Note that in this module, `YUV` refers to the analog PAL TV signal. For digital video/JPEG-style conversions, use `YCbCr`.
- **White Point Adaptation**: Changing the white point via `set_white_point` is not completely reversible due to the nature of the adaptation algorithms; it is better to set the correct white point at instantiation if possible.
- **Discovery**: Use `Graphics::ColorObject->list_colorspaces()`, `list_rgb_spaces()`, and `list_white_points()` to programmatically retrieve supported identifiers.

## Reference documentation
- [Graphics::ColorObject - convert between color spaces](./references/metacpan_org_pod_Graphics__ColorObject.md)