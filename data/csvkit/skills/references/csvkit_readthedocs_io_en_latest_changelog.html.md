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

[csvkit 2.2.0 documentation](index.html)

[csvkit 2.2.0 documentation](index.html)

* [Tutorial](tutorial.html)[ ]
* [Reference](cli.html)[ ]
* [Tips and Troubleshooting](tricks.html)
* [Contributing to csvkit](contributing.html)
* [Release process](release.html)
* [License](license.html)
* Changelog

Back to top

[View this page](_sources/changelog.rst.txt "View this page")

# Changelog[¶](#changelog "Link to this heading")

## 2.2.0 - December 15, 2025[¶](#december-15-2025 "Link to this heading")

* fix: [csvstack](scripts/csvstack.html) no longer errors if a CSV file is empty.
* Add Python 3.14 support. Drop support for end-of-life version 3.9.

## 2.1.0 - February 26, 2025[¶](#february-26-2025 "Link to this heading")

* feat: Add a `--no-leading-zeroes` option to tools that support type inference.
* feat: Add a `--add-bom` option to add the UTF-8 byte-order mark (BOM) to CSV output, for Excel compatibility.
* feat: [csvsql](scripts/csvsql.html) adds a `--engine-option` option.
* feat: [csvsql](scripts/csvsql.html) adds a `--sql-delimiter` option, to set a different delimiter than `;` for the `--query`, `--before-insert` and `after-insert` options.
* feat: [sql2csv](scripts/sql2csv.html) adds a `--execution-option` option.
* feat: [sql2csv](scripts/sql2csv.html) uses the `stream_results=True` execution option, by default, to not load all data into memory at once.
* fix: [csvcut](scripts/csvcut.html) no longer errors on unknown columns when using the `--not-columns` (`-C`) option.
* fix: [csvsql](scripts/csvsql.html) uses a default value of 1 for the `--min-col-len` and `--col-len-multiplier` options.
* fix: The `--encoding` option defaults to the `PYTHONIOENCODING` environment variable if set.
* fix: For type inference, number takes priority over date-time, if not using the `--datetime-format` option.

## 2.0.1 - July 12, 2024[¶](#july-12-2024 "Link to this heading")

* feat: [csvsql](scripts/csvsql.html) adds `--min-col-len` and `--col-len-multiplier` options.
* feat: [sql2csv](scripts/sql2csv.html) adds a `--engine-option` option.
* feat: Add a Docker image: `docker pull ghcr.io/wireservice/csvkit:latest`.
* feat: Add man pages to the sdist and wheel distributions.
* fix: [csvstat](scripts/csvstat.html) no longer errors when a column is a time delta and `--json` is set.
* fix: When taking arguments from `sys.argv` on Windows, glob patterns, user directories, and environment variables are expanded.

## 2.0.0 - May 1, 2024[¶](#may-1-2024 "Link to this heading")

