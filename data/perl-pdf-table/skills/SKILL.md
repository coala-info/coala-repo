---
name: perl-pdf-table
description: This tool implements table layouts in PDF documents using the PDF::Table Perl module to manage cell dimensions, styling, and pagination. Use when user asks to create tables in PDFs, convert 2D data arrays into visual reports, or automate multi-page table generation with dynamic page breaks.
homepage: http://metacpan.org/pod/PDF::Table
metadata:
  docker_image: "quay.io/biocontainers/perl-pdf-table:1.007--pl5321hdfd78af_0"
---

# perl-pdf-table

## Overview
This skill provides the procedural knowledge required to implement table layouts in PDF documents using the PDF::Table Perl module. It simplifies the process of converting 2D data arrays into visual tables by managing cell dimensions, font styles, background colors, and complex pagination logic. Use this skill to automate report generation where data volume is unpredictable and requires dynamic page breaks.

## Installation and Setup
Install the package via Bioconda to ensure all Perl dependencies are met:
```bash
conda install bioconda::perl-pdf-table
```

## Core Implementation Pattern
To render a table, you must provide a 2D array reference and define the bounding box for the first page and subsequent pages.

1.  **Initialize the objects**: Create a `PDF::Builder` (or `PDF::API2`) instance and a `PDF::Table` instance.
2.  **Prepare data**: Format your content as an array of arrays (e.g., `[ ['Header1', 'Header2'], ['Row1Col1', 'Row1Col2'] ]`).
3.  **Invoke the table method**: Pass the PDF object, the current page object, and the data array with configuration hashes.

## Key Parameters and Best Practices
- **Geometry**: Use `x` and `y` for the top-left starting position. Use `w` and `h` to define the table's footprint on the current page.
- **Pagination**: Always define `next_y` and `next_h`. These settings tell the module where to start the table on the new pages it creates automatically when data overflows.
- **Cell Padding**: The default padding is 2pt (in version 1.000+). Adjust this using the `padding` parameter for tighter or looser layouts.
- **Zebra Striping**: Enhance readability by setting `bg_color_odd` and `bg_color_even`.
- **Word Wrapping**: If cells contain long strings without spaces, use `max_word_length` to force a split and prevent the table from breaking the page margins.

## Expert Tips
- **Header Persistence**: By default, headers repeat on every new page. If this is not desired, explicitly set `repeat => 0` in the header properties.
- **Compatibility Mode**: If working with legacy scripts that expect 0pt padding or different odd/even row logic, use the `compatibility` flag:
  - `compatibility => [0, 0, 0]` restores all legacy behaviors (Header repeat, Odd/Even logic, Padding).
- **Return Values**: The `table()` method returns a list containing the page object where the table ended, the number of rows processed, and the final Y-coordinate. Use these to continue adding content (like footers) after the table.

## Common Perl One-Liner for Testing
To verify the installation and basic rendering capability:
```bash
perl -MPDF::Builder -MPDF::Table -e '$p=PDF::Builder->new(-file=>"test.pdf"); $t=PDF::Table->new(); $t->table($p, $p->page(), [["A","B"],["1","2"]], x=>50, w=>500, y=>700, h=>500); $p->save()'
```

## Reference documentation
- [PDF::Table - MetaCPAN](./references/metacpan_org_pod_PDF__Table.md)
- [perl-pdf-table - Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-pdf-table_overview.md)