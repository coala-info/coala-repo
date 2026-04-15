---
name: perl-excel-writer-xlsx
description: This tool programmatically generates and formats Excel workbooks in the XLSX format using Perl. Use when user asks to create Excel spreadsheets, apply cell formatting, insert formulas and charts, or optimize the generation of large data reports.
homepage: http://jmcnamara.github.com/excel-writer-xlsx/
metadata:
  docker_image: "quay.io/biocontainers/perl-excel-writer-xlsx:1.15--pl5321hdfd78af_0"
---

# perl-excel-writer-xlsx

## Overview
This skill enables the programmatic generation of Excel workbooks in the modern XLSX format. It is particularly useful for transforming raw data into formatted reports, including support for multiple worksheets, cell formatting (fonts, colors, borders), formulas, and charts. While primarily a Perl library, it is often used in data pipelines to produce human-readable outputs from automated processes.

## Core Usage Patterns

### Basic Workbook Creation
To create a simple spreadsheet, initialize the workbook and add a worksheet:

```perl
use Excel::Writer::XLSX;

# Create a new workbook
my $workbook  = Excel::Writer::XLSX->new( 'report.xlsx' );
my $worksheet = $workbook->add_worksheet();

# Write data
$worksheet->write( 'A1', 'Hello' );
$worksheet->write( 0, 1, 'World' ); # Row/Column notation (0-indexed)

$workbook->close();
```

### Formatting and Styles
Define formats to improve readability. Formats are created via the workbook object and applied during the write process.

```perl
my $header = $workbook->add_format(
    bold  => 1,
    color => 'blue',
    size  => 12,
    align => 'center'
);

$worksheet->write( 0, 0, 'Revenue', $header );
```

### Handling Large Files
For very large datasets, use the `set_optimization()` mode to reduce memory usage by writing data to temporary files during processing.

```perl
my $workbook = Excel::Writer::XLSX->new( 'large_data.xlsx' );
$workbook->set_optimization();
```

## Expert Tips
- **Row/Column vs. A1 Notation**: Use `(row, col)` notation for loops and `A1` notation for static cell references.
- **Formulas**: Write formulas using the `write()` method just like strings; the library automatically detects the leading `=` sign.
- **Dates**: Excel treats dates as numbers. Use `write_date_time()` along with a date format (e.g., `num_format => 'mm/dd/yy'`) to ensure they display correctly.
- **Performance**: If generating files in a web environment, you can write to `STDOUT` by passing `\*STDOUT` to the constructor.

## Reference documentation
- [perl-excel-writer-xlsx Overview](./references/anaconda_org_channels_bioconda_packages_perl-excel-writer-xlsx_overview.md)