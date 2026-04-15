---
name: perl-spreadsheet-parseexcel
description: This tool reads and extracts data from legacy Excel binary files in the .xls format. Use when user asks to parse Excel BIFF files, extract cell values from spreadsheets, or convert .xls data into machine-readable formats.
homepage: http://github.com/runrig/spreadsheet-parseexcel/
metadata:
  docker_image: "quay.io/biocontainers/perl-spreadsheet-parseexcel:0.66--pl5321hdfd78af_0"
---

# perl-spreadsheet-parseexcel

## Overview
The `perl-spreadsheet-parseexcel` skill provides the procedural knowledge required to read and process older Excel binary formats (BIFF). While modern Excel files (.xlsx) use XML, many legacy systems still produce or store data in the .xls format. This tool allows for the programmatic extraction of cell values, formatting information, and worksheet metadata. It is primarily used by writing short Perl scripts or one-liners to convert spreadsheet data into machine-readable formats like CSV or JSON.

## Installation
The package is available via Bioconda or CPAN:

```bash
# Via Conda
conda install bioconda::perl-spreadsheet-parseexcel

# Via CPAN
cpan Spreadsheet::ParseExcel
```

## Core Usage Pattern
To use this tool, you typically create a Perl script. The following is the standard pattern for iterating through a workbook:

```perl
use Spreadsheet::ParseExcel;

my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->parse('file.xls');

if ( !defined $workbook ) {
    die $parser->error(), ".\n";
}

for my $worksheet ( $workbook->worksheets() ) {
    my ( $row_min, $row_max ) = $worksheet->row_range();
    my ( $col_min, $col_max ) = $worksheet->col_range();

    for my $row ( $row_min .. $row_max ) {
        for my $col ( $col_min .. $col_max ) {
            my $cell = $worksheet->get_cell( $row, $col );
            next unless $cell;
            print "Row, Col    = ($row, $col)\n";
            print "Value       = ", $cell->value(),       "\n";
            print "Unformatted = ", $cell->unformatted(), "\n";
        }
    }
}
```

## Expert Tips and Best Practices
- **Cell Existence**: Always use `next unless $cell;` when iterating. `Spreadsheet::ParseExcel` does not create cell objects for empty cells unless they have formatting applied.
- **Date Handling**: Excel stores dates as integers. Use the `value()` method to get the formatted date string, or `unformatted()` to get the raw Excel numeric value for manual calculation.
- **Encoding**: If dealing with non-ASCII characters (e.g., Japanese text), ensure you have `Unicode::Map` or `Jcode.pm` installed as required by the `FmtJapan` or `FmtUnicode` modules.
- **Memory Management**: For extremely large files, be aware that this module parses the entire workbook into memory. If memory is a constraint, consider pre-processing or splitting the file if possible.
- **Format Support**: This tool is strictly for binary `.xls` files. For `.xlsx` (OpenXML), use `Spreadsheet::ParseXLSX` instead.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-spreadsheet-parseexcel_overview.md)
- [GitHub Repository README](./references/github_com_runrig_spreadsheet-parseexcel.md)