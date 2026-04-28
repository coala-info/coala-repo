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

[View this page](../_sources/tutorial/4_going_elsewhere.rst.txt "View this page")

# 4. Going elsewhere with your data[¶](#going-elsewhere-with-your-data "Link to this heading")

## 4.1. csvjson: going online[¶](#csvjson-going-online "Link to this heading")

Very frequently one of the last steps in any data analysis is to get the data onto the web for display as a table, map or chart. CSV is rarely the ideal format for this. More often than not what you want is JSON and that’s where [csvjson](../scripts/csvjson.html) comes in. [csvjson](../scripts/csvjson.html) takes an input CSV and outputs neatly formatted JSON. For the sake of illustration, let’s use [csvcut](../scripts/csvcut.html) and [csvgrep](../scripts/csvgrep.html) to convert just a small slice of our data:

```
csvcut -c county,item_name data.csv | csvgrep -c county -m "GREELEY" | csvjson --indent 4
```

```
[
    {
        "county": "GREELEY",
        "item_name": "RIFLE,7.62 MILLIMETER"
    },
    {
        "county": "GREELEY",
        "item_name": "RIFLE,7.62 MILLIMETER"
    },
    {
        "county": "GREELEY",
        "item_name": "RIFLE,7.62 MILLIMETER"
    }
]
```

A common usage of turning a CSV into a JSON file is for usage as a lookup table in the browser. This can be illustrated with the ACS data we looked at earlier, which contains a unique `fips` code for each county:

```
csvjson --indent 4 --key fips acs2012_5yr_population.csv | head
```

```
{
    "31001": {
        "fips": "31001",
        "name": "Adams County, NE",
        "total_population": "31299",
        "margin_of_error": "0"
    },
    "31003": {
        "fips": "31003",
        "name": "Antelope County, NE",
        "...": "..."
    }
}
```

For making maps, [csvjson](../scripts/csvjson.html) can also output GeoJSON, see its [csvjson](../scripts/csvjson.html) for more details.

## 4.2. csvpy: going into code[¶](#csvpy-going-into-code "Link to this heading")

For the programmers out there, the command line is rarely as functional as just writing a little bit of code. [csvpy](../scripts/csvpy.html) exists just to make a programmer’s life easier. Invoking it simply launches a Python interactive terminal, with the data preloaded into a CSV reader:

```
$ csvpy data.csv
Welcome! "data.csv" has been loaded in a reader object named "reader".
>>> print(len(list(reader)))
1037
>>> quit()
```

In addition to being a time-saver, because this uses agate, the reader is Unicode aware.

## 4.3. csvformat: for legacy systems[¶](#csvformat-for-legacy-systems "Link to this heading")

It is a foundational principle of csvkit that it always outputs cleanly formatted CSV data. None of the normal csvkit tools can be forced to produce pipe or tab-delimited output, despite these being common formats. This principle is what allows the csvkit tools to chain together so easily and hopefully also reduces the amount of crummy, non-standard CSV files in the world. However, sometimes a legacy system just has to have a pipe-delimited file and it would be crazy to make you use another tool to create it. That’s why we’ve got [csvformat](../scripts/csvformat.html).

Pipe-delimited:

```
csvformat -D \| data.csv
```

Tab-delimited:

```
csvformat -T data.csv
```

Quote every cell:

```
csvformat -U 1 data.csv
```

Ampersand-delimited, dollar-signs for quotes, quote all strings, and asterisk for line endings:

```
csvformat -D \& -Q \$ -U 2 -M \* data.csv
```

You get the picture.

## 4.4. Summing up[¶](#summing-up "Link to this heading")

Thus concludes the csvkit tutorial. At this point, I hope, you have a sense a breadth of possibilities these tools open up with a relatively small number of command-line tools. Of course, this tutorial has only scratched the surface of the available options, so remember to check the [Reference](../cli.html) documentation for each tool as well.

So armed, go forth and expand the empire of the king of tabular file formats.

[Next

Reference](../cli.html)
[Previous

3. Power tools](3_power_tools.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* 4. Going elsewhere with your data
  + [4.1. csvjson: going online](#csvjson-going-online)
  + [4.2. csvpy: going into code](#csvpy-going-into-code)
  + [4.3. csvformat: for legacy systems](#csvformat-for-legacy-systems)
  + [4.4. Summing up](#summing-up)