---
name: perl-font-ttf
description: The `Font::TTF` library provides a comprehensive Perl interface for interacting with the internal structures of TrueType and OpenType fonts.
homepage: http://metacpan.org/pod/Font-TTF
---

# perl-font-ttf

## Overview
The `Font::TTF` library provides a comprehensive Perl interface for interacting with the internal structures of TrueType and OpenType fonts. Unlike high-level rendering libraries, this tool allows for direct manipulation of font tables (such as `head`, `name`, `cmap`, and `glyf`). It is ideal for developers needing to automate font auditing, perform batch metadata updates, or programmatically alter font behavior at the binary level.

## Core Usage Patterns

### Basic Script Template
To use the library, initialize a font object and read the file:
```perl
use Font::TTF::Font;

# Open a font file
my $f = Font::TTF::Font->open("font.ttf") || die "Unable to read font";

# Read specific tables into memory
$f->{'name'}->read;
$f->{'head'}->read;

# Access data (e.g., Font Revision)
print "Revision: " . $f->{'head'}->{'fontRevision'} . "\n";

# Clean up to save memory
$f->release;
```

### Common Tasks

- **Extracting Metadata**: Access the `name` table to retrieve strings like Copyright, Family Name, or Version.
- **Table Modification**: Change values within a table and call `$f->out($filename)` to save a new version of the font.
- **Glyph Analysis**: Read the `loca` and `glyf` tables to inspect individual glyph outlines or instructions.
- **Optimization**: Use the `XML` support (if `Font::TTF::XML` is present) to dump font contents to a readable format for diffing.

### Best Practices
- **Lazy Loading**: The library does not read all tables by default. Always explicitly call `->read` on the specific table you need (e.g., `$f->{'OS/2'}->read`) to keep memory usage low.
- **Table Dependencies**: Be aware that modifying one table (like `glyf`) often requires updating others (like `loca` or `maxp`). The library handles some checksums and offsets automatically upon output, but structural changes require care.
- **Memory Management**: For large fonts or batch processing, use `$f->release` to break circular references and free memory.

## Reference documentation
- [Font::TTF Documentation](./references/metacpan_org_pod_Font-TTF.md)