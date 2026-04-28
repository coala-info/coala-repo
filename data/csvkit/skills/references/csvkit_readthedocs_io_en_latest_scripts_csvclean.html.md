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

[View this page](../_sources/scripts/csvclean.rst.txt "View this page")

# csvclean[¶](#csvclean "Link to this heading")

## Description[¶](#description "Link to this heading")

Reports and fixes common errors in a CSV file.

### Checks[¶](#checks "Link to this heading")

* Reports rows that have a different number of columns than the header row, if the `--length-mismatch` option is set.
* Reports columns that are empty, if the `--empty-columns` option is set.

Tip

Enable all checks with `--enable-all-checks` (`-a`).

### Fixes[¶](#fixes "Link to this heading")

* If a CSV has unquoted cells that contain line breaks, like:

  ```
  id,address,country
  1,1 Main St
  Springfield,US
  2,123 Acadia Avenue
  London,GB
  ```

  Use `--join-short-rows` to attempt to correct the errors by merging short rows into a single row:

  ```
  id,address,country
  1,"1 Main St
  Springfield",US
  2,"123 Acadia Avenue
  London",GB
  ```

  To change the string used to join the lines, use `--separator`. For example, with `--separator ", "`:

  ```
  id,address,country
  1,"1 Main St, Springfield",US
  2,"123 Acadia Avenue, London",GB
  ```
* If a CSV has missing delimiters, like:

  ```
  id,name,country
  1,Alice
  2,Bob,CA
  ```

  You can add the missing delimiters with `--fill-short-rows`:

  ```
  id,name,country
  1,Alice,
  2,Bob,CA
  ```

  Tip

  [csvcut](csvcut.html) without options also adds missing delimiters!

  To change the value used to fill short rows, use `--fillvalue`. For example, with `--fillvalue "US"`:

  ```
  id,name,country
  1,Alice,US
  2,Bob,CA
  ```

See also

`--header-normalize-space` under [Usage](#csvclean-usage).

Note

Every csvkit tool does the following:

* Removes optional quote characters, unless the –quoting (-u) option is set to change this behavior
* Changes the field delimiter to a comma, if the input delimiter is set with the –delimiter (-d) or –tabs (-t) options
* Changes the record delimiter to a line feed (LF or `\n`)
* Changes the quote character to a double-quotation mark, if the character is set with the –quotechar (-q) option
* Changes the character encoding to UTF-8, if the input encoding is set with the –encoding (-e) option

### Output[¶](#output "Link to this heading")

`csvclean` attempts to make the selected fixes. Then:

* If the `--omit-error-rows` option is set, **only** rows that pass the selected checks are written to standard output. If not, **all** rows are written to standard output.
* If any checks are enabled, **error** rows along with line numbers and descriptions are written to standard error. If there are error rows, the exit code is 1.

### Usage[¶](#usage "Link to this heading")

```
usage: csvclean [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3}] [-b]
                [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-S] [-H]
                [-K SKIP_LINES] [-v] [-l] [--zero] [-V]
                [FILE]

Fix common errors in a CSV file.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

optional arguments:
  -h, --help            show this help message and exit
  --length-mismatch     Report data rows that are shorter or longer than the
                        header row.
  --empty-columns       Report empty columns as errors.
  -a, --enable-all-checks
                        Enable all error reporting.
  --omit-error-rows     Omit data rows that contain errors, from standard
                        output.
  --label LABEL         Add a "label" column to standard error. Useful in
                        automated workflows. Use "-" to default to the input
                        filename.
  --header-normalize-space
                        Strip leading and trailing whitespace and replace
                        sequences of whitespace characters by a single space
                        in the header.
  --join-short-rows     Merges short rows into a single row.
  --separator SEPARATOR
                        The string with which to join short rows. Defaults to
                        a newline.
  --fill-short-rows     Fill short rows with the missing cells.
  --fillvalue FILLVALUE
                        The value with which to fill short rows. Defaults to
                        none.
```

See also: [Arguments common to all tools](../common_arguments.html).

## Examples[¶](#examples "Link to this heading")

Process a file with data rows that are shorter and longer than the header row, and omit those rows:

```
$ csvclean --length-mismatch --omit-error-rows examples/bad.csv 2> errors.csv
column_a,column_b,column_c
0,mixed types.... uh oh,17
```

```
$ cat errors.csv
line_number,msg,column_a,column_b,column_c
1,"Expected 3 columns, found 4 columns",1,27,,I'm too long!
2,"Expected 3 columns, found 2 columns",,I'm too short!
```

Note

If any data rows are longer than the header row, you need to add columns manually: for example, by adding one or more delimiters (`,`) to the end of the header row. `csvclean` can’t do this, because it is designed to work with standard input, and correcting an error at the start of the CSV data based on an observation later in the CSV data would require holding all the CSV data in memory – which is not an option for large files.

Process a file with empty columns:

```
$ csvclean --empty-columns examples/test_empty_columns.csv 2> errors.csv
a,b,c,,
a,,,,
,,c,,
,,,,
```

```
$ cat errors.csv
line_number,msg,a,b,c,,
1,"Empty columns named 'b', '', ''! Try: csvcut -C 2,4,5",,,,,
```

Then, use [csvcut](csvcut.html) to exclude the empty columns:

```
$ csvcut -C 2,4,5 examples/test_empty_columns.csv
a,c
a,
,c
,
```

Check whether any errors found:

```
$ if [ csvclean -a examples/bad.csv ]; then echo "my message"; fi
my message
```

Or:

```
$ [ csvclean -a examples/bad.csv ] && echo "my message"
my message
```

Or:

```
$ csvclean -a examples/bad.csv >/dev/null 2>&1
$ echo $?
1
```

Count the number of errors found:

```
$ csvclean -a examples/bad.csv 2>&1 >/dev/null | csvstat --count
2
```

View only the errors found:

```
$ csvclean -a examples/bad.csv 2>&1 >/dev/null
line_number,msg,column_a,column_b,column_c
1,"Expected 3 columns, found 4 columns",1,27,,I'm too long!
2,"Expected 3 columns, found 2 columns",,I'm too short!
```

To change the line ending from line feed (LF or `\n`) to carriage return and line feed (CRLF or `\r\n`) use:

```
csvformat -M $'\r\n' examples/dummy.csv
```

[Next

csvcut](csvcut.html)
[Previous

sql2csv](sql2csv.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* csvclean
  + [Description](#description)
    - [Checks](#checks)
    - [Fixes](#fixes)
    - [Output](#output)
    - [Usage](#usage)
  + [Examples](#examples)