---
name: perl-pdf-api2
description: The perl-pdf-api2 tool provides a programmatic interface for creating, modifying, and performing low-level manipulation of PDF documents using Perl. Use when user asks to generate reports or invoices, add text and images to PDFs, draw vector graphics, or merge and import pages between documents.
homepage: http://metacpan.org/pod/PDF::API2
metadata:
  docker_image: "quay.io/biocontainers/perl-pdf-api2:2.043--pl5321hdfd78af_0"
---

# perl-pdf-api2

## Overview
The `perl-pdf-api2` skill provides a specialized interface for handling PDF documents through the PDF::API2 Perl module. Unlike simple converters, this tool allows for low-level manipulation of PDF objects, enabling precise control over page geometry, typography, and vector graphics. Use this skill to automate the generation of reports, invoices, or complex document assemblies where standard office tools are insufficient.

## Core Usage Patterns

### Basic Document Structure
Every script begins by initializing the PDF object and adding pages.
```perl
use PDF::API2;

# Create a new PDF
my $pdf = PDF::API2->new();

# Open an existing PDF
my $pdf_existing = PDF::API2->open('input.pdf');

# Add a page (default is A4)
my $page = $pdf->page();
$page->size('Letter');

# Save the result
$pdf->save('output.pdf');
```

### Working with Text
To add text, you must define a font and use a text content object.
```perl
my $font = $pdf->font('Helvetica-Bold');
my $text = $page->text();

$text->font($font, 12);
$text->translate(72, 720); # Coordinates in points (1/72 inch) from bottom-left
$text->text('Hello World');
```

### Graphics and Images
Graphics are handled via the `graphics` object.
```perl
my $gfx = $page->graphics();

# Draw a rectangle
$gfx->rectangle(100, 100, 200, 150);
$gfx->stroke();

# Place an image
my $img = $pdf->image('logo.jpg');
$gfx->image($img, 300, 300, 100, 100); # x, y, width, height
```

### Merging and Importing Pages
You can import pages from one PDF into another to merge documents.
```perl
my $old_pdf = PDF::API2->open('source.pdf');
my $new_pdf = PDF::API2->new();

# Import page 1 from source into the new document
my $page = $new_pdf->import_page($old_pdf, 1);
```

## Expert Tips
- **Coordinate System**: PDF::API2 uses the standard PDF coordinate system where (0,0) is the bottom-left corner. Always calculate offsets from the bottom up.
- **Memory Management**: When processing very large PDFs or many files in a loop, call `$pdf->end()` to release memory associated with the object.
- **Font Embedding**: Use TrueType (.ttf) or OpenType (.otf) fonts for better Unicode support and portability. Core fonts (like Helvetica) are not embedded by default to save space but may look different on different viewers.
- **Content Layers**: Text and Graphics objects are layers. If you want text to appear over an image, ensure the text object is created after the graphics object or use `text()` after `graphics()`.

## Reference documentation
- [PDF::API2 - Create, modify, and examine PDF files](./references/metacpan_org_pod_PDF__API2.md)