---
name: perl-graphics-colornames
description: This tool manages and retrieves RGB color definitions using human-readable names within Perl applications. Use when user asks to convert color names to hexadecimal strings, retrieve RGB decimal values, or load standard color schemes like X11 and HTML.
homepage: http://metacpan.org/pod/Graphics::ColorNames
metadata:
  docker_image: "quay.io/biocontainers/perl-graphics-colornames:2.11--pl526_0"
---

# perl-graphics-colornames

## Overview
This skill provides guidance on using the `Graphics::ColorNames` Perl module to manage and retrieve color definitions. It allows developers to abstract RGB values behind human-readable names, supporting multiple standard color palettes. Use this to ensure color name parity across different environments and to simplify the hardcoding of hexadecimal color codes in Perl-based reporting or graphics tools.

## Implementation Patterns

### Basic RGB Retrieval
To convert a color name to its hex representation, initialize the object with a specific color scheme (e.g., 'X11', 'HTML', 'Netscape').

```perl
use Graphics::ColorNames;

# Initialize with a specific scheme
my $colors = Graphics::ColorNames->new('X11');

# Fetch RGB values as a hex string
my $hex_rgb = $colors->hex('steelblue'); # Returns '4682b4'

# Fetch as a list of decimal values (0-255)
my @rgb = $colors->rgb('maroon'); # Returns (128, 0, 0)
```

### Handling Multiple Schemes
You can load multiple schemes simultaneously or point to custom color definition files.

```perl
# Load multiple standard schemes
my $colors = Graphics::ColorNames->new('HTML', 'Windows');

# Load from a custom file (format: Name \t Hex)
my $custom = Graphics::ColorNames->new('/path/to/my_colors.txt');
```

### Best Practices
- **Case Sensitivity**: By default, color names are case-insensitive.
- **Error Handling**: Always check if a color exists in the loaded scheme before processing to avoid undefined values.
  ```perl
  if (exists $colors->{firebrick}) { ... }
  ```
- **Scheme Selection**: 
    - Use `HTML` for web-safe colors.
    - Use `X11` for a more extensive list of traditional Unix color names.
    - Use `Netscape` for legacy browser compatibility.

## Reference documentation
- [Graphics::ColorNames Documentation](./references/metacpan_org_pod_Graphics__ColorNames.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-graphics-colornames_overview.md)