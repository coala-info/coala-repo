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

* [Tutorial](../tutorial.html)[x]
* [Reference](../cli.html)[ ]
* [Tips and Troubleshooting](../tricks.html)
* [Contributing to csvkit](../contributing.html)
* [Release process](../release.html)
* [License](../license.html)
* [Changelog](../changelog.html)

Back to top

[View this page](../_sources/tutorial/3_power_tools.rst.txt "View this page")

# 3. Power tools[¶](#power-tools "Link to this heading")

## 3.1. csvjoin: merging related data[¶](#csvjoin-merging-related-data "Link to this heading")

One of the most common operations that we need to perform on data is “joining” it to other, related data. For instance, given a dataset about equipment supplied to counties in Nebraska, one might reasonably want to merge that with a dataset containing the population of each county. [csvjoin](../scripts/csvjoin.html) allows us to take those two datasets (equipment and population) and merge them, much like you might do with a SQL `JOIN` query. In order to demonstrate this, let’s grab a second dataset:

```
curl -L -O https://raw.githubusercontent.com/wireservice/csvkit/master/examples/realdata/acs2012_5yr_population.csv
```

Now let’s see what’s in there:

```
$ csvstat acs2012_5yr_population.csv
  1. "fips"

 Type of data:          Number
 Contains null values:  False
 Unique values:         93
 Smallest value:        31,001
 Largest value:         31,185
 Sum:                   2,891,649
 Mean:                  31,093
 Median:                31,093
 StDev:                 53.981
 Most common values:    31,001 (1x)
                        31,003 (1x)
                        31,005 (1x)
                        31,007 (1x)
                        31,009 (1x)

  2. "name"

 Type of data:          Text
 Contains null values:  False
 Unique values:         93
 Longest value:         23 characters
 Most common values:    Adams County, NE (1x)
                        Antelope County, NE (1x)
                        Arthur County, NE (1x)
                        Banner County, NE (1x)
                        Blaine County, NE (1x)

  3. "total_population"

 Type of data:          Number
 Contains null values:  False
 Unique values:         93
 Smallest value:        348
 Largest value:         518,271
 Sum:                   1,827,306
 Mean:                  19,648.452
 Median:                6,294
 StDev:                 62,501.005
 Most common values:    31,299 (1x)
                        6,655 (1x)
                        490 (1x)
                        778 (1x)
                        584 (1x)

  4. "margin_of_error"

 Type of data:          Number
 Contains null values:  False
 Unique values:         15
 Smallest value:        0
 Largest value:         115
 Sum:                   1,800
 Mean:                  19.355
 Median:                0
 StDev:                 37.897
 Most common values:    0 (73x)
                        73 (2x)
                        114 (2x)
                        97 (2x)
                        99 (2x)

Row count: 93
```

