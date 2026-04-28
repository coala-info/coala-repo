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

[View this page](../_sources/scripts/csvjoin.rst.txt "View this page")

# csvjoin[¶](#csvjoin "Link to this heading")

## Description[¶](#description "Link to this heading")

Merges two or more CSV tables together using a method analogous to SQL JOIN operation. By default it performs an inner join, but full outer, left outer, and right outer are also available via flags. Key columns are specified with the -c flag (either a single column which exists in all tables, or a comma-separated list of columns with one corresponding to each). If the columns flag is not provided then the tables will be merged “sequentially”, that is they will be merged in row order with no filtering:

```
usage: csvjoin [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3}] [-b]
               [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
               [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
               [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
               [-H] [-K SKIP_LINES] [-v] [-l] [--zero] [-V] [-c COLUMNS]
               [--outer] [--left] [--right] [-y SNIFF_LIMIT] [-I]
               [FILE [FILE ...]]

Execute a SQL-like join to merge CSV files on a specified column or columns.

positional arguments:
  FILE                  The CSV files to operate on. If only one is specified,
                        it will be copied to STDOUT.

optional arguments:
  -h, --help            show this help message and exit
  -c COLUMNS, --columns COLUMNS
                        The column name(s) on which to join. Should be either
                        one name (or index) or a comma-separated list with one
                        name (or index) per file, in the same order in which
                        the files were specified. If not specified, the two
                        files will be joined sequentially without matching.
  --outer               Perform a full outer join, rather than the default
                        inner join.
  --left                Perform a left outer join, rather than the default
                        inner join. If more than two files are provided this
                        will be executed as a sequence of left outer joins,
                        starting at the left.
  --right               Perform a right outer join, rather than the default
                        inner join. If more than two files are provided this
                        will be executed as a sequence of right outer joins,
                        starting at the right.
  -y SNIFF_LIMIT, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.

Note that the join operation requires reading all files into memory. Don't try
this on very large files.
```

See also: [Arguments common to all tools](../common_arguments.html).

## Examples[¶](#examples "Link to this heading")

```
csvjoin -c 1 examples/join_a.csv examples/join_b.csv
```

Add two empty columns to the right of a CSV:

```
echo "," | csvjoin examples/dummy.csv -
```

Add a single column to the right of a CSV:

```
echo "new-column" | csvjoin examples/dummy.csv -
```

[Next

csvsort](csvsort.html)
[Previous

csvgrep](csvgrep.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* csvjoin
  + [Description](#description)
  + [Examples](#examples)