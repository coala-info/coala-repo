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

[View this page](../_sources/scripts/csvlook.rst.txt "View this page")

# csvlook[¶](#csvlook "Link to this heading")

## Description[¶](#description "Link to this heading")

Renders a CSV to the command line in a Markdown-compatible, fixed-width format:

```
usage: csvlook [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3}] [-b]
               [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
               [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
               [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
               [-H] [-K SKIP_LINES] [-v] [-l] [--zero] [-V]
               [--max-rows MAX_ROWS] [--max-columns MAX_COLUMNS]
               [--max-column-width MAX_COLUMN_WIDTH]
               [--max-precision MAX_PRECISION] [--no-number-ellipsis]
               [-y SNIFF_LIMIT] [-I]
               [FILE]

Render a CSV file in the console as a Markdown-compatible, fixed-width table.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

optional arguments:
  -h, --help            show this help message and exit
  --max-rows MAX_ROWS   The maximum number of rows to display before
                        truncating the data.
  --max-columns MAX_COLUMNS
                        The maximum number of columns to display before
                        truncating the data.
  --max-column-width MAX_COLUMN_WIDTH
                        Truncate all columns to at most this width. The
                        remainder will be replaced with ellipsis.
  --max-precision MAX_PRECISION
                        The maximum number of decimal places to display. The
                        remainder will be replaced with ellipsis.
  --no-number-ellipsis  Disable the ellipsis if --max-precision is exceeded.
  -y SNIFF_LIMIT, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.
```

If a table is too wide to display properly try piping the output to `less -S` or truncating it using [csvcut](csvcut.html).

If the table is too long, try filtering it down with grep or piping the output to `less`.

See also: [Arguments common to all tools](../common_arguments.html).

Note

The fractional part of a decimal numberal is always truncated. To control this truncation, use `--no-inference` along with `--max-column-width`.

## Examples[¶](#examples "Link to this heading")

Basic use:

```
csvlook examples/testfixed_converted.csv
```

This tool is especially useful as a final operation when piping through other tools:

```
csvcut -c 9,1 examples/realdata/FY09_EDU_Recipients_by_State.csv | csvlook
```

If a data row contains more cells than the header row, csvlook will error. Use [csvclean](csvclean.html) to remove such rows.

To ignore the extra cells, instead:

```
csvcut -C "" examples/bad.csv | csvlook
```

If these rows are at the top of the file (for example, copyright notices), you can skip the rows:

```
csvlook --skip-lines 1 examples/bad.csv
```

This error can also occur if csvlook incorrectly deduces (“sniffs”) the CSV format. To disable CSV sniffing, set `--snifflimit 0` and then, if necessary, set the `--delimiter` and `--quotechar` options yourself. Or, set `--snifflimit -1` to use the entire file as the sample, instead of the first 1024 bytes.

[Next

csvpy](csvpy.html)
[Previous

csvjson](csvjson.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* csvlook
  + [Description](#description)
  + [Examples](#examples)