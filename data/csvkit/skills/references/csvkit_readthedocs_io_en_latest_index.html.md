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

csvkit 2.2.0 documentation

csvkit 2.2.0 documentation

* [Tutorial](tutorial.html)[ ]
* [Reference](cli.html)[ ]
* [Tips and Troubleshooting](tricks.html)
* [Contributing to csvkit](contributing.html)
* [Release process](release.html)
* [License](license.html)
* [Changelog](changelog.html)

Back to top

[View this page](_sources/index.rst.txt "View this page")

# csvkit 2.2.0[¶](#csvkit-release "Link to this heading")

## About[¶](#about "Link to this heading")

[![Build status](https://github.com/wireservice/csvkit/workflows/CI/badge.svg)](https://github.com/wireservice/csvkit/actions)
[![Coverage status](https://codecov.io/github/wireservice/csvkit/graph/badge.svg)](https://codecov.io/github/wireservice/csvkit)
[![PyPI downloads](https://img.shields.io/pypi/dm/csvkit.svg)](https://pypi.python.org/pypi/csvkit)
[![Version](https://img.shields.io/pypi/v/csvkit.svg)](https://pypi.python.org/pypi/csvkit)
[![License](https://img.shields.io/pypi/l/csvkit.svg)](https://pypi.python.org/pypi/csvkit)
[![Support Python versions](https://img.shields.io/pypi/pyversions/csvkit.svg)](https://pypi.python.org/pypi/csvkit)

csvkit is a suite of command-line tools for converting to and working with CSV, the king of tabular file formats.

It is inspired by pdftk, GDAL and the original csvcut tool by Joe Germuska and Aaron Bycoffe.

Important links:

* Documentation: <https://csvkit.rtfd.org/>
* Repository: <https://github.com/wireservice/csvkit>
* Issues: <https://github.com/wireservice/csvkit/issues>
* Schemas: <https://github.com/wireservice/ffs>

First time? See [Tutorial](tutorial.html).

Note

To change the field separator, line terminator, etc. of the **output**, you must use [csvformat](scripts/csvformat.html).

Note

csvkit, by default, [sniffs](https://docs.python.org/3/library/csv.html#csv.Sniffer) CSV formats (it deduces whether commas, tabs or spaces delimit fields, for example) based on the first 1024 bytes, and performs type inference (it converts text to numbers, dates, booleans, etc.). These features are useful and work well in most cases, but occasional errors occur. If you don’t need these features, set `--snifflimit 0` (`-y 0`) and `--no-inference` (`-I`).

Note

If you need to do more complex data analysis than csvkit can handle, use [agate](https://github.com/wireservice/agate). If you need csvkit to be faster or to handle larger files, you may be reaching the limits of csvkit. Consider loading the data into SQL, or using [qsv](https://github.com/jqnatividad/qsv) or [xsv](https://github.com/BurntSushi/xsv).

Note

Need to deduplicate or find fuzzy matches in your CSV data? Use [csvdedupe and csvlink](https://csvdedupe.readthedocs.io/en/latest/).

## Why csvkit?[¶](#why-csvkit "Link to this heading")

Because it makes your life easier.

Convert Excel to CSV:

```
in2csv data.xls > data.csv
```

Convert JSON to CSV:

```
in2csv data.json > data.csv
```

Print column names:

```
csvcut -n data.csv
```

Select a subset of columns:

```
csvcut -c column_a,column_c data.csv > new.csv
```

Reorder columns:

```
csvcut -c column_c,column_a data.csv > new.csv
```

Find rows with matching cells:

```
csvgrep -c phone_number -r "555-555-\d{4}" data.csv > new.csv
```

Convert to JSON:

```
csvjson data.csv > data.json
```

Generate summary statistics:

```
csvstat data.csv
```

Query with SQL:

```
csvsql --query "select name from data where age > 30" data.csv > new.csv
```

Import into PostgreSQL:

```
csvsql --db postgresql:///database --insert data.csv
```

Extract data from PostgreSQL:

```
sql2csv --db postgresql:///database --query "select * from data" > new.csv
```

And much more…

## Table of contents[¶](#table-of-contents "Link to this heading")

* [Tutorial](tutorial.html)
  + [1. Getting started](tutorial/1_getting_started.html)
    - [1.1. About this tutorial](tutorial/1_getting_started.html#about-this-tutorial)
    - [1.2. Installing csvkit](tutorial/1_getting_started.html#installing-csvkit)
    - [1.3. Getting the data](tutorial/1_getting_started.html#getting-the-data)
    - [1.4. in2csv: the Excel killer](tutorial/1_getting_started.html#in2csv-the-excel-killer)
    - [1.5. csvlook: data periscope](tutorial/1_getting_started.html#csvlook-data-periscope)
    - [1.6. csvcut: data scalpel](tutorial/1_getting_started.html#csvcut-data-scalpel)
    - [1.7. Putting it together with pipes](tutorial/1_getting_started.html#putting-it-together-with-pipes)
    - [1.8. Summing up](tutorial/1_getting_started.html#summing-up)
  + [2. Examining the data](tutorial/2_examining_the_data.html)
    - [2.1. csvstat: statistics without code](tutorial/2_examining_the_data.html#csvstat-statistics-without-code)
    - [2.2. csvgrep: find the data you need](tutorial/2_examining_the_data.html#csvgrep-find-the-data-you-need)
    - [2.3. csvsort: order matters](tutorial/2_examining_the_data.html#csvsort-order-matters)
    - [2.4. Summing up](tutorial/2_examining_the_data.html#summing-up)
  + [3. Power tools](tutorial/3_power_tools.html)
    - [3.1. csvjoin: merging related data](tutorial/3_power_tools.html#csvjoin-merging-related-data)
    - [3.2. csvstack: combining subsets](tutorial/3_power_tools.html#csvstack-combining-subsets)
    - [3.3. csvsql and sql2csv: ultimate power](tutorial/3_power_tools.html#csvsql-and-sql2csv-ultimate-power)
    - [3.4. Summing up](tutorial/3_power_tools.html#summing-up)
  + [4. Going elsewhere with your data](tutorial/4_going_elsewhere.html)
    - [4.1. csvjson: going online](tutorial/4_going_elsewhere.html#csvjson-going-online)
    - [4.2. csvpy: going into code](tutorial/4_going_elsewhere.html#csvpy-going-into-code)
    - [4.3. csvformat: for legacy systems](tutorial/4_going_elsewhere.html#csvformat-for-legacy-systems)
    - [4.4. Summing up](tutorial/4_going_elsewhere.html#summing-up)
* [Reference](cli.html)
  + [Input](cli.html#input)
    - [in2csv](scripts/in2csv.html)
    - [sql2csv](scripts/sql2csv.html)
  + [Processing](cli.html#processing)
    - [csvclean](scripts/csvclean.html)
    - [csvcut](scripts/csvcut.html)
    - [csvgrep](scripts/csvgrep.html)
    - [csvjoin](scripts/csvjoin.html)
    - [csvsort](scripts/csvsort.html)
    - [csvstack](scripts/csvstack.html)
  + [Output and Analysis](cli.html#output-and-analysis)
    - [csvformat](scripts/csvformat.html)
    - [csvjson](scripts/csvjson.html)
    - [csvlook](scripts/csvlook.html)
    - [csvpy](scripts/csvpy.html)
    - [csvsql](scripts/csvsql.html)
    - [csvstat](scripts/csvstat.html)
  + [Common arguments](cli.html#common-arguments)
    - [Arguments common to all tools](common_arguments.html)
* [Tips and Troubleshooting](tricks.html)
  + [Tips](tricks.html#tips)
    - [Reading compressed CSVs](tricks.html#reading-compressed-csvs)
    - [Specifying STDIN as a file](tricks.html#specifying-stdin-as-a-file)
    - [Using csvkit in a crontab](tricks.html#using-csvkit-in-a-crontab)
  + [Troubleshooting](tricks.html#troubleshooting)
    - [Installation](tricks.html#installation)
    - [CSV formatting and parsing](tricks.html#csv-formatting-and-parsing)
    - [CSV data interpretation](tricks.html#csv-data-interpretation)
    - [Slow performance](tricks.html#slow-performance)
    - [Database errors](tricks.html#database-errors)
    - [Python standard output encoding errors](tricks.html#python-standard-output-encoding-errors)
* [Contributing to csvkit](contributing.html)
  + [Getting started](contributing.html#getting-started)
  + [Principles of development](contributing.html#principles-of-development)
  + [How to contribute](contributing.html#how-to-contribute)
  + [A note on new tools](contributing.html#a-note-on-new-tools)
  + [Streaming versus buffering](contributing.html#streaming-versus-buffering)
  + [Legalese](contributing.html#legalese)
* [Release process](release.html)
* [License](license.html)
* [Changelog](changelog.html)
  + [2.2.0 - December 15, 2025](changelog.html#december-15-2025)
  + [2.1.0 - February 26, 2025](changelog.html#february-26-2025)
  + [2.0.1 - July 12, 2024](changelog.html#july-12-2024)
  + [2.0.0 - May 1, 2024](changelog.html#may-1-2024)
  + [1.5.0 - March 28, 2024](changelog.html#march-28-2024)
  + [1.4.0 - February 13, 2024](changelog.html#february-13-2024)
  + [1.3.0 - October 18, 2023](changelog.html#october-18-2023)
  + [1.2.0 - October 4, 2023](changelog.html#october-4-2023)
  + [1.1.1 - February 22, 2023](changelog.html#february-22-2023)
  + [1.1.0 - January 3, 2023](changelog.html#january-3-2023)
  + [1.0.7 - March 6, 2022](changelog.html#march-6-2022)
  + [1.0.6 - July 13, 2021](changelog.html#july-13-2021)
  + [1.0.5 - March 2, 2020](changelog.html#march-2-2020)
  + [1.0.4 - March 16, 2019](changelog.html#march-16-2019)
  + [1.0.3 - March 11, 2018](changelog.html#march-11-2018)
  + [1.0.2 - April 28, 2017](changelog.html#april-28-2017)
  + [1.0.1 - December 29, 2016](changelog.html#december-29-2016)
  + [1.0.0 - December 27, 2016](changelog.html#december-27-2016)
  + [0.9.1 - March 31, 2015](changelog.html#march-31-2015)
  + [0.9.0 - September 8, 2014](changelog.html#september-8-2014)
  + [0.8.0 - July 27, 2014](changelog.html#july-27-2014)
  + [0.7.3 - April 27, 2014](changelog.html#april-27-2014)
  + [0.7.2 - March 24, 2014](changelog.html#march-24-2014)
  + [0.7.1 - March 24, 2014](changelog.html#id1)
  + [0.7.0 - March 24, 2014](changelog.html#id2)
  + [0.6.1 - August 20, 2013](changelog.html#august-20-2013)
  + [0.6.0 - August 20, 2013](changelog.html#id3)
  + [0.5.0 - August 21, 2012](changelog.html#august-21-2012)
  + [0.4.4 - May 1, 2012](changelog.html#may-1-2012)
  + [0.4.3 - February 20, 2012](changelog.html#february-20-2012)

## Citation[¶](#citation "Link to this heading")

When citing csvkit in publications, you may use this BibTeX entry:

```
@Manual{csvkit,
  title = "csvkit",
  author = "Christopher Groskopf and contributors",
  year = "2016",
  url = "https://csvkit.readthedocs.org/"
}
```

## Authors[¶](#authors "Link to this heading")

The following individuals have contributed code to csvkit:

* Christopher Groskopf
* Joe Germuska
* Aaron Bycoffe
* Travis Mehlinger
* Alejandro Companioni
* Benjamin Wilson
* Bryan Silverthorn
* Evan Wheeler
* Matt Bone
* Ryan Pitts
* Hari Dara
* Jeff Larson
* Jim Thaxton
* Miguel Gonzalez
* Anton Ian Sipos
* Gregory Temchenko
* Kevin Schaul
* Marc Abramowitz
* Noah Hoffman
* Jan Schulz
* Derek Wilson
* Chris Rosenthal
* Davide Setti
* Gabi Davar
* Sriram Karra
* James McKinney
* Aaron McMillin
* Matt Dudys
* Joakim Lundborg
* Federico Scrinzi
* Shane StClair
* raistlin7447
* Alex Dergachev
* Jeff Paine
* Jeroen Janssens
* Sébastien Fievet
* Travis Swicegood
* Ryan Murphy
* Diego Rabatone Oliveira
* Matt Pettis
* Tasneem Raja
* Richard Low
* Kristina Durivage
* Espartaco Palma
* pnaimoli
* Michael Mior
* Jennifer Smith
* Antonio Lima
* Dave Stanton
* Pedrow
* Neal McBurnett
* Anthony DeBarros
* Baptiste Mispelon
* James Seppi
* Karrie Kehoe
* Geert Barentsen
* Cathy Deng
* Eric Bréchemier
* Neil Freeman
* Fede Isas
* Patricia Lipp
* Kev++
* edwardros
* Martin Burch
* Pedro Silva
* hydrosIII
* Tim Wisniewski
* Santiago Castro
* Dan Davison
* Éric Araujo
* Sam Stuck
* Edward Betts
* Jake Zimmerman
* Bryan Rankin
* Przemek Wesołek
* Karl Fogel
* sterlingpetersen
* kjedamzik
* John Vandenberg
* Olivier Lacan
* Adrien Delessert
* Ghislain Antony Vaillant
* Forest Gregg
* Aliaksei Urbanski
* Reid Beels
* Rodrigo Lemos
* Victor Noagbodji
* Connor McArthur
* Matěj Cepl
* Nicholas Matteo
* Matt Giguere
* Felix Bünemann
* Andriy Orehov (Андрій Орєхов)
* Dan Nguyen
* 谭九鼎
* Tomáš Hrnčiar
* Christopher Bottoms
* panolens
* Gabe Walker
* Gui13
* Danny Sepler
* Christian Clauss
* Bonifacio de Oliveira
* Ryan Grout
* badbunnyyy
* Werner Robitza
* Mark Mayo
* Kitagawa Yasutaka
* rachekalmir
* Tim Vergenz
* sgpeter1
* Wes Dean
* Álvaro Osvaldo
* lamdevhs

## Indices and tables[¶](#indices-and-tables "Link to this heading")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

[Next

Tutorial](tutorial.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* csvkit 2.2.0
  + [About](#about)
  + [Why csvkit?](#why-csvkit)
  + [Table of contents](#table-of-contents)
  + [Citation](#citation)
  + [Authors](#authors)
  + [Indices and tables](#indices-and-tables)