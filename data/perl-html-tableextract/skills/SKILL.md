---
name: perl-html-tableextract
description: This tool programmatically parses and extracts data from HTML tables while preserving structural integrity like nested tables and cell spans. Use when user asks to extract data from HTML tables by headers, target tables based on depth or attributes, or handle complex table layouts in Perl.
homepage: https://metacpan.org/pod/HTML::TableExtract
metadata:
  docker_image: "quay.io/biocontainers/perl-html-tableextract:2.15--pl5321hdfd78af_0"
---

# perl-html-tableextract

## Overview
This skill provides guidance on using the `HTML::TableExtract` Perl module to programmatically parse and retrieve content from HTML tables. Unlike simple regex-based parsing, this tool understands table structures, including nested tables and cell spans (rowspan/colspan). It allows for targeted extraction based on header text, table depth, or tag attributes, and can return data as raw text or as a manipulatable element tree.

## Core Usage Patterns

### Extraction by Column Headers
The most robust way to extract data is by specifying the headers you expect. The tool automatically maps columns to the order you provide.

```perl
use HTML::TableExtract;

# Define the headers you are looking for
my $te = HTML::TableExtract->new( headers => [qw(Date Price Cost)] );

# Parse the HTML content
$te->parse($html_string);

# Iterate through matching tables and their rows
foreach my $ts ($te->tables) {
    foreach my $row ($ts->rows) {
        # $row is an array reference: [$date, $price, $cost]
        print "Date: $row->[0], Price: $row->[1]\n";
    }
}
```

### Extraction by Table Location (Depth and Count)
Use this when tables lack unique headers but have a consistent structural position.
- `depth`: How nested the table is (0 is top-level).
- `count`: The instance number of the table at that specific depth (starting at 0).

```perl
# Target the 3rd table found at the 2nd level of nesting
my $te = HTML::TableExtract->new( depth => 2, count => 2 );
$te->parse_file("data.html");
```

### Extraction by HTML Attributes
Target tables based on their `<table>` tag properties, such as `id`, `class`, or `border`.

```perl
my $te = HTML::TableExtract->new( attribs => { class => 'data-table', id => 'results' } );
```

## Expert Tips and Best Practices

- **Handling Cell Spans**: By default, `gridmap` is enabled (1), which means the tool treats spanned cells (colspan/rowspan) as multiple cells containing the same value. This ensures your column indexes remain consistent across rows.
- **HTML Stripping**: The tool strips HTML tags from cell content by default to provide clean text. If you need the raw HTML within a cell, set `keep_html => 1` in the constructor.
- **Tree Mode for Manipulation**: If you need to modify the table or extract specific element attributes (like links within a cell), use the `tree` mode. This requires `HTML::ElementTable`.
  ```perl
  use HTML::TableExtract qw(tree);
  my $te = HTML::TableExtract->new( headers => [qw(Name Link)] );
  $te->parse($html);
  my $table = $te->first_table_found;
  my $cell_element = $table->tree->cell(0, 1); # Get HTML::Element for row 0, col 1
  ```
- **Space Management**: Use `br_translate => 1` to convert `<br>` tags into newlines, preventing text from different lines within a cell from running together.
- **Efficiency**: For very large files, `parse_file()` is generally more memory-efficient than reading the entire file into a string and using `parse()`.

## Reference documentation
- [HTML::TableExtract - Metacpan](./references/metacpan_org_pod_HTML__TableExtract.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-html-tableextract_overview.md)