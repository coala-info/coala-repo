- [View On GitHub](https://github.com/eBay/tsv-utils)

# eBay's TSV Utilities

Command line tools for large tabular data files.

---

Project maintained by [eBay](https://github.com/eBay)
Hosted on GitHub Pages — Theme by [mattgraham](https://twitter.com/michigangraham)

# Command line utilities for tabular data files

This is a set of command line utilities for manipulating large tabular data files. Files of numeric and text data commonly found in machine learning and data mining environments. Filtering, sampling, statistics, joins, and more.

These tools are especially useful when working with large data sets. They run faster than other tools providing similar functionality, often by significant margins. See [Performance Studies](/tsv-utils/docs/Performance.html) for comparisons with other tools.

File an [issue](https://github.com/eBay/tsv-utils/issues) if you have problems, questions or suggestions.

**In this README:**

* [Tools overview](#tools-overview) - Toolkit introduction and descriptions of each tool.
* [Obtaining and installation](#obtaining-and-installation)

**Additional documents:**

* [Tools Reference](/tsv-utils/docs/ToolReference.html) - Detailed documentation.
* [Releases](https://github.com/eBay/tsv-utils/releases) - Prebuilt binaries and release notes. Recent updates:
  + Current release: [version 2.2.0](https://github.com/eBay/tsv-utils/releases/tag/v2.2.0).
  + Improved `csv2tsv` performance and functionality. See [version 2.1 release notes](https://github.com/eBay/tsv-utils/releases/tag/v2.1.0).
  + Named fields! See [version 2.0 release notes](https://github.com/eBay/tsv-utils/releases/tag/v2.0.0).
* [Tips and tricks](/tsv-utils/docs/TipsAndTricks.html) - Simpler and faster command line tool use.
* [Performance Studies](/tsv-utils/docs/Performance.html) - Benchmarks against similar tools and other performance studies.
* [Comparing TSV and CSV formats](/tsv-utils/docs/comparing-tsv-and-csv.html)
* [Building with Link Time Optimization (LTO) and Profile Guided Optimization (PGO)](/tsv-utils/docs/BuildingWithLTO.html)
* [About the code](/tsv-utils/docs/AboutTheCode.html) (see also: [tsv-utils code documentation](https://tsv-utils.dpldocs.info/))
* [Other toolkits](/tsv-utils/docs/OtherToolkits.html)

**Talks and blog posts:**

* [Faster Command Line Tools in D](https://dlang.org/blog/2017/05/24/faster-command-line-tools-in-d/). May 24, 2017. A blog post showing a few ways to optimize performance in command line tools. Many of the ideas in the post were identified while developing the TSV Utilities.
* [Experimenting with Link Time Optimization](/tsv-utils/docs/dlang-meetup-14dec2017.pdf). Dec 14, 2017. A presentation at the [Silicon Valley D Meetup](https://www.meetup.com/D-Lang-Silicon-Valley/) describing experiments using LTO based on eBay's TSV Utilities.
* [Exploring D via Benchmarking of eBay's TSV Utilities](http://dconf.org/2018/talks/degenhardt.html). May 2, 2018. A presentation at [DConf 2018](http://dconf.org/2018/) describing performance benchmark studies conducted using eBay's TSV Utilities (slides [here](/tsv-utils/docs/dconf2018.pdf)).

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/eBay/tsv-utils/build-test)](https://github.com/eBay/tsv-utils/actions/workflows/build-test.yml)
[![Codecov](https://img.shields.io/codecov/c/github/eBay/tsv-utils.svg)](https://codecov.io/gh/eBay/tsv-utils)
[![GitHub release](https://img.shields.io/github/release/eBay/tsv-utils.svg)](https://github.com/eBay/tsv-utils/releases)
[![Github commits (since latest release)](https://img.shields.io/github/commits-since/eBay/tsv-utils/latest.svg)](https://github.com/eBay/tsv-utils/commits/master)
[![GitHub last commit](https://img.shields.io/github/last-commit/eBay/tsv-utils.svg)](https://github.com/eBay/tsv-utils/commits/master)
[![license](https://img.shields.io/github/license/eBay/tsv-utils.svg)](https://github.com/eBay/tsv-utils/blob/master/LICENSE.txt)

## Tools overview

These tools perform data manipulation and statistical calculations on tab delimited data. They are intended for large files. Larger than ideal for loading entirely in memory in an application like R, but not so big as to necessitate moving to Hadoop or similar distributed compute environments. The features supported are useful both for standalone analysis and for preparing data for use in R, Pandas, and similar toolkits.

The tools work like traditional Unix command line utilities such as `cut`, `sort`, `grep` and `awk`, and are intended to complement these tools. Each tool is a standalone executable. They follow common Unix conventions for pipeline programs. Data is read from files or standard input, results are written to standard output. Fields are identified either by field name or field number. The field separator defaults to TAB, but any character can be used. Input and output is UTF-8, and all operations are Unicode ready, including regular expression match (`tsv-filter`). Documentation is available for each tool by invoking it with the `--help` option. Most tools provide a `--help-verbose` option offering more extensive, reference style documentation. TSV format is similar to CSV, see [Comparing TSV and CSV formats](/tsv-utils/docs/comparing-tsv-and-csv.html) for the differences.

The rest of this section contains descriptions of each tool. Click on the links below to jump directly to one of the tools. Full documentation is available in the [Tools Reference](/tsv-utils/docs/ToolReference.html). The first tool listed, [tsv-filter](#tsv-filter), provides a tutorial introduction to features found throughout the toolkit.

* [tsv-filter](#tsv-filter) - Filter lines using numeric, string and regular expression comparisons against individual fields.
* [tsv-select](#tsv-select) - Keep a subset of columns (fields). Like `cut`, but supporting named fields, field reordering, and field exclusions.
* [tsv-uniq](#tsv-uniq) - Filter out duplicate lines using either the full line or individual fields as a key.
* [tsv-summarize](#tsv-summarize) - Summary statistics on selected fields, against the full data set or grouped by key.
* [tsv-sample](#tsv-sample) - Sample input lines or randomize their order. A number of sampling methods are available.
* [tsv-join](#tsv-join) - Join lines from multiple files using fields as a key.
* [tsv-pretty](#tsv-pretty) - Print TSV data aligned for easier reading on the command-line.
* [csv2tsv](#csv2tsv) - Convert CSV files to TSV.
* [tsv-split](#tsv-split) - Split data into multiple files. Random splits, random splits by key, and splits by blocks of lines.
* [tsv-append](#tsv-append) - Concatenate TSV files. Header-aware; supports source file tracking.
* [number-lines](#number-lines) - Number the input lines.
* [keep-header](#keep-header) - Run a shell command in a header-aware fashion.

### tsv-filter

Filter lines by running tests against individual fields. Multiple tests can be specified in a single call. A variety of numeric and string comparison tests are available, including regular expressions.

Consider a file having 4 fields: `id`, `color`, `year`, `count`. Using [tsv-pretty](#tsv-pretty) to view the first few lines:

```
$ tsv-pretty data.tsv | head -n 5
 id  color   year  count
100  green   1982    173
101  red     1935    756
102  red     2008   1303
103  yellow  1873    180
```

The following command finds all entries where 'year' (field 3) is 2008:

```
$ tsv-filter -H --eq year:2008 data.tsv
```

The `-H` option indicates the first input line is a header. The `--eq` operator performs a numeric equality test. String comparisons are also available. The following command finds entries where 'color' (field 2) is "red":

```
$ tsv-filter -H --str-eq color:red data.tsv
```

Fields can also be identified by field number, same as traditional Unix tools. This works for files with and without header lines. The following commands are equivalent to the previous two:

```
$ tsv-filter -H --eq 3:2008 data.tsv
$ tsv-filter -H --str-eq 2:red data.tsv
```

Multiple tests can be specified. The following command finds `red` entries with `year` between 1850 and 1950:

```
$ tsv-filter -H --str-eq color:red --ge year:1850 --lt year:1950 data.tsv
```

Viewing the first few results produced by this command:

```
$ tsv-filter -H --str-eq color:red --ge year:1850 --lt year:1950 data.tsv | tsv-pretty | head -n 5
 id  color  year  count
101  red    1935    756
106  red    1883   1156
111  red    1907   1792
114  red    1931   1412
```

The `--count` option switches from filtering to counting matched records. Header lines are excluded from the count. The following command prints the number of `red` entries in `data.tsv` (there are nine):

```
$ tsv-filter -H --count --str-eq color:red data.tsv
9
```

The `--label` option is another alternative to filtering. In this mode, a new field is added to every record indicating if it satisfies the criteria. The next command marks records to indicate if `year` is in the 1900s:

```
$  tsv-filter -H --label 1900s --ge year:1900 --lt year:2000 data.tsv | tsv-pretty | head -n 5
 id  color   year  count  1900s
100  green   1982    173      1
101  red     1935    756      1
102  red     2008   1303      0
103  yellow  1873    180      0
```

The `--label-values` option can be used to customize the values used to mark records.

Files can be placed anywhere on the command line. Data will be read from standard input if a file is not specified. The following commands are equivalent:

```
$ tsv-filter -H --str-eq color:red --ge year:1850 --lt year:1950 data.tsv
$ tsv-filter data.tsv -H --str-eq color:red --ge year:1850 --lt year:1950
$ cat data.tsv | tsv-filter -H --str-eq color:red --ge year:1850 --lt year:1950
```

Multiple files can be provided. Only the header line from the first file will be kept when the `-H` option is used:

```
$ tsv-filter -H data1.tsv data2.tsv data3.tsv --str-eq 2:red --ge 3:1850 --lt 3:1950
$ tsv-filter -H *.tsv --str-eq 2:red --ge 3:1850 --lt 3:1950
```

Numeric comparisons are among the most useful tests. Numeric operators include:

* Equality: `--eq`, `--ne` (equal, not-equal).
* Relational: `--lt`, `--le`, `--gt`, `--ge` (less-than, less-equal, greater-than, greater-equal).

Several filters are available to help with invalid data. Assume there is a messier version of the 4-field file where some fields are not filled in. The following command will filter out all lines with an empty value in any of the four fields:

```
$ tsv-filter -H messy.tsv --not-empty 1-4
```

The above command uses a "field list" to run the test on each of fields 1-4. The test can be "inverted" to see the lines that were filtered out:

```
$ tsv-filter -H messy.tsv --invert --not-empty 1-4 | head -n 5 | tsv-pretty
 id  color   year  count
116          1982     11
118  yellow          143
123  red              65
126                   79
```

There are several filters for testing characteristics of numeric data. The most useful are:

* `--is-numeric` - Test if the data in a field can be interpreted as a number.
* `--is-finite` - Test if the data in a field can be interpreted as a number, but not NaN (not-a-number) or infinity. This is useful when working with data where floating point calculations may have produced NaN or infinity values.

By default, all tests specified must be satisfied for a line to pass a filter. This can be changed using the `--or` option. For example, the following command finds records where 'count' (field 4) is less than 100 or greater than 1000:

```
$ tsv-filter -H --or --lt 4:100 --gt 4:1000 data.tsv | head -n 5 | tsv-pretty
 id  color  year  count
102  red    2008   1303
105  green  1982     16
106  red    1883   1156
107  white  1982      0
```

A number of string and regular expression tests are available. These include:

* Equality: `--str-eq`, `--str-ne`
* Partial match: `--str-in-fld`, `--str-not-in-fld`
* Relational operators: `--str-lt`, `--str-gt`, etc.
* Case insensitive tests: `--istr-eq`, `--istr-in-fld`, etc.
* Regular expressions: `--regex`, `--not-regex`, etc.
* Field length: `--char-len-lt`, `--byte-len-gt`, etc.

The earlier `--not-empty` example uses a "field list". Fields lists specify a set of fields and can be used with most operators. For example, the following command ensures that fields 1-3 and 7 are less-than 100:

```
$ tsv-filter -H --lt 1-3,7:100 file.tsv
```

Field names can be used in field lists as well. The following command selects lines where both 'color' and 'count' fields are not empty:

```
$ tsv-filter -H messy.tsv --not-empty color,count
```

Field names can be matched using wildcards. The previous command could also be written as:

```
$ tsv-filter -H messy.tsv --not-empty 'co*'
```

The `co*` matches both the 'color' and 'count' fields. (Note: Single quotes are used to prevent the shell from interpreting the asterisk character.)

All TSV Utilities tools use the same syntax for specifying fields. See [Field syntax](/tsv-utils/docs/tool_reference/common-options-and-behavior.html#field-syntax) in the [Tools Reference](/tsv-utils/docs/ToolReference.html) document for details.

Bash completion is especially helpful with `tsv-filter`. It allows quickly seeing and selecting from the different operators available. See [bash completion](/tsv-utils/docs/TipsAndTricks.html#enable-bash-completion) on the [Tips and tricks](/tsv-utils/docs/TipsAndTricks.html) page for setup information.

`tsv-filter` is perhaps the most broadly applicable of the TSV Utilities tools, as dataset pruning is such a common task. It is stream oriented, so it can handle arbitrarily large files. It is fast, quite a bit faster than other tools the author has tried. (See the "Numeric row filter" and "Regular expression row filter" tests in the [2018 Benchmark Summary](/tsv-utils/docs/Performance.html#2018-benchmark-summary).)

This makes `tsv-filter` ideal for preparing data for applications like R and Pandas. It is also convenient for quickly answering simple questions about a dataset.

See the [tsv-filter reference](/tsv-utils/docs/tool_reference/tsv-filter.html) for more details and the full list of operators.

### tsv-select

A version of the Unix `cut` utility with the ability to select fields by name, drop fields, and reorder fields. The following command writes the `date` and `time` fields from a pair of files to standard output:

```
$ tsv-select -H -f date,time file1.tsv file2.tsv
```

Fields can also be selected by field number:

```
$ tsv-select -f 4,2,9-11 file1.tsv file2.tsv
```

Fields can be listed more than once, and fields not specified can be selected as a group using `--r|rest`. Fields can be dropped using `--e|exclude`.

The `--H|header` option turns on header processing. This enables specifying fields by name. Only the header from the first file is retained when multiple input files are provided.

Examples:

```
$ # Output fields 2 and 1, in that order.
$ tsv-select -f 2,1 data.tsv

$ # Output the 'Name' and 'Record