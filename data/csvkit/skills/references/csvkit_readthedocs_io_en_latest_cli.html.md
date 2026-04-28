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
* Reference[x]
* [Tips and Troubleshooting](tricks.html)
* [Contributing to csvkit](contributing.html)
* [Release process](release.html)
* [License](license.html)
* [Changelog](changelog.html)

Back to top

[View this page](_sources/cli.rst.txt "View this page")

# Reference[¶](#reference "Link to this heading")

csvkit is composed of command-line tools that can be divided into three major categories: Input, Processing, and Output. Documentation and examples for each tool are described on the following pages.

## Input[¶](#input "Link to this heading")

* [in2csv](scripts/in2csv.html)
* [sql2csv](scripts/sql2csv.html)

## Processing[¶](#processing "Link to this heading")

* [csvclean](scripts/csvclean.html)
* [csvcut](scripts/csvcut.html)
* [csvgrep](scripts/csvgrep.html)
* [csvjoin](scripts/csvjoin.html)
* [csvsort](scripts/csvsort.html)
* [csvstack](scripts/csvstack.html)

See also

To deduplicate and merge CSV files, consider [csvdedupe](https://pypi.org/project/csvdedupe/).

To change field values (i.e. to run `sed` or `awk`-like commands on CSV files), consider [qsv](https://github.com/jqnatividad/qsv)’s `replace` command or [miller](https://miller.readthedocs.io/en/latest/) (`mlr put`).

To transpose CSVs, consider [qsv](https://github.com/jqnatividad/qsv)’s `flatten` command or [miller](https://miller.readthedocs.io/en/latest/)’s [XTAB](https://miller.readthedocs.io/en/latest/file-formats/#xtab-vertical-tabular) support (`mlr --oxtab`).

## Output and Analysis[¶](#output-and-analysis "Link to this heading")

* [csvformat](scripts/csvformat.html)
* [csvjson](scripts/csvjson.html)
* [csvlook](scripts/csvlook.html)
* [csvpy](scripts/csvpy.html)
* [csvsql](scripts/csvsql.html)
* [csvstat](scripts/csvstat.html)

* To draw plots, consider [jp](https://github.com/sgreben/jp).
* To diff CSVs, consider [daff](https://github.com/paulfitz/daff).
* To explore CSVs interactively, consider [VisiData](https://visidata.org).

Alternatives to [csvsql](scripts/csvsql.html) are [q](https://github.com/harelba/q) and [textql](https://github.com/dinedal/textql).

## Common arguments[¶](#common-arguments "Link to this heading")

* [Arguments common to all tools](common_arguments.html)

[Next

in2csv](scripts/in2csv.html)
[Previous

4. Going elsewhere with your data](tutorial/4_going_elsewhere.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Reference
  + [Input](#input)
  + [Processing](#processing)
  + [Output and Analysis](#output-and-analysis)
  + [Common arguments](#common-arguments)