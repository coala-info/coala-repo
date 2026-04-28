Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[csvkit 2.2.0 documentation](../index.html)

[csvkit 2.2.0 documentation](../index.html)

* [Tutorial](../tutorial.html)[ ]
* [Reference](../cli.html)[x]
* [Tips and Troubleshooting](../tricks.html)
* [Contributing to csvkit](../contributing.html)
* [Release process](../release.html)
* [License](../license.html)
* [Changelog](../changelog.html)

Back to top

[View this page](../_sources/scripts/in2csv.rst.txt "View this page")

# in2csv[¶](#in2csv "Link to this heading")

## Description[¶](#description "Link to this heading")

Converts various tabular data formats into CSV.

Converting fixed width requires that you provide a schema file with the “-s” option. The schema file should have the following format:

```
column,start,length
name,0,30
birthday,30,10
age,40,3
```

The header line is required though the columns may be in any order:

```
usage: in2csv [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3}] [-b]
              [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
              [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
              [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
              [-H] [-K SKIP_LINES] [-v] [-l] [--zero] [-V]
              [-f {csv,dbf,fixed,geojson,json,ndjson,xls,xlsx}] [-s SCHEMA]
              [-k KEY] [-n] [--sheet SHEET] [--write-sheets WRITE_SHEETS]
              [--use-sheet-names] [--reset-dimensions]
              [--encoding-xls ENCODING_XLS] [-y SNIFF_LIMIT] [-I]
              [FILE]

Convert common, but less awesome, tabular data formats to CSV.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

optional arguments:
  -h, --help            show this help message and exit
  -f {csv,dbf,fixed,geojson,json,ndjson,xls,xlsx}, --format {csv,dbf,fixed,geojson,json,ndjson,xls,xlsx}
                        The format of the input file. If not specified will be
                        inferred from the file type.
  -s SCHEMA, --schema SCHEMA
                        Specify a CSV-formatted schema file for converting
                        fixed-width files. See web documentation.
  -k KEY, --key KEY     Specify a top-level key to look within for a list of
                        objects to be converted when processing JSON.
  -n, --names           Display sheet names from the input Excel file.
  --sheet SHEET         The name of the Excel sheet to operate on.
  --write-sheets WRITE_SHEETS
                        The names of the Excel sheets to write to files, or
                        "-" to write all sheets.
  --use-sheet-names     Use the sheet names as file names when --write-sheets
                        is set.
  --reset-dimensions    Ignore the sheet dimensions provided by the XLSX file.
  --encoding-xls ENCODING_XLS
                        Specify the encoding of the input XLS file.
  -y SNIFF_LIMIT, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        CSV input.

 Some command-line flags only pertain to specific input formats.
```

See also: [Arguments common to all tools](../common_arguments.html).

Note

The “ndjson” format refers to “newline delimited JSON”, as used by many streaming APIs.

Note

If an XLS looks identical to an XLSX when viewed in Excel, they may not be identical as CSV. For example, XLSX has an integer type, but XLS doesn’t. Numbers that look like integers from an XLS will have decimals in CSV, but those from an XLSX won’t.

Note

To convert from HTML, consider [messytables](https://messytables.readthedocs.io/).

## Examples[¶](#examples "Link to this heading")

Convert the 2000 census geo headers file from fixed-width to CSV and from latin-1 encoding to utf8:

```
in2csv -e iso-8859-1 -f fixed -s examples/realdata/census_2000/census2000_geo_schema.csv examples/realdata/census_2000/usgeo_excerpt.upl
```

Note

A library of fixed-width schemas is maintained in the `ffs` project:

<https://github.com/wireservice/ffs>

Convert an Excel .xls file:

```
in2csv examples/test.xls
```

Standardize the formatting of a CSV file (quoting, line endings, etc.):

```
in2csv examples/realdata/FY09_EDU_Recipients_by_State.csv
```

Fetch csvkit’s open issues from the GitHub API, convert the JSON response into a CSV and write it to a file:

```
curl https://api.github.com/repos/wireservice/csvkit/issues?state=open | in2csv -f json -v
```

Convert a DBase DBF file to an equivalent CSV:

```
in2csv examples/testdbf.dbf
```

This tool names unnamed headers. To avoid that behavior, run:

```
in2csv --no-header-row examples/test.xlsx | tail -n +2
```

## Troubleshooting[¶](#troubleshooting "Link to this heading")

If an error like the following occurs when providing an input file in CSV or Excel format:

```
ValueError: Row 0 has 11 values, but Table only has 1 columns.
```

Then the input file might have initial rows before the header and data rows. You can skip such rows with `--skip-lines` (`-K`):

```
in2csv --skip-lines 3 examples/test_skip_lines.csv
```

If an XLSX file yields too few rows or too few columns, then the application that created the file might have [incorrectly set the worksheet’s dimensions](https://openpyxl.readthedocs.io/en/stable/optimized.html#worksheet-dimensions). Try again with the `--reset-dimensions` option.

[Next

sql2csv](sql2csv.html)
[Previous

Reference](../cli.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* in2csv
  + [Description](#description)
  + [Examples](#examples)
  + [Troubleshooting](#troubleshooting)