As you can see, this data file contains population estimates for each county in Nebraska from the 2012 5-year ACS estimates. This data was retrieved from [Census Reporter](https://censusreporter.org/) and reformatted slightly for this example. Let’s join it to our equipment data:

```
csvjoin -c fips data.csv acs2012_5yr_population.csv > joined.csv
```

Since both files contain a fips column, we can use that to join the two. In our output you should see the population data appended at the end of each row of data. Let’s combine this with what we’ve learned before to answer the question “What was the lowest population county to receive equipment?”:

```
$ csvcut -c county,item_name,total_population joined.csv | csvsort -c total_population | csvlook | head
| county     | item_name                                                      | total_population |
| ---------- | -------------------------------------------------------------- | ---------------- |
| MCPHERSON  | RIFLE,5.56 MILLIMETER                                          |              348 |
| WHEELER    | RIFLE,5.56 MILLIMETER                                          |              725 |
| GREELEY    | RIFLE,7.62 MILLIMETER                                          |            2,515 |
| GREELEY    | RIFLE,7.62 MILLIMETER                                          |            2,515 |
| GREELEY    | RIFLE,7.62 MILLIMETER                                          |            2,515 |
| NANCE      | RIFLE,5.56 MILLIMETER                                          |            3,730 |
| NANCE      | RIFLE,7.62 MILLIMETER                                          |            3,730 |
| NANCE      | RIFLE,7.62 MILLIMETER                                          |            3,730 |
```

Two counties with fewer than one-thousand residents were the recipients of 5.56 millimeter assault rifles. This simple example demonstrates the power of joining datasets. Although SQL will always be a more flexible option, [csvjoin](../scripts/csvjoin.html) will often get you where you need to go faster.

## 3.2. csvstack: combining subsets[¶](#csvstack-combining-subsets "Link to this heading")

Frequently large datasets are distributed in many small files. At some point you will probably want to merge those files for bulk analysis. [csvstack](../scripts/csvstack.html) allows you to “stack” the rows from CSV files with the same columns (and identical column names). To demonstrate, let’s imagine we’ve decided that Nebraska and Kansas form a “region” and that it would be useful to analyze them in a single dataset. Let’s grab the Kansas data:

```
curl -L -O https://raw.githubusercontent.com/wireservice/csvkit/master/examples/realdata/ks_1033_data.csv
```

Back in [Getting started](1_getting_started.html), we had used in2csv to convert our Nebraska data from XLSX to CSV. However, we named our output data.csv for simplicity at the time. Now that we are going to be stacking multiple states, we should re-convert our Nebraska data using a file naming convention matching our Kansas data:

```
in2csv ne_1033_data.xlsx > ne_1033_data.csv
```

Now let’s stack these two data files:

```
csvstack ne_1033_data.csv ks_1033_data.csv > region.csv
```

Using csvstat we can see that our `region.csv` contains both datasets:

```
$ csvstat -c state,acquisition_cost region.csv
  1. "state"

 Type of data:          Text
 Contains null values:  False
 Unique values:         2
 Longest value:         2 characters
 Most common values:    KS (1575x)
                        NE (1036x)

  8. "acquisition_cost"

 Type of data:          Number
 Contains null values:  False
 Unique values:         127
 Smallest value:        0
 Largest value:         658,000
 Sum:                   9,440,445.91
 Mean:                  3,615.644
 Median:                138
 StDev:                 23,730.631
 Most common values:    120 (649x)
                        499 (449x)
                        138 (311x)
                        6,800 (304x)
                        58.71 (218x)

Row count: 2611
```

If you supply the `-g` flag then [csvstack](../scripts/csvstack.html) can also add a “grouping column” to each row, so that you can tell which file each row came from. In this case we don’t need this, but you can imagine a situation in which instead of having a `county` column each of this datasets had simply been named `nebraska.csv` and `kansas.csv`. In that case, using a grouping column would prevent us from losing information when we stacked them.

## 3.3. csvsql and sql2csv: ultimate power[¶](#csvsql-and-sql2csv-ultimate-power "Link to this heading")

Sometimes (almost always), the command-line isn’t enough. It would be crazy to try to do all your analysis using command-line tools. Often times, the correct tool for data analysis is SQL. [csvsql](../scripts/csvsql.html) and [sql2csv](../scripts/sql2csv.html) form a bridge that eases migrating your data into and out of a SQL database. For smaller datasets [csvsql](../scripts/csvsql.html) can also leverage [sqlite](https://www.sqlite.org/) to allow execution of ad hoc SQL queries without ever touching a database.

By default, [csvsql](../scripts/csvsql.html) will generate a create table statement for your data. You can specify what sort of database you are using with the `-i` flag:

```
csvsql -i sqlite joined.csv
```

```
CREATE TABLE joined (
    state VARCHAR NOT NULL,
    county VARCHAR NOT NULL,
    fips FLOAT NOT NULL,
    nsn VARCHAR NOT NULL,
    item_name VARCHAR,
    quantity FLOAT NOT NULL,
    ui VARCHAR NOT NULL,
    acquisition_cost FLOAT NOT NULL,
    total_cost FLOAT NOT NULL,
    ship_date DATE NOT NULL,
    federal_supply_category FLOAT NOT NULL,
    federal_supply_category_name VARCHAR NOT NULL,
    federal_supply_class FLOAT NOT NULL,
    federal_supply_class_name VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    total_population FLOAT NOT NULL,
    margin_of_error FLOAT NOT NULL
);
```

Here we have the sqlite “create table” statement for our joined data. You’ll see that, like [csvstat](../scripts/csvstat.html), [csvsql](../scripts/csvsql.html) has done its best to infer the column types.

Often you won’t care about storing the SQL statements locally. You can also use [csvsql](../scripts/csvsql.html) to create the table directly in the database on your local machine. If you add the `--insert` option the data will also be imported:

```
csvsql --db sqlite:///leso.db --insert joined.csv
```

How can we check that our data was imported successfully? We could use the sqlite command-line interface, but rather than worry about the specifics of another tool, we can also use [sql2csv](../scripts/sql2csv.html):

```
sql2csv --db sqlite:///leso.db --query "select * from joined"
```

Note that the `--query` parameter to [sql2csv](../scripts/sql2csv.html) accepts any SQL query. For example, to export Douglas county from the `joined` table from our sqlite database, we would run:

```
sql2csv --db sqlite:///leso.db --query "select * from joined where county='DOUGLAS';" > douglas.csv
```

Sometimes, if you will only be running a single query, even constructing the database is a waste of time. For that case, you can actually skip the database entirely and [csvsql](../scripts/csvsql.html) will create one in memory for you:

```
csvsql --query "select county,item_name from joined where quantity > 5;" joined.csv | csvlook
```

SQL queries directly on CSVs! Keep in mind when using this that you are loading the entire dataset into an in-memory SQLite database, so it is likely to be very slow for large datasets.

## 3.4. Summing up[¶](#summing-up "Link to this heading")

[csvjoin](../scripts/csvjoin.html), [csvstack](../scripts/csvstack.html), [csvsql](../scripts/csvsql.html) and [sql2csv](../scripts/sql2csv.html) represent the power tools of csvkit. Using these tools can vastly simplify processes that would otherwise require moving data between other systems. But what about cases where these tools still don’t cut it? What if you need to move your data onto the web or into a legacy database system? We’ve got a few solutions for those problems in our final section, [Going elsewhere with your data](4_going_elsewhere.html).

[Next

4. Going elsewhere with your data](4_going_elsewhere.html)
[Previous

2. Examining the data](2_examining_the_data.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* 3. Power tools
  + [3.1. csvjoin: merging related data](#csvjoin-merging-related-data)
  + [3.2. csvstack: combining subsets](#csvstack-combining-subsets)
  + [3.3. csvsql and sql2csv: ultimate power](#csvsql-and-sql2csv-ultimate-power)
  + [3.4. Summing up](#summing-up)