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

[View this page](../_sources/scripts/csvstack.rst.txt "View this page")

# csvstack[¶](#csvstack "Link to this heading")

## Description[¶](#description "Link to this heading")

Stack up the rows from multiple CSV files, optionally adding a grouping value to each row:

```
usage: csvstack [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3}] [-b]
                [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-S] [-H]
                [-K SKIP_LINES] [-v] [-l] [--zero] [-V] [-g GROUPS]
                [-n GROUP_NAME] [--filenames]
                [FILE [FILE ...]]

Stack up the rows from multiple CSV files, optionally adding a grouping value.

positional arguments:
  FILE                  The CSV file(s) to operate on. If omitted, will accept
                        input as piped data via STDIN.

optional arguments:
  -h, --help            show this help message and exit
  -g GROUPS, --groups GROUPS
                        A comma-separated list of values to add as "grouping
                        factors", one per CSV being stacked. These are added
                        to the output as a new column. You may specify a name
                        for the new column using the -n flag.
  -n GROUP_NAME, --group-name GROUP_NAME
                        A name for the grouping column, e.g. "year". Only used
                        when also specifying -g.
  --filenames           Use the filename of each input file as its grouping
                        value. When specified, -g will be ignored.
```

See also: [Arguments common to all tools](../common_arguments.html).

Warning

If you redirect output to an input file like `csvstack file.csv > file.csv`, the file will grow indefinitely.

## Examples[¶](#examples "Link to this heading")

Join a set of files for different years:

```
csvstack -g 2009,2010 examples/realdata/FY09_EDU_Recipients_by_State.csv examples/realdata/Datagov_FY10_EDU_recp_by_State.csv
```

Add a single column to the left of a CSV:

```
csvstack -n NEWCOL -g "" examples/dummy.csv
```

[Next

csvformat](csvformat.html)
[Previous

csvsort](csvsort.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* csvstack
  + [Description](#description)
  + [Examples](#examples)