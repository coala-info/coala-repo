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

[View this page](../_sources/scripts/sql2csv.rst.txt "View this page")

# sql2csv[¶](#sql2csv "Link to this heading")

## Description[¶](#description "Link to this heading")

Executes arbitrary commands against a SQL database and outputs the results as a CSV:

```
usage: sql2csv [-h] [-v] [-l] [-V] [--db CONNECTION_STRING] [--query QUERY]
               [-e ENCODING] [-H]
               [FILE]

Execute a SQL query on a database and output the result to a CSV file.

positional arguments:
  FILE                  The file to use as the SQL query. If FILE and --query
                        are omitted, the query is piped data via STDIN.

optional arguments:
  -h, --help            show this help message and exit
  --db CONNECTION_STRING
                        A SQLAlchemy connection string to connect to a
                        database.
  --engine-option ENGINE_OPTION ENGINE_OPTION
                        A keyword argument to SQLAlchemy's create_engine(), as
                        a space-separated pair. This option can be specified
                        multiple times. For example: thick_mode True
  --execution-option EXECUTION_OPTION EXECUTION_OPTION
                        A keyword argument to SQLAlchemy's
                        execution_options(), as a space-separated pair. This
                        option can be specified multiple times. For example:
                        stream_results True
  --query QUERY         The SQL query to execute. Overrides FILE and STDIN.
  -e ENCODING, --encoding ENCODING
                        Specify the encoding of the input query file.
  -H, --no-header-row   Do not output column names.
```

## Examples[¶](#examples "Link to this heading")

Load sample data into a table using [csvsql](csvsql.html) and then query it using sql2csv:

```
csvsql --db "sqlite:///dummy.db" --tables "test" --insert examples/dummy.csv
sql2csv --db "sqlite:///dummy.db" --query "select * from test"
```

Load data about financial aid recipients into PostgreSQL. Then find the three states that received the most, while also filtering out empty rows:

```
createdb recipients
csvsql --db "postgresql:///recipients" --tables "fy09" --insert examples/realdata/FY09_EDU_Recipients_by_State.csv
sql2csv --db "postgresql:///recipients" --query "select * from fy09 where \"State Name\" != '' order by fy09.\"TOTAL\" limit 3"
```

You can even use it as a simple SQL calculator (in this example an in-memory SQLite database is used as the default):

```
sql2csv --query "select 300 * 47 % 14 * 27 + 7000"
```

The connection string [accepts parameters](https://docs.sqlalchemy.org/en/rel_1_0/core/engines.html#engine-creation-api). For example, to set the encoding of a MySQL database:

```
sql2csv --db 'mysql://user:pass@host/database?charset=utf8' --query "SELECT myfield FROM mytable"
```

[Next

csvclean](csvclean.html)
[Previous

in2csv](in2csv.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* sql2csv
  + [Description](#description)
  + [Examples](#examples)