This is the first major release since December 27, 2016. Thank you to all [contributors](index.html#authors), including 44 new contributors since 1.0.0!

Want to use csvkit programmatically? Check out [agate](https://agate.readthedocs.io/en/latest/), used internally by csvkit.

**BACKWARDS-INCOMPATIBLE CHANGES:**

* [csvclean](scripts/csvclean.html) now writes its output to standard output and its errors to standard error, instead of to `basename_out.csv` and `basename_err.csv` files. Consequently:

  + The `--dry-run` option is removed. The `--dry-run` option changed error output from the CSV format used in `basename_err.csv` files to a prosaic format like `Line 1: Expected 2 columns, found 3 columns`.
  + Summary information like `No errors.`, `42 errors logged to basename_err.csv` and `42 rows were joined/reduced to 24 rows after eliminating expected internal line breaks.` is not written.
* [csvclean](scripts/csvclean.html) no longer reports or fixes errors by default; it errors if no checks or fixes are enabled. Opt in to the original behavior using the `--length-mismatch` and `--join-short-rows` options. See new options below.
* [csvclean](scripts/csvclean.html) no longer omits rows with errors from the output. Opt in to the original behavior using the `--omit-error-rows` option.
* [csvclean](scripts/csvclean.html) joins short rows using a newline by default, instead of a space. Restore the original behavior using the `--separator " "` option.

In brief, to restore the original behavior for [csvclean](scripts/csvclean.html):

```
csvclean --length-mismatch --omit-error-rows --join-short-rows --separator " " myfile.csv
```

Other changes:

* feat: [csvclean](scripts/csvclean.html) adds the options:

  + `--length-mismatch`, to error on data rows that are shorter or longer than the header row
  + `--empty-columns`, to error on empty columns
  + `--enable-all-checks`, to enable all error reporting
  + `--omit-error-rows`, to omit data rows that contain errors, from standard output
  + `--label LABEL`, to add a “label” column to standard error
  + `--header-normalize-space`, to strip leading and trailing whitespace and replace sequences of whitespace characters by a single space in the header
  + `--join-short-rows`, to merge short rows into a single row
  + `--separator SEPARATOR`, to change the string with which to join short rows (default is newline)
  + `--fill-short-rows`, to fill short rows with the missing cells
  + `--fillvalue FILLVALUE`, to change the value with which to fill short rows (default is none)
* feat: The `--quoting` option accepts 4 ([csv.QUOTE\_STRINGS](https://docs.python.org/3/library/csv.html#csv.QUOTE_STRINGS)) and 5 ([csv.QUOTE\_NOTNULL](https://docs.python.org/3/library/csv.html#csv.QUOTE_NOTNULL)) on Python 3.12.
* feat: [csvformat](scripts/csvformat.html): The `--out-quoting` option accepts 4 ([csv.QUOTE\_STRINGS](https://docs.python.org/3/library/csv.html#csv.QUOTE_STRINGS)) and 5 ([csv.QUOTE\_NOTNULL](https://docs.python.org/3/library/csv.html#csv.QUOTE_NOTNULL)) on Python 3.12.
* fix: [csvformat](scripts/csvformat.html): The `--out-quoting` option works with 2 ([csv.QUOTE\_NONUMERIC](https://docs.python.org/3/library/csv.html#csv.QUOTE_NOTNUMERIC)). Use the `--locale` option to set the locale of any formatted numbers.
* fix: [csvclean](scripts/csvclean.html): The `--join-short-rows` option no longer reports length mismatch errors that were fixed.

## 1.5.0 - March 28, 2024[¶](#march-28-2024 "Link to this heading")

* feat: Add support for Zstandard files with the `.zst` extension, if the `zstandard` package is installed.
* feat: [csvformat](scripts/csvformat.html) adds a `--out-asv` (`--A`) option to use the ASCII unit separator and record separator.
* feat: [csvsort](scripts/csvsort.html) adds a `--ignore-case` (`--i`) option to perform case-independent sorting.

## 1.4.0 - February 13, 2024[¶](#february-13-2024 "Link to this heading")

* feat: [csvpy](scripts/csvpy.html) adds the options:

  + `--no-number-ellipsis`, to disable the ellipsis (`…`) if max precision is exceeded, for example, when using `table.print_table()`
  + `` --sniff-limit` ``
  + `` --no-inference` ``
* feat: [csvpy](scripts/csvpy.html) removes the `--linenumbers` and `--zero` output options, which had no effect.
* feat: [in2csv](scripts/in2csv.html) adds a `--reset-dimensions` option to [recalculate](https://openpyxl.readthedocs.io/en/stable/optimized.html#worksheet-dimensions) the dimensions of an XLSX file, instead of trusting the file’s metadata. csvkit’s dependency [agate-excel](https://agate-excel.readthedocs.io/en/latest/) 0.4.0 automatically recalculates the dimensions if the file’s metadata expresses dimensions of “A1:A1” (a single cell).
* fix: [csvlook](scripts/csvlook.html) only reads up to `--max-rows` rows instead of the entire file.
* fix: [csvpy](scripts/csvpy.html) supports the existing input options:

  + `--locale`
  + `--blanks`
  + `--null-value`
  + `--date-format`
  + `--datetime-format`
  + `--skip-lines`
* fix: [csvpy](scripts/csvpy.html): `--maxfieldsize` no longer errors when `--dict` is set.
* fix: [csvstack](scripts/csvstack.html): `--maxfieldsize` no longer errors when `--no-header-row` isn’t set.
* fix: [in2csv](scripts/in2csv.html): `--write-sheets` no longer errors when standard input is an XLS or XLSX file.
* Update minimum agate version to 1.6.3.

## 1.3.0 - October 18, 2023[¶](#october-18-2023 "Link to this heading")

* [csvformat](scripts/csvformat.html) adds a `--skip-header` (`-E`) option to not output a header row.
* [csvlook](scripts/csvlook.html) adds a `--max-precision` option to set the maximum number of decimal places to display.
* [csvlook](scripts/csvlook.html) adds a `--no-number-ellipsis` option to disable the ellipsis (`…`) if `--max-precision` is exceeded. (Requires agate 1.9.0 or greater.)
* [csvstat](scripts/csvstat.html) supports the `--no-inference` (`-I`), `--locale` (`-L`), `--blanks`, `--date-format` and `datetime-format` options.
* [csvstat](scripts/csvstat.html) reports a “Non-null values” statistic (or a `nonnulls` column when `--csv` is set).
* [csvstat](scripts/csvstat.html) adds a `--non-nulls` option to only output counts of non-null values.
* [csvstat](scripts/csvstat.html) reports a “Most decimal places” statistic (or a `maxprecision` column when `--csv` is set).
* [csvstat](scripts/csvstat.html) adds a `--max-precision` option to only output the most decimal places.
* [csvstat](scripts/csvstat.html) adds a `--json` option to output results as JSON text.
* [csvstat](scripts/csvstat.html) adds an `--indent` option to indent the JSON text when `--json` is set.
* [in2csv](scripts/in2csv.html) adds a `--use-sheet-names` option to use the sheet names as file names when `--write-sheets` is set.
* feat: Add a `--null-value` option to commands with the `--blanks` option, to convert additional values to NULL.
* fix: Reconfigure the encoding of standard input according to the `--encoding` option, which defaults to `utf-8-sig`. Affected users no longer need to set the `PYTHONIOENCODING` environment variable.
* fix: Prompt the user if additional input is expected (i.e. if no input file or piped data is provided) in [csvjoin](scripts/csvjoin.html), [csvsql](scripts/csvsql.html) and [csvstack](scripts/csvstack.html).
* fix: No longer errors if a NUL byte occurs in an input file.
* Add Python 3.12 support.

## 1.2.0 - October 4, 2023[¶](#october-4-2023 "Link to this heading")

* fix: [csvjoin](scripts/csvjoin.html) uses the correct columns when performing a `--right` join.
* Add SQLAlchemy 2 support.
* Drop Python 3.7 support (end-of-life was June 5, 2023).

## 1.1.1 - February 22, 2023[¶](#february-22-2023 "Link to this heading")

* feat: [csvstack](scripts/csvstack.html) handles files with columns in different orders or with different names.

## 1.1.0 - January 3, 2023[¶](#january-3-2023 "Link to this heading")

* feat: [csvsql](scripts/csvsql.html) accepts multiple `--query` command-line arguments.
* feat: [csvstat](scripts/csvstat.html) adds `--no-grouping-separator` and `--decimal-format` options.
* Add Python 3.11 support.
* Drop Python 3.6 support (end-of-life was December 23, 2021).
* Drop Python 2.7 support (end-of-life was January 1, 2020).

## 1.0.7 - March 6, 2022[¶](#march-6-2022 "Link to this heading")

* fix: [csvcut](scripts/csvcut.html) extracts the correct columns when `--line-numbers` is set.
* fix: Restore Python 2.7 support in edge cases.
* feat: Use 1024 byte sniff-limit by default across csvkit. Improve csvstat performance up to 10x.
* feat: Add support for `.xz` (LZMA) compressed input files.
* Add Python 3.10 support.
* Drop Python 3.5 support (end-of-life was September 30, 2020).

## 1.0.6 - July 13, 2021[¶](#july-13-2021 "Link to this heading")

Changes:

* [csvstat](scripts/csvstat.html) no longer prints “Row count: “ when `--count` is set.
* [csvclean](scripts/csvclean.html), [csvcut](scripts/csvcut.html), [csvgrep](scripts/csvgrep.html) no longer error if standard input is null.

Fixes:

* [csvformat](scripts/csvformat.html) creates default headers when `--no-header-row` is set, as documented.
* [csvstack](scripts/csvstack.html) no longer errors when `--no-header-row` is combined with `--groups` or `--filenames`.

## 1.0.5 - March 2, 2020[¶](#march-2-2020 "Link to this heading")

Changes:

* Drop Python 3.4 support (end-of-life was March 18, 2019).

Improvements:

* Output error message for memory error even if not `--verbose`.

Fixes:

* Fix regression in 1.0.4, which caused numbers like `4.5` to be parsed as dates.
* [in2csv](scripts/in2csv.html) Fix error reporting if `--names` used with non-Excel file.

## 1.0.4 - March 16, 2019[¶](#march-16-2019 "Link to this heading")

Changes:

* Drop Python 3.3 support (end-of-life was September 29, 2017).

Improvements:

* [csvsql](scripts/csvsql.html) adds a `--chunk-size` option to set the chunk size when batch inserting into a table.
* csvkit is tested against Python 3.7.

Fixes:

* `--names` works with `--skip-lines`.
* Dates and datetimes without punctuation can be parsed with `--date-format` and `datetime-format`.
* Error messages about column indices use 1-based numbering unless `--zero` is set.
* [csvcut](scripts/csvcut.html) no longer errors on `--delete-empty-rows` with short rows.
* [csvjoin](scripts/csvjoin.html) no longer errors if given a single file.
* [csvsql](scripts/csvsql.html) supports UPDATE commands.
* [csvstat](scripts/csvstat.html) no longer errors on non-finite numbers.
* [csvstat](scripts/csvstat.html) respects all command-line arguments when `--count` is set.
* [in2csv](scripts/in2csv.html) CSV-to-CSV conversion respects `--linenumbers` when buffering.
* [in2csv](scripts/in2csv.html) writes XLS sheets without encoding errors in Python 2.

## 1.0.3 - March 11, 2018[¶](#march-11-2018 "Link to this heading")

Improvements:

* [csvgrep](scripts/csvgrep.html) adds a `--any-match` (`-a`) flag to select rows where any column matches instead of all columns.
* [csvjson](scripts/csvjson.html) no longer emits a property if its value is null.
* [csvjson](scripts/csvjson.html) adds `--type` and `--geometry` options to emit non-Point GeoJSON features.
* [csvjson](scripts/csvjson.html) adds a `--no-bbox` option to disable the calculation of a bounding box.
* [csvjson](scripts/csvjson.html) supports `--stream` for newline-delimited GeoJSON.
* [csvsql](scripts/csvsql.html) adds a `--unique-constraint` option to list names of columns to include in a UNIQUE constraint.
* [csvsql](scripts/csvsql.html) adds `--before-insert` and `--after-insert` options to run commands before and after the INSERT command.
* [csvpy](scripts/csvpy.html) reports an error message if input is provided via STDIN.
* [in2csv](scripts/in2csv.html) adds a `--encoding-xls` option to specify the encoding of the input XLS file.
* [in2csv](scripts/in2csv.html) supports `--no-header-row` on XLS and XLSX files.
* Suppress agate warning about column names not specified when using `--no-header-row`.
* Prompt the user if additional input is expected (i.e. if no input file or piped data is provided).
* Update to [agate-excel 0.2.2](https://agate-excel.readthedocs.io/en/latest/#changelog), [agate-sql 0.5.3](https://agate-sql.readthedocs.io/en/latest/#changelog).

Fixes:

* [csvgrep](scripts/csvgrep