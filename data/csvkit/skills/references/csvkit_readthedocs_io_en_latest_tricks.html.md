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
* Tips and Troubleshooting
* [Contributing to csvkit](contributing.html)
* [Release process](release.html)
* [License](license.html)
* [Changelog](changelog.html)

Back to top

[View this page](_sources/tricks.rst.txt "View this page")

# Tips and Troubleshooting[¶](#tips-and-troubleshooting "Link to this heading")

## Tips[¶](#tips "Link to this heading")

### Reading compressed CSVs[¶](#reading-compressed-csvs "Link to this heading")

csvkit has builtin support for reading `gzip`, `bz2` and `xz` (LZMA) compressed input files. This is automatically detected based on the file extension. For example:

```
csvstat examples/dummy.csv.gz
csvstat examples/dummy.csv.bz2
csvstat examples/dummy.csv.xz
```

Please note, the files are decompressed in memory, so this is a convenience, not an optimization.

### Specifying STDIN as a file[¶](#specifying-stdin-as-a-file "Link to this heading")

Most tools use `STDIN` as input if no filename is given, but tools that accept multiple inputs like [csvjoin](scripts/csvjoin.html) and [csvstack](scripts/csvstack.html) don’t. To use `STDIN` as an input to these tools, use `-` as the filename. For example, these three commands produce the same output:

```
csvstat examples/dummy.csv
cat examples/dummy.csv | csvstat
cat examples/dummy.csv | csvstat -
```

[csvstack](scripts/csvstack.html) can take a filename and `STDIN` as input, for example:

```
cat examples/dummy.csv | csvstack examples/dummy3.csv -
```

Alternately, you can pipe in multiple inputs like so:

```
csvjoin -c id <(csvcut -c 2,5,6 a.csv) <(csvcut -c 1,7 b.csv)
```

### Using csvkit in a crontab[¶](#using-csvkit-in-a-crontab "Link to this heading")

Processes running in a crontab [will not have a tty allocated](https://github.com/wireservice/csvkit/issues/342), so reading files for csvkit will require passing the file as stdin rather than using the file argument:

```
# bad
0 0 * * * /usr/bin/csvsql --query 'select max(time) from temp' -d ';' --tables temp /my/csv/file.csv

# works fine
0 0 * * * /usr/bin/csvsql --query 'select max(time) from temp' -d ';' --tables temp < /my/csv/file.csv
```

## Troubleshooting[¶](#troubleshooting "Link to this heading")

### Installation[¶](#installation "Link to this heading")

csvkit is supported on non-end-of-life versions of Python on Linux, macOS and Windows.

If installing on macOS, you may need to install Homebrew first:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install python
pip install csvkit
```

If installing on Ubuntu, you may need to install Python’s development headers first:

```
sudo apt-get install python-dev python-pip python-setuptools build-essential
pip install csvkit
```

If the installation is successful but csvkit’s tools fail, you may need to update Python’s setuptools package first:

```
pip install --upgrade setuptools
pip install --upgrade csvkit
```

On macOS, if you see `OSError: [Errno 1] Operation not permitted`, try:

```
sudo pip install --ignore-installed csvkit
```

Or if you see `/usr/local/bin/pip: bad interpreter` and have Python 3 installed, try:

```
python3 -m pip install csvkit
```

### CSV formatting and parsing[¶](#csv-formatting-and-parsing "Link to this heading")

* Are values appearing in incorrect columns?
* Does the output combine multiple fields into a single column with double-quotes?
* Does the outplit split a single field into multiple columns?
* Are `csvstat -c 1` and `csvstat --count` reporting inconsistent row counts?
* Do you see `Row # has # values, but Table only has # columns.`?

These may be symptoms of CSV sniffing gone wrong. As there is no single, standard CSV format, csvkit uses Python’s [csv.Sniffer](https://docs.python.org/3/library/csv.html#csv.Sniffer) to deduce the format of a CSV file: that is, the field delimiter and quote character. By default, the first 1024 bytes of the file are sent for sniffing. You can send a different sample size with the `--snifflimit` option. If you’re encountering any cases above, you can try setting `--snifflimit 0` to disable sniffing and set the `--delimiter` and `--quotechar` options yourself. Or, you can try setting `--snifflimit -1` to use the entire file as the sample.

Although these issues are annoying, in most cases, CSV sniffing Just Works™. Disabling sniffing by default would produce a lot more issues than enabling it by default.

### CSV data interpretation[¶](#csv-data-interpretation "Link to this heading")

* Are the numbers `1` and `0` being interpreted as `True` and `False`?
* Are phone numbers changing to integers and losing their leading `+` or `0`?
* Are text values incorrectly being converted to dates or datetimes?
* Is the Italian comune of “None” being treated as a null value?

These may be symptoms of csvkit’s type inference being too aggressive for your data. CSV is a text format, but it may contain text representing numbers, dates, booleans or other types. csvkit attempts to reverse engineer that text into proper data types—a process called “type inference”.

For some data, type inference can be error prone. If necessary you can disable it with the `--no-inference` option. This will force all columns to be treated as regular text.

To prevent values from being converted to dates or datetimes, set the `--date-format` and/or `--datetime-format` options to a non-occurring value, like `-`.

### Slow performance[¶](#slow-performance "Link to this heading")

csvkit’s tools fall into two categories: Those that load an entire CSV into memory (e.g. [csvstat](scripts/csvstat.html)) and those that only read data one row at a time (e.g. [csvcut](scripts/csvcut.html)). Those that stream results will generally be very fast. See [Contributing to csvkit](contributing.html) for a full list. For those that buffer the entire file, the slowest part of that process is typically the “type inference” described in the previous section.

If a tool is too slow to be practical for your data try setting the `--snifflimit` option or using the `--no-inference`.

### Database errors[¶](#database-errors "Link to this heading")

Are you seeing this error message, even after running `pip install psycopg2`, `pip install mysql-connector-python` or `pip install mysqlclient`?

```
You don't appear to have the necessary database backend installed for connection string you're trying to use. Available backends include:

PostgreSQL: pip install psycopg2
MySQL:      pip install mysql-connector-python OR pip install mysqlclient

For details on connection strings and other backends, please see the SQLAlchemy documentation on dialects at:

https://www.sqlalchemy.org/docs/dialects/
```

If you installed csvkit with Homebrew (`brew install csvkit`), then you need to install those packages with the same version of `pip` as the `csvkit` formula. For example:

```
$(brew --prefix csvkit)/libexec/bin/pip install psycopg2
```

Otherwise, make sure that you can open a `python` interpreter and run `import psycopg2`. If you see an error containing `mach-o, but wrong architecture`, you may need to reinstall `psycopg2` with `export ARCHFLAGS="-arch i386" pip install --upgrade psycopg2` ([source](https://www.destructuring.net/2013/07/31/trouble-installing-psycopg2-on-osx/)).

If you see another error, you may be able to find a solution on StackOverflow.

### Python standard output encoding errors[¶](#python-standard-output-encoding-errors "Link to this heading")

If, when running a command like `csvlook dummy.csv | less` you get an error like:

```
'ascii' codec can't encode character '\u0105' in position 2: ordinal not in range(128)
```

The simplest option is to set the encoding that Python uses for standard streams, using the `PYTHONIOENCODING` environment variable:

```
env PYTHONIOENCODING=utf8 csvlook dummy.csv | less
```

[Next

Contributing to csvkit](contributing.html)
[Previous

Arguments common to all tools](common_arguments.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Tips and Troubleshooting
  + [Tips](#tips)
    - [Reading compressed CSVs](#reading-compressed-csvs)
    - [Specifying STDIN as a file](#specifying-stdin-as-a-file)
    - [Using csvkit in a crontab](#using-csvkit-in-a-crontab)
  + [Troubleshooting](#troubleshooting)
    - [Installation](#installation)
    - [CSV formatting and parsing](#csv-formatting-and-parsing)
    - [CSV data interpretation](#csv-data-interpretation)
    - [Slow performance](#slow-performance)
    - [Database errors](#database-errors)
    - [Python standard output encoding errors](#python-standard-output-encoding-errors)