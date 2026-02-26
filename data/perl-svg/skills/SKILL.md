---
name: perl-svg
description: This tool programmatically generates Scalable Vector Graphics (SVG) documents using a Perl-based object-oriented interface. Use when user asks to create vector images, build SVG DOM structures, render shapes and paths, or generate data visualizations in Perl.
homepage: http://metacpan.org/pod/SVG
---


# perl-svg

## Overview
The `perl-svg` skill enables the programmatic generation of SVG documents through the `SVG.pm` Perl module. It provides an object-oriented interface to build a Document Object Model (DOM) of an SVG image, allowing for the creation of shapes, paths, text, and complex filters. This tool is particularly useful for server-side image generation and data visualization tasks where vector output is preferred over raster formats.

## Core Usage Patterns

### Basic Document Structure
To create a new SVG document, initialize the `SVG` object and define the canvas dimensions.

```perl
use SVG;

# Create the SVG object
my $svg = SVG->new(
    width  => 500,
    height => 500,
    xmlns  => 'http://www.w3.org/2000/svg'
);

# Add elements (e.g., a rectangle)
$svg->rectangle(
    x      => 10,
    y      => 10,
    width  => 100,
    height => 100,
    fill   => 'blue'
);

# Render the XML output
print $svg->xmlify;
```

### Common Element Methods
The module supports all standard SVG elements. Use the following methods to add shapes:
- **Shapes**: `circle`, `ellipse`, `rectangle` (alias: `rect`), `line`, `polyline`, `polygon`.
- **Paths**: Use the `path` method with a `d` attribute for complex vector paths.
- **Text**: Use `text` for labels and `title` or `desc` for metadata.
- **Containers**: Use `group` (alias: `g`) to group elements and apply shared attributes like transformations or styles.

### Working with Groups and Attributes
Grouping is the most efficient way to apply styles or transformations to multiple elements.

```perl
my $group = $svg->group(
    id        => 'set_1',
    style     => { 'stroke' => 'black', 'fill' => 'none' },
    transform => 'rotate(-45)'
);

$group->circle(cx => 50, cy => 50, r => 20);
$group->rect(x => 80, y => 80, width => 20, height => 20);
```

### Advanced Features
- **CDATA**: Use `$svg->cdata($content)` to include CSS or JavaScript within the SVG without XML escaping issues.
- **Filters**: Access filter effects using `feGaussianBlur`, `feOffset`, etc., nested within a `filter` element.
- **Custom Tags**: Use the generic `tag()` or `element()` method to generate non-standard or experimental SVG tags.

## Expert Tips and Best Practices
- **Method Aliases**: Use shorter aliases like `rect()` instead of `rectangle()` and `serialize()` instead of `xmlify()` to keep code concise.
- **Style Handling**: Pass styles as a hash reference to the `style` attribute for better readability compared to a concatenated string.
- **Memory Management**: For extremely large SVG files, be mindful that `perl-svg` builds the entire DOM in memory before rendering.
- **Validation**: Always use `xmlify()` as the final step to ensure the output is a well-formed XML document.

## Reference documentation
- [SVG - Perl extension for generating Scalable Vector Graphics (SVG) documents](./references/metacpan_org_pod_SVG.md)
- [perl-svg - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-svg_overview.md)