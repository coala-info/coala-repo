[ ]
[ ]

[Skip to content](#usage-and-examples)

csvtk - CSV/TSV Toolkit

Usage

Initializing search

[GitHub](https://github.com/shenwei356/csvtk "Go to repository")

csvtk - CSV/TSV Toolkit

[GitHub](https://github.com/shenwei356/csvtk "Go to repository")

* [Home](..)
* [Download](../download/)
* [ ]

  Usage

  [Usage](./)

  Table of contents
  + [Before use](#before-use)
  + [Table of Contents](#table-of-contents)
  + [csvtk](#csvtk)
  + [add-header](#add-header)
  + [cat](#cat)
  + [comb](#comb)
  + [comma](#comma)
  + [concat](#concat)
  + [corr](#corr)
  + [csv2json](#csv2json)
  + [csv2md](#csv2md)
  + [csv2rst](#csv2rst)
  + [csv2tab](#csv2tab)
  + [csv2xlsx](#csv2xlsx)
  + [cut](#cut)
  + [del-header](#del-header)
  + [del-quotes](#del-quotes)
  + [dim/nrow/ncol](#dimnrowncol)
  + [filter](#filter)
  + [filter2](#filter2)
  + [fix](#fix)
  + [fix-quotes](#fix-quotes)
  + [fmtdate](#fmtdate)
  + [fold](#fold)
  + [freq](#freq)
  + [gather](#gather)
  + [genautocomplete](#genautocomplete)
  + [grep](#grep)
  + [head](#head)
  + [headers](#headers)
  + [inter](#inter)
  + [join](#join)
  + [mutate](#mutate)
  + [mutate2](#mutate2)
  + [mutate3](#mutate3)
  + [plot](#plot)
  + [plot box](#plot-box)
  + [plot hist](#plot-hist)
  + [plot line](#plot-line)
  + [plot bar](#plot-bar)
  + [pretty](#pretty)
  + [rename](#rename)
  + [rename2](#rename2)
  + [replace](#replace)
  + [round](#round)
  + [sample](#sample)
  + [sep](#sep)
  + [sort](#sort)
  + [space2tab](#space2tab)
  + [split](#split)
  + [splitxlsx](#splitxlsx)
  + [spread](#spread)
  + [summary](#summary)
  + [tab2csv](#tab2csv)
  + [transpose](#transpose)
  + [unfold](#unfold)
  + [uniq](#uniq)
  + [version](#version)
  + [watch](#watch)
  + [xlsx2csv](#xlsx2csv)
* [FAQs](../faq/)
* [Tutorial](../tutorial/)
* [中文介绍](../chinese/)
* [More tools](https://github.com/shenwei356)

Table of contents

* [Before use](#before-use)
* [Table of Contents](#table-of-contents)
* [csvtk](#csvtk)
* [add-header](#add-header)
* [cat](#cat)
* [comb](#comb)
* [comma](#comma)
* [concat](#concat)
* [corr](#corr)
* [csv2json](#csv2json)
* [csv2md](#csv2md)
* [csv2rst](#csv2rst)
* [csv2tab](#csv2tab)
* [csv2xlsx](#csv2xlsx)
* [cut](#cut)
* [del-header](#del-header)
* [del-quotes](#del-quotes)
* [dim/nrow/ncol](#dimnrowncol)
* [filter](#filter)
* [filter2](#filter2)
* [fix](#fix)
* [fix-quotes](#fix-quotes)
* [fmtdate](#fmtdate)
* [fold](#fold)
* [freq](#freq)
* [gather](#gather)
* [genautocomplete](#genautocomplete)
* [grep](#grep)
* [head](#head)
* [headers](#headers)
* [inter](#inter)
* [join](#join)
* [mutate](#mutate)
* [mutate2](#mutate2)
* [mutate3](#mutate3)
* [plot](#plot)
* [plot box](#plot-box)
* [plot hist](#plot-hist)
* [plot line](#plot-line)
* [plot bar](#plot-bar)
* [pretty](#pretty)
* [rename](#rename)
* [rename2](#rename2)
* [replace](#replace)
* [round](#round)
* [sample](#sample)
* [sep](#sep)
* [sort](#sort)
* [space2tab](#space2tab)
* [split](#split)
* [splitxlsx](#splitxlsx)
* [spread](#spread)
* [summary](#summary)
* [tab2csv](#tab2csv)
* [transpose](#transpose)
* [unfold](#unfold)
* [uniq](#uniq)
* [version](#version)
* [watch](#watch)
* [xlsx2csv](#xlsx2csv)

# Usage and Examples

## Before use

**Attention**

1. By default, csvtk assumes input files have header row, if not, switch flag `-H` on.
2. By default, csvtk handles CSV files, use flag `-t` for tab-delimited files.
3. Column names should be unique.
4. By default, lines starting with `#` will be ignored, if the header row
   starts with `#`, please assign flag `-C` another rare symbol, e.g. `$`.
5. Do not mix use field (column) numbers and names to specify columns to operate.
6. The CSV parser requires all the lines have same numbers of fields/columns.
   Even lines with spaces will cause error.
   Use `-I/--ignore-illegal-row` to skip these lines if neccessary.
   You can also use "csvtk fix" to fix files with different numbers of columns in rows.
7. If double-quotes exist in fields not enclosed with double-quotes, e.g.,

   ```
   x,a "b" c,1
   ```

   It would report error:

   ```
   bare `"` in non-quoted-field.
   ```

   Please switch on the flag `-l` or use `csvtk fix-quotes` to fix it.
8. If somes fields have only a double-quote eighter in the beginning or in the end, e.g.,

   ```
   x,d "e","a" b c,1
   ```

   It would report error:

   ```
   extraneous or missing " in quoted-field
   ```

   Please use `csvtk fix-quotes` to fix it, and use `csvtk del-quotes` to reset to the
   original format as needed.

## Table of Contents

* [csvtk](#csvtk)

**Information**

* [corr](#corr)
* [dim/nrow/ncol](#dim/nrow/ncol)
* [headers](#headers)
* [summary](#summary)
* [watch](#watch)

**Format conversion**

* [csv2json](#csv2json)
* [csv2md](#csv2md)
* [csv2rst](#csv2rst)
* [csv2tab](#csv2tab)
* [csv2xlsx](#csv2xlsx)
* [pretty](#pretty)
* [space2tab](#space2tab)
* [splitxlsx](#splitxlsx)
* [tab2csv](#tab2csv)
* [xlsx2csv](#xlsx2csv)

**Set operations**

* [comb](#comb)
* [concat](#concat)
* [cut](#cut)
* [filter](#filter)
* [filter2](#filter2)
* [freq](#freq)
* [grep](#grep)
* [head](#head)
* [inter](#inter)
* [join](#join)
* [sample](#sample)
* [split](#split)
* [splitxlsx](#splitxlsx)
* [uniq](#uniq)

**Edit**

* [add-header](#add-header)
* [comma](#comma)
* [del-quotes](#del-quotes)
* [del-header](#del-header)
* [fix](#fix)
* [fix-quotes](#fix-quotes)
* [fmtdate](#fmtdate)
* [mutate](#mutate)
* [mutate2](#mutate2)
* [mutate3](#mutate3)
* [rename](#rename)
* [rename2](#rename2)
* [replace](#replace)
* [round](#round)

**Transform**

* [fold](#fold)
* [gather](#gather)
* [sep](#sep)
* [spread](#spread)
* [transpose](#transpose)
* [unfold](#unfold)

**Ordering**

* [sort](#sort)

**Ploting**

* [plot](#plot)
* [plot hist](#plot-hist)
* [plot box](#plot-box)
* [plot line](#plot-line)
* [plot bar](#plot-bar)

**Misc**

* [cat](#cat)
* [genautocomplete](#genautocomplete)
* [version](#version)

## csvtk

Usage

```
csvtk -- a cross-platform, efficient and practical CSV/TSV toolkit

Version: 0.34.0

Author: Wei Shen <shenwei356@gmail.com>

Documents  : http://shenwei356.github.io/csvtk
Source code: https://github.com/shenwei356/csvtk

Attention:

  1. By default, csvtk assumes input files have header row, if not, switch flag "-H" on.
  2. By default, csvtk handles CSV files, use flag "-t" for tab-delimited files.
  3. Column names should be unique.
  4. By default, lines starting with "#" will be ignored, if the header row
     starts with "#", please assign flag "-C" another rare symbol, e.g. '$'.
  5. Do not mix use field (column) numbers and names to specify columns to operate.
  6. The CSV parser requires all the lines have same numbers of fields/columns.
     Even lines with spaces will cause error.
     Use '-I/--ignore-illegal-row' to skip these lines if neccessary.
     You can also use "csvtk fix" to fix files with different numbers of columns in rows.
  7. If double-quotes exist in fields not enclosed with double-quotes, e.g.,
         x,a "b" c,1
     It would report error:
         bare " in non-quoted-field.
     Please switch on the flag "-l" or use "csvtk fix-quotes" to fix it.
  8. If somes fields have only a double-quote eighter in the beginning or in the end, e.g.,
         x,d "e","a" b c,1
     It would report error:
         extraneous or missing " in quoted-field
     Please use "csvtk fix-quotes" to fix it, and use "csvtk del-quotes" to reset to the
     original format as needed.

Environment variables for frequently used global flags:

  - "CSVTK_T" for flag "-t/--tabs"
  - "CSVTK_H" for flag "-H/--no-header-row"
  - "CSVTK_QUIET" for flag "--quiet"

You can also create a soft link named "tsvtk" for "csvtk",
which sets "-t/--tabs" by default.

Usage:
  csvtk [flags]
  csvtk [command]

Commands for Information:
  corr            calculate Pearson correlation between two columns
  dim             dimensions of CSV file
  headers         print headers
  ncol            print number of columns
  nrow            print number of records
  summary         summary statistics of selected numeric or text fields (groupby group fields)
  watch           monitor the specified fields

Format Conversion:
  csv2json        convert CSV to JSON format
  csv2md          convert CSV to markdown format
  csv2rst         convert CSV to reStructuredText format
  csv2tab         convert CSV to tabular format
  csv2xlsx        convert CSV/TSV files to XLSX file
  pretty          convert CSV to a readable aligned table
  space2tab       convert space delimited format to TSV
  splitxlsx       split XLSX sheet into multiple sheets according to column values
  tab2csv         convert tabular format to CSV
  xlsx2csv        convert XLSX to CSV format

Commands for Set Operation:
  comb            compute combinations of items at every row
  concat          concatenate CSV/TSV files by rows
  cut             select and arrange fields
  filter          filter rows by values of selected fields with arithmetic expression
  filter2         filter rows by awk-like arithmetic/string expressions
  freq            frequencies of selected fields
  grep            grep data by selected fields with patterns/regular expressions
  head            print first N records
  inter           intersection of multiple files
  join            join files by selected fields (inner, left and outer join)
  sample          sampling by proportion
  split           split CSV/TSV into multiple files according to column values
  uniq            unique data without sorting

Commands for Edit:
  add-header      add column names
  comma           make numbers more readable by adding commas
  del-header      delete column names
  del-quotes      remove extra double quotes added by 'fix-quotes'
  fix             fix CSV/TSV with different numbers of columns in rows
  fix-quotes      fix malformed CSV/TSV caused by double-quotes
  fmtdate         format date of selected fields
  mutate          create new column from selected fields by regular expression
  mutate2         create a new column from selected fields by awk-like arithmetic/string expressions
  mutate3         create a new column from selected fields with Go-like expressions
  rename          rename column names with new names
  rename2         rename column names by regular expression
  replace         replace data of selected fields by regular expression
  round           round float to n decimal places

Commands for Data Transformation:
  fold            fold multiple values of a field into cells of groups
  gather          gather columns into key-value pairs, like tidyr::gather/pivot_longer
  sep             separate column into multiple columns
  spread          spread a key-value pair across multiple columns, like tidyr::spread/pivot_wider
  transpose       transpose CSV data
  unfold          unfold multiple values in cells of a field

Commands for Ordering:
  sort            sort by selected fields

Commands for Ploting:
  plot            plot common figures

Commands for Miscellaneous Functions:
  cat             stream file to stdout and report progress on stderr

Additional Commands:
  genautocomplete generate shell autocompletion script (bash|zsh|fish|powershell)
  version         print version information and check for update

Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
  -h, --help                   help for csvtk
  -E, --ignore-empty-row       ignore empty rows
  -I, --ignore-illegal-row     ignore illegal rows. You can also use 'csvtk fix' to fix files with
                               different numbers of columns in rows
  -X, --infile-list string     file of input files list (one file per line), if given, they are appended
                               to files from cli arguments
  -l, --lazy-quotes            if given, a quote may appear in an unquoted field and a non-doubled quote
                               may appear in a quoted field
  -H, --no-header-row          specifies that the input CSV file does not have header row
  -j, --num-cpus int           number of CPUs to use (default 4)
  -D, --out-delimiter string   delimiting character of the output CSV file, e.g., -D $'\t' for tab
                               (default ",")
  -o, --out-file string        out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -T, --out-tabs               specifies that the output is delimited with tabs. Overrides "-D"
      --quiet                  be quiet and do not show extra information and warnings
  -Z, --show-row-number        show row number as the first column, with header row skipped
  -t, --tabs                   specifies that the input CSV file is delimited with tabs. Overrides "-d"
  -V, --version                print version information

Use "csvtk [command] --help" for more information about a command.
```

## add-header

Usage

```
add column names

Usage:
  csvtk add-header [flags]

Flags:
  -h, --help            help for add-header
  -n, --names strings   column names to add, in CSV format
```

Examples:

1. No new colnames given:

   ```
   $ seq 3 | csvtk mutate -H \
       | csvtk add-header
   [WARN] colnames not given, c1, c2, c3... will be used
   c1,c2
   1,1
   2,2
   3,3
   ```
2. Adding new colnames:

   ```
   $ seq 3 | csvtk mutate -H \
       | csvtk add-header -n a,b
   a,b
   1,1
   2,2
   3,3
   $ seq 3 | csvtk mutate -H \
       | csvtk add-header -n a -n b
   a,b
   1,1
   2,2
   3,3

   $ seq 3 | csvtk mutate -H -t \
       | csvtk add-header -t -n a,b
   a       b
   1       1
   2       2
   3       3
   ```

## cat

Usage

```
stream file to stdout and report progress on stderr

Usage:
  csvtk cat [flags]

Flags:
  -b, --buffsize int     buffer size (default 8192)
  -h, --help             help for cat
  -L, --lines            count lines instead of bytes
  -p, --print-freq int   print frequency (-1 for print after parsing) (default 1)
  -s, --total int        expected total bytes/lines (default -1)
```

Examples

1. Stream file, report progress in bytes

   ```
   csvtk cat file.tsv
   ```
2. Stream file from stdin, report progress in lines

   ```
   tac input.tsv | csvtk cat -L -s `wc -l < input.tsv` -
   ```

## comb

Usage

```
compute combinations of items at every row

Usage:
  csvtk comb [flags]

Aliases:
  comb, combination

Flags:
  -h, --help          help for comb
  -i, --ignore-case   ignore-case
  -S, --nat-sort      sort items in natural order
  -n, --number int    number of items in a combination, 0 for no limit, i.e., return all combinations
                      (default 2)
  -s, --sort          sort items in a combination
```

Examples:
