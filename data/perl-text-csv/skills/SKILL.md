---
name: perl-text-csv
description: This tool provides a robust interface for parsing, generating, and manipulating CSV data within Perl scripts. Use when user asks to parse CSV files with complex formatting, convert data between arrays and CSV strings, or handle multi-line fields and quoted separators in Perl.
homepage: http://metacpan.org/pod/Text::CSV
metadata:
  docker_image: "quay.io/biocontainers/perl-text-csv:2.01--pl5321hdfd78af_0"
---

# perl-text-csv

## Overview
The `perl-text-csv` skill provides a robust interface for manipulating CSV data within Perl scripts. It acts as a wrapper that automatically selects the fastest available backend (either the high-performance C-based `Text::CSV_XS` or the pure-Perl `Text::CSV_PP`). This tool is essential when standard string splitting is insufficient, such as when fields contain quoted separators or multi-line content.

## Core Usage Patterns

### Functional Interface (Quick Tasks)
For simple file-wide operations, use the exported `csv` function.

```perl
use Text::CSV qw( csv );

# Read a CSV file into an array of hashes (uses first line as keys)
my $data = csv(in => "input.csv", headers => "auto");

# Filter and write specific rows to a new file
csv(
    in      => "input.csv",
    out     => "filtered.csv",
    headers => "auto",
    filter  => { status => sub { $_ eq 'active' } }
);
```

### Object-Oriented Interface (Granular Control)
Use the OO interface for large files or complex row-by-row processing to save memory.

```perl
use Text::CSV;

# Always use binary => 1 for modern CSV (handles UTF-8 and newlines)
my $csv = Text::CSV->new({ 
    binary    => 1, 
    auto_diag => 1,
    sep_char  => ',' 
});

open my $fh, "<:encoding(utf8)", "data.csv" or die $!;

# Efficient row-by-row reading
while (my $row = $csv->getline($fh)) {
    # $row is an array reference
    print "Column 1: " . $row->[0] . "\n";
}
close $fh;
```

## Expert Tips and Best Practices

- **The Binary Flag**: Always set `binary => 1` in the constructor. Without it, the parser will fail on any character above 0x7E (including most non-ASCII characters and embedded newlines).
- **Error Handling**: Use `auto_diag => 1` or `auto_diag => 2` during development. This causes the module to print detailed error messages to STDERR automatically if a line fails to parse.
- **Backend Selection**: If you need to ensure a specific backend (e.g., for environment consistency), set the environment variable `PERL_TEXT_CSV` to `Text::CSV_PP` or `Text::CSV_XS` before loading the module.
- **Handling Headers**: When using `getline_hr`, you must first define column names using `$csv->header($fh)` or `$csv->column_names(@names)`.
- **Performance**: For massive datasets, ensure `Text::CSV_XS` is installed in the environment. `Text::CSV` will detect and use it automatically for a significant speed boost over the pure-Perl version.

## Reference documentation
- [Text::CSV - comma-separated values manipulator](./references/metacpan_org_pod_Text__CSV.md)
- [perl-text-csv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-text-csv_overview.md)