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

[View this page](../_sources/scripts/csvpy.rst.txt "View this page")

# csvpy[¶](#csvpy "Link to this heading")

## Description[¶](#description "Link to this heading")

Loads a CSV file into a `agate.csv.Reader` object and then drops into a Python shell so the user can inspect the data however they see fit:

```
usage: csvpy [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3}] [-b]
             [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
             [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
             [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
             [-H] [-K SKIP_LINES] [-v] [-l] [--zero] [-V] [--dict] [--agate]
             [--no-number-ellipsis] [-y SNIFF_LIMIT] [-I]
             [FILE]

Load a CSV file into a CSV reader and then drop into a Python shell.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

optional arguments:
  -h, --help            show this help message and exit
  --dict                Load the CSV file into a DictReader.
  --agate               Load the CSV file into an agate table.
  --no-number-ellipsis  Disable the ellipsis if the max precision is exceeded.
  -y SNIFF_LIMIT, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.
```

This tool will automatically use the IPython shell if it is installed, otherwise it will use the running Python shell.

Note

Due to platform limitations, csvpy does not accept file input as piped data via STDIN.

See also: [Arguments common to all tools](../common_arguments.html).

## Examples[¶](#examples "Link to this heading")

Basic use:

```

```

$ csvpy examples/dummy.csv
:   Welcome! “examples/dummy.csv” has been loaded in a reader object named “reader”.
    >>> next(reader)
    [‘a’, ‘b’, ‘c’]

As a dictionary:

```
$ csvpy --dict examples/dummy.csv
Welcome! "examples/dummy.csv" has been loaded in a DictReader object named "reader".
>>> next(reader)
{'a': '1', 'c': '3', 'b': '2'}
```

As an agate table:

```
$ csvpy --agate examples/dummy.csv
Welcome! "examples/dummy.csv" has been loaded in a from_csv object named "reader".
>>> reader.print_table()
|    a | b | c |
| ---- | - | - |
| True | 2 | 3 |
```

[Next

csvsql](csvsql.html)
[Previous

csvlook](csvlook.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* csvpy
  + [Description](#description)
  + [Examples](#examples)