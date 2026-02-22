# csvtk CWL Generation Report

## csvtk_corr

### Tool Description
calculate Pearson correlation between two columns

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Total Downloads**: 218.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shenwei356/csvtk
- **Stars**: N/A
### Original Help Text
```text
calculate Pearson correlation between two columns

Usage:
  csvtk corr [flags] 

Flags:
  -f, --fields string   comma separated fields
  -h, --help            help for corr
  -i, --ignore_nan      Ignore non-numeric fields to avoid returning NaN
  -L, --log             Calcute correlations on Log10 transformed data
  -x, --pass            passthrough mode (forward input to output)

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_dim

### Tool Description
dimensions of CSV file

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
dimensions of CSV file

Usage:
  csvtk dim [flags] 

Aliases:
  dim, size, stats, stat

Flags:
      --cols       only print number of columns (or using "csvtk ncol"
  -h, --help       help for dim
  -n, --no-files   do not print file names (only affect --cols and --rows)
      --rows       only print number of rows (or using "csvtk nrow")
      --tabular    output in machine-friendly tabular format

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_headers

### Tool Description
print headers

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
print headers

Usage:
  csvtk headers [flags] 

Flags:
  -h, --help      help for headers
  -v, --verbose   print verbose information

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_ncol

### Tool Description
print number of columns

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
print number of columns

Usage:
  csvtk ncol [flags] 

Aliases:
  ncol, ncols

Flags:
  -n, --file-name   print file names
  -h, --help        help for ncol

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_nrow

### Tool Description
print number of records

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
print number of records

Usage:
  csvtk nrow [flags] 

Aliases:
  nrow, nrows

Flags:
  -n, --file-name   print file names
  -h, --help        help for nrow

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_summary

### Tool Description
summary statistics of selected numeric or text fields (groupby group fields)

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
summary statistics of selected numeric or text fields (groupby group fields)

Attention:

  1. Do not mix use field (column) numbers and names.

Available operations:
 
  # numeric/statistical operations
  # provided by github.com/gonum/stat and github.com/gonum/floats
  countn (count numeric values), min, max, sum, argmin, argmax,
  mean, stdev, variance, median, q1, q2, q3,
  entropy (Shannon entropy), 
  prod (product of the elements)

  # textual/numeric operations
  count, first, last, rand, unique/uniq, collapse, countunique

Usage:
  csvtk summary [flags] 

Flags:
  -w, --decimal-width int    limit floats to N decimal points (default 2)
  -f, --fields strings       operations on these fields. e.g -f 1:count,1:sum or -f colA:mean. available
                             operations: argmax, argmin, collapse, count, countn, countuniq,
                             countunique, entropy, first, last, max, mean, median, min, prod, q1, q2,
                             q3, rand, stdev, sum, uniq, unique, variance
  -g, --groups string        group via fields. e.g -f 1,2 or -f columnA,columnB
  -h, --help                 help for summary
  -i, --ignore-non-numbers   ignore non-numeric values like "NA" or "N/A"
  -S, --rand-seed int        rand seed for operation "rand" (default 11)
  -s, --separater string     separater for collapsed data (default "; ")

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_watch

### Tool Description
monitor the specified fields

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
monitor the specified fields

Usage:
  csvtk watch [flags] 

Flags:
  -B, --bins int         number of histogram bins (default -1)
  -W, --delay int        sleep this many seconds after plotting (default 1)
  -y, --dump             print histogram data to stderr instead of plotting
  -f, --field string     field to watch
  -h, --help             help for watch
  -O, --image string     save histogram to this PDF/image file
  -L, --log              log10(x+1) transform numeric values
  -x, --pass             passthrough mode (forward input to output)
  -p, --print-freq int   print/report after this many records (-1 for print after EOF) (default -1)
  -Q, --quiet            supress all plotting to stderr
  -R, --reset            reset histogram after every report

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
  -Z, --show-row-number        show row number as the first column, with header row skipped
  -t, --tabs                   specifies that the input CSV file is delimited with tabs. Overrides "-d"
```


## csvtk_csv2json

### Tool Description
convert CSV to JSON format

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert CSV to JSON format

Usage:
  csvtk csv2json [flags] 

Flags:
  -b, --blanks              do not convert "", "na", "n/a", "none", "null", "." to null
  -h, --help                help for csv2json
  -i, --indent string       indent. if given blank, output json in one line. (default "  ")
  -k, --key string          output json as an array of objects keyed by a given field rather than as a
                            list. e.g -k 1 or -k columnA
  -n, --parse-num strings   parse numeric values for nth column, multiple values are supported and
                            "a"/"all" for all columns

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_csv2md

### Tool Description
convert CSV to markdown format. csv2md treats the first row as header line and requires them to be unique

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert CSV to markdown format

Attention:

  csv2md treats the first row as header line and requires them to be unique

Usage:
  csvtk csv2md [flags] 

Flags:
  -a, --alignments string   comma separated alignments. e.g. -a l,c,c,c or -a c (default "l")
  -h, --help                help for csv2md
  -w, --min-width int       min width (at least 3) (default 3)

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_csv2rst

### Tool Description
convert CSV to readable aligned table

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert CSV to readable aligned table

Attention:

  1. row span is not supported.

Usage:
  csvtk csv2rst [flags] 

Flags:
  -k, --cross string               charactor of cross (default "+")
  -s, --header string              charactor of separator between header row and data rowws (default "=")
  -h, --help                       help for csv2rst
  -b, --horizontal-border string   charactor of horizontal border (default "-")
  -p, --padding string             charactor of padding (default " ")
  -B, --vertical-border string     charactor of vertical border (default "|")

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_csv2tab

### Tool Description
convert CSV to tabular format

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert CSV to tabular format

Usage:
  csvtk csv2tab [flags] 

Flags:
  -h, --help   help for csv2tab

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_csv2xlsx

### Tool Description
convert CSV/TSV files to XLSX file. Multiple CSV/TSV files are saved as separated sheets in .xlsx file. All input files should all be CSV or TSV. First rows are freezed unless given '-H/--no-header-row'.

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert CSV/TSV files to XLSX file

Attention:

  1. Multiple CSV/TSV files are saved as separated sheets in .xlsx file.
  2. All input files should all be CSV or TSV.
  3. First rows are freezed unless given '-H/--no-header-row'.

Usage:
  csvtk csv2xlsx [flags] 

Flags:
  -f, --format-numbers   save numbers in number format, instead of text
  -h, --help             help for csv2xlsx

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_pretty

### Tool Description
convert CSV to a readable aligned table

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert CSV to a readable aligned table

How to:
  1. First -n/--buf-rows rows are read to check the minimum and maximum widths
     of each columns. You can also set the global thresholds -w/--min-width and
     -W/--max-width.
     1a. Cells longer than the maximum width will be wrapped (default) or
         clipped (--clip).
         Usually, the text is wrapped in space (-x/--wrap-delimiter). But if one
         word is longer than the -W/--max-width, it will be force split.
     1b. Texts are aligned left (default), center (-m/--align-center)
         or right (-r/--align-right). Users can specify columns with column names,
         field indexes or ranges.
        Examples:
          -m A,B       # column A and B
          -m 1,2       # 1st and 2nd column          
          -m -1        # the last column (it's not unselecting in other commands)
          -m 1,3-5     # 1st, from 3rd to 5th column
          -m 1-        # 1st and later columns (all columns)
          -m -3-       # the last 3 columns
          -m -3--2     # the 2nd and 3rd to last columns
          -m 1- -r -1  # all columns are center-aligned, except the last column
                       # which is right-aligned. -r overides -m.
         
  2. Remaining rows are read and immediately outputted, one by one, till the end.

Styles:

  Some preset styles are provided (-S/--style).

    default:

        id   size
        --   ----
        1    Huge
        2    Tiny

    plain:

        id   size
        1    Huge
        2    Tiny

    simple:

        -----------
         id   size
        -----------
         1    Huge
         2    Tiny
        -----------

    3line:

        ━━━━━━━━━━━
         id   size
        -----------
         1    Huge
         2    Tiny
        ━━━━━━━━━━━

    grid:

        +----+------+
        | id | size |
        +====+======+
        | 1  | Huge |
        +----+------+
        | 2  | Tiny |
        +----+------+

    light:

        ┌----┬------┐
        | id | size |
        ├====┼======┤
        | 1  | Huge |
        ├----┼------┤
        | 2  | Tiny |
        └----┴------┘

    bold:

        ┏━━━━┳━━━━━━┓
        ┃ id ┃ size ┃
        ┣━━━━╋━━━━━━┫
        ┃ 1  ┃ Huge ┃
        ┣━━━━╋━━━━━━┫
        ┃ 2  ┃ Tiny ┃
        ┗━━━━┻━━━━━━┛

    double:

        ╔════╦══════╗
        ║ id ║ size ║
        ╠════╬══════╣
        ║ 1  ║ Huge ║
        ╠════╬══════╣
        ║ 2  ║ Tiny ║
        ╚════╩══════╝

Usage:
  csvtk pretty [flags] 

Flags:
  -m, --align-center strings    align right for selected columns (field index/range or column name, type
                                "csvtk pretty -h" for examples)
  -r, --align-right strings     align right for selected columns (field index/range or column name, type
                                "csvtk pretty -h" for examples)
  -n, --buf-rows int            the number of rows to determine the min and max widths (0 for all rows)
                                (default 1024)
      --clip                    clip longer cell instead of wrapping
      --clip-mark string        clip mark (default "...")
  -h, --help                    help for pretty
  -W, --max-width int           max width
  -w, --min-width int           min width
  -s, --separator string        fields/columns separator (default "   ")
  -S, --style string            output syle. available vaules: default, plain, simple, 3line, grid,
                                light, bold, double. check https://github.com/shenwei356/stable
  -x, --wrap-delimiter string   delimiter for wrapping cells (default " ")

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_space2tab

### Tool Description
convert space delimited format to TSV

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert space delimited format to TSV

Usage:
  csvtk space2tab [flags] 

Flags:
  -b, --buffer-size string   size of buffer, supported unit: K, M, G. You need increase the value when
                             "bufio.Scanner: token too long" error reported (default "1G")
  -h, --help                 help for space2tab

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_splitxlsx

### Tool Description
split XLSX sheet into multiple sheets according to column values

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
split XLSX sheet into multiple sheets according to column values

Strengths: Sheet properties are remained unchanged.
Weakness : Complicated sheet structures are not well supported, e.g.,
  1. merged cells
  2. more than one header row

Usage:
  csvtk splitxlsx [flags] 

Flags:
  -f, --fields string       comma separated key fields, column name or index. e.g. -f 1-3 or -f id,id2
                            or -F -f "group*" (default "1")
  -F, --fuzzy-fields        using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help                help for splitxlsx
  -i, --ignore-case         ignore case (cell value)
  -a, --list-sheets         list all sheets
  -N, --sheet-index int     Nth sheet to retrieve (default 1)
  -n, --sheet-name string   sheet to retrieve

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_tab2csv

### Tool Description
convert tabular format to CSV

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert tabular format to CSV

Usage:
  csvtk tab2csv [flags] 

Flags:
  -h, --help   help for tab2csv

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_xlsx2csv

### Tool Description
convert XLSX to CSV format

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
convert XLSX to CSV format

Usage:
  csvtk xlsx2csv [flags] 

Flags:
  -h, --help                help for xlsx2csv
  -a, --list-sheets         list all sheets
  -i, --sheet-index int     Nth sheet to retrieve (default 1)
  -n, --sheet-name string   sheet to retrieve

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_comb

### Tool Description
compute combinations of items at every row

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
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

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_concat

### Tool Description
concatenate CSV/TSV files by rows. Note that the second and later files are concatenated to the first one, so only columns match that of the first files kept.

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
concatenate CSV/TSV files by rows

Note that the second and later files are concatenated to the first one,
so only columns match that of the first files kept.

Usage:
  csvtk concat [flags] 

Flags:
  -h, --help                    help for concat
  -i, --ignore-case             ignore case (column name)
  -k, --keep-unmatched          keep blanks even if no any data of a file matches
  -u, --unmatched-repl string   replacement for unmatched data

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_cut

### Tool Description
select and arrange fields

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
select and arrange fields

Examples:

  1. Single column
     csvtk cut -f 1
     csvtk cut -f colA
  2. Multiple columns (replicates allowed)
     csvtk cut -f 1,3,2,1
     csvtk cut -f colA,colB,colA
  3. Column ranges
     csvtk cut -f 1,3-5       # 1, 3, 4, 5
     csvtk cut -f 3,5-        # 3rd col, and 5th col to the end
     csvtk cut -f 1-          # for all
     csvtk cut -f 2-,1        # move 1th col to the end
  4. Unselect
     csvtk cut -f -1,-3       # discard 1st and 3rd column
     csvtk cut -f -1--3       # discard 1st to 3rd column
     csvtk cut -f -2-         # discard 2nd and all columns on the right.
     csvtu cut -f -colA,-colB # discard colA and colB

Usage:
  csvtk cut [flags] 

Flags:
  -m, --allow-missing-col   allow missing column
  -b, --blank-missing-col   blank missing column, only for using column fields
  -f, --fields string       select only these fields. type "csvtk cut -h" for examples
  -F, --fuzzy-fields        using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help                help for cut
  -i, --ignore-case         ignore case (column name)
  -u, --uniq-column         deduplicate columns matched by multiple fuzzy column names

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_filter

### Tool Description
filter rows by values of selected fields with arithmetic expression

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
filter rows by values of selected fields with arithmetic expression

Usage:
  csvtk filter [flags] 

Flags:
      --any             print record if any of the field satisfy the condition
  -f, --filter string   filter condition. e.g. -f "age>12" or -f "1,3<=2" or -F -f "c*!=0"
  -F, --fuzzy-fields    using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help            help for filter
  -n, --line-number     print line number as the first column ("n")

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_filter2

### Tool Description
filter rows by awk-like arithmetic/string expressions

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
filter rows by awk-like arithmetic/string expressions

The arithmetic/string expression is supported by:

  https://github.com/Knetic/govaluate

Variables formats:
  $1 or ${1}                        The first field/column
  $a or ${a}                        Column "a"
  ${a,b} or ${a b} or ${a (b)}      Column name with special charactors, 
                                    e.g., commas, spaces, and parentheses

Supported operators and types:

  Modifiers: + - / * & | ^ ** % >> <<
  Comparators: > >= < <= == != =~ !~ in
  Logical ops: || &&
  Numeric constants, as 64-bit floating point (12345.678)
  String constants (single quotes: 'foobar')
  Date constants (single quotes)
  Boolean constants: true false
  Parenthesis to control order of evaluation ( )
  Arrays (anything separated by , within parenthesis: (1, 2, 'foo'))
  Prefixes: ! - ~
  Ternary conditional: ? :
  Null coalescence: ??

Custom functions:
  - len(), length of strings, e.g., len($1), len($a), len($1, $2)
  - ulen(), length of unicode strings/width of unicode strings rendered
    to a terminal, e.g., len("沈伟")==6, ulen("沈伟")==4

Usage:
  csvtk filter2 [flags] 

Flags:
  -f, --filter string       awk-like filter condition. e.g. '$age>12' or '$1 > $3' or '$name=="abc"' or
                            '$1 % 2 == 0'
  -h, --help                help for filter2
  -n, --line-number         print line number as the first column ("n")
  -s, --numeric-as-string   treat even numeric fields as strings to avoid converting big numbers into
                            scientific notation

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_freq

### Tool Description
frequencies of selected fields

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
frequencies of selected fields

Usage:
  csvtk freq [flags] 

Flags:
  -f, --fields string   select these fields as the key. e.g -f 1,2 or -f columnA,columnB (default "1")
  -F, --fuzzy-fields    using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help            help for freq
  -i, --ignore-case     ignore case
  -r, --reverse         reverse order while sorting
  -n, --sort-by-freq    sort by frequency
  -k, --sort-by-key     sort by key

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_grep

### Tool Description
grep data by selected fields with patterns/regular expressions

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
grep data by selected fields with patterns/regular expressions

Attentions:

  1. By default, we directly compare the column value with patterns,
     use "-r/--use-regexp" for partly matching.
  2. Multiple patterns can be given by setting '-p/--pattern' more than once,
     or giving comma separated values (CSV formats). 
     Therefore, please use double quotation marks for patterns containing
     comma, e.g., -p '"A{2,}"'

Usage:
  csvtk grep [flags] 

Flags:
      --delete-matched        delete a pattern right after being matched, this keeps the firstly matched
                              data and speedups when using regular expressions
  -f, --fields string         comma separated key fields, column name or index. e.g. -f 1-3 or -f id,id2
                              or -F -f "group*" (default "1")
  -F, --fuzzy-fields          using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help                  help for grep
  -i, --ignore-case           ignore case
      --immediate-output      print output immediately, do not use write buffer
  -v, --invert                invert match
  -n, --line-number           print line number as the first column ("n")
  -N, --no-highlight          no highlight
  -p, --pattern strings       query pattern (multiple values supported). Attention: use double quotation
                              marks for patterns containing comma, e.g., -p '"A{2,}"'
  -P, --pattern-file string   pattern files (one pattern per line)
  -r, --use-regexp            patterns are regular expression
      --verbose               verbose output

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_head

### Tool Description
print first N records

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
print first N records

Usage:
  csvtk head [flags] 

Flags:
  -h, --help         help for head
  -n, --number int   print first N records (default 10)

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_inter

### Tool Description
intersection of multiple files. Fields in all files should be the same.

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
intersection of multiple files

Attention:

  1. fields in all files should be the same, 
     if not, extracting to another file using "csvtk cut".

Usage:
  csvtk inter [flags] 

Flags:
  -f, --fields string   select these fields as the key. e.g -f 1,2 or -f columnA,columnB (default "1")
  -F, --fuzzy-fields    using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help            help for inter
  -i, --ignore-case     ignore case

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_join

### Tool Description
join files by selected fields (inner, left and outer join).

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
join files by selected fields (inner, left and outer join).

Attention:

  1. Multiple keys supported
  2. Default operation is inner join, use --left-join for left join 
     and --outer-join for outer join.

Usage:
  csvtk join [flags] 

Aliases:
  join, merge

Flags:
  -f, --fields string     Semicolon separated key fields of all files, if given one, we think all the
                          files have the same key columns. Fields of different files should be separated
                          by ";", e.g -f "1;2" or -f "A,B;C,D" or -f id (default "1")
  -F, --fuzzy-fields      using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help              help for join
  -i, --ignore-case       ignore case
  -n, --ignore-null       do not match NULL values
  -k, --keep-unmatched    keep unmatched data of the first file (left join)
  -L, --left-join         left join, equals to -k/--keep-unmatched, exclusive with --outer-join
      --na string         content for filling NA data
  -P, --only-duplicates   add filenames as colname prefixes or add custom suffixes only for duplicated
                          colnames
  -O, --outer-join        outer join, exclusive with --left-join
  -p, --prefix-filename   add each filename as a prefix to each colname. if there's no header row, we'll
                          add one
  -e, --prefix-trim-ext   trim extension when adding filename as colname prefix
  -s, --suffix strings    add suffixes to colnames from each file

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_sample

### Tool Description
sampling by proportion

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
sampling by proportion

Usage:
  csvtk sample [flags] 

Flags:
  -h, --help               help for sample
  -n, --line-number        print line number as the first column ("row")
  -p, --proportion float   sample by proportion
  -s, --rand-seed int      rand seed (default 11)

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_split

### Tool Description
split CSV/TSV into multiple files according to column values

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
split CSV/TSV into multiple files according to column values

Notes:

  1. flag -o/--out-file can specify out directory for splitted files.
  2. flag -s/--prefix-as-subdir can create subdirectories with prefixes of
     keys of length X, to avoid writing too many files in the output directory.

Usage:
  csvtk split [flags] 

Flags:
  -g, --buf-groups int         buffering N groups before writing to file (default 100)
  -b, --buf-rows int           buffering N rows for every group before writing to file (default 100000)
  -f, --fields string          comma separated key fields, column name or index. e.g. -f 1-3 or -f
                               id,id2 or -F -f "group*" (default "1")
      --force                  overwrite existing output directory (given by -o).
  -F, --fuzzy-fields           using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help                   help for split
  -i, --ignore-case            ignore case
  -G, --out-gzip               force output gzipped file
  -p, --out-prefix string      output file prefix, the default value is the input file. use -p "" to
                               disable outputting prefix
  -s, --prefix-as-subdir int   create subdirectories with prefixes of keys of length X, to avoid writing
                               too many files in the output directory

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_uniq

### Tool Description
unique data without sorting

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
unique data without sorting

Usage:
  csvtk uniq [flags] 

Flags:
  -f, --fields string   select these fields as keys. e.g -f 1,2 or -f columnA,columnB (default "1")
  -F, --fuzzy-fields    using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help            help for uniq
  -i, --ignore-case     ignore case
  -n, --keep-n int      keep at most N records for a key (default 1)

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_add-header

### Tool Description
add column names

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
add column names

Usage:
  csvtk add-header [flags] 

Flags:
  -h, --help            help for add-header
  -n, --names strings   column names to add, in CSV format

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_del-header

### Tool Description
delete column names. It deletes the first lines of all input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
delete column names

Attention:
  1. It delete the first lines of all input files.

Usage:
  csvtk del-header [flags] 

Flags:
  -h, --help   help for del-header

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_del-quotes

### Tool Description
remove extra double quotes added by 'fix-quotes'

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
remove extra double quotes added by 'fix-quotes'

Limitation:
  1. Values containing line breaks are not supported.

Usage:
  csvtk del-quotes [flags] 

Flags:
  -h, --help   help for del-quotes

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_fix

### Tool Description
fix CSV/TSV with different numbers of columns in rows by appending empty cells to rows with fewer columns

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
fix CSV/TSV with different numbers of columns in rows

How to:
  1. First -n/--buf-rows rows are read to check the maximum number of columns.
     The default value 0 means all rows will be read.
  2. Buffered and remaining rows with fewer columns are appended with empty
     cells before output.
  3. An error will be reported if the number of columns of any remaining row
     is larger than the maximum number of columns.

Usage:
  csvtk fix [flags] 

Flags:
  -n, --buf-rows int   the number of rows to determine the maximum number of columns. 0 for all rows.
  -h, --help           help for fix

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_fix-quotes

### Tool Description
fix malformed CSV/TSV caused by double-quotes to meet the RFC4180 specification

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
fix malformed CSV/TSV caused by double-quotes

This command fixes fields not appropriately enclosed by double-quotes
to meet the RFC4180 specification (https://rfc-editor.org/rfc/rfc4180.html).

When and how to:
  1. Values containing bare double quotes. e.g.,
       a,abc" xyz,d
     Error information: bare " in non-quoted-field.
     Fix: adding the flag -l/--lazy-quotes.
     Using this command:
       a,abc" xyz,d   ->   a,"abc"" xyz",d
  2. Values with double quotes in the begining but not in the end. e.g.,
       a,"abc" xyz,d
     Error information: extraneous or missing " in quoted-field.
     Using this command:
       a,"abc" xyz,d  ->   a,"""abc"" xyz",d

Next:
  1. You can process the data without the flag -l/--lazy-quotes.
  2. Use 'csvtk del-quotes' if you want to restore the original format.

Limitation:
  1. Values containing line breaks are not supported.

Usage:
  csvtk fix-quotes [flags] 

Flags:
  -b, --buffer-size string   size of buffer, supported unit: K, M, G. You need increase the value when
                             "bufio.Scanner: token too long" error reported (default "1G")
  -h, --help                 help for fix-quotes

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_fmtdate

### Tool Description
format date of selected fields

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
format date of selected fields

Date parsing is supported by: https://github.com/araddon/dateparse
Date formating is supported by: https://github.com/metakeule/fmtdate

Time zones: 
    format: Asia/Shanghai
    whole list: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

Output format is in MS Excel (TM) syntax.
Placeholders:

    M    - month (1)
    MM   - month (01)
    MMM  - month (Jan)
    MMMM - month (January)
    D    - day (2)
    DD   - day (02)
    DDD  - day (Mon)
    DDDD - day (Monday)
    YY   - year (06)
    YYYY - year (2006)
    hh   - hours (15)
    mm   - minutes (04)
    ss   - seconds (05)

    AM/PM hours: 'h' followed by optional 'mm' and 'ss' followed by 'pm', e.g.

    hpm        - hours (03PM)
    h:mmpm     - hours:minutes (03:04PM)
    h:mm:sspm  - hours:minutes:seconds (03:04:05PM)

    Time zones: a time format followed by 'ZZZZ', 'ZZZ' or 'ZZ', e.g.

    hh:mm:ss ZZZZ (16:05:06 +0100)
    hh:mm:ss ZZZ  (16:05:06 CET)
    hh:mm:ss ZZ   (16:05:06 +01:00)

Usage:
  csvtk fmtdate [flags] 

Flags:
  -f, --fields string      select only these fields. e.g -f 1,2 or -f columnA,columnB (default "1")
      --format string      output date format in MS Excel (TM) syntax, type "csvtk fmtdate -h" for
                           details (default "YYYY-MM-DD hh:mm:ss")
  -F, --fuzzy-fields       using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
  -h, --help               help for fmtdate
  -k, --keep-unparsed      keep the key as value when no value found for the key
  -z, --time-zone string   timezone aka "Asia/Shanghai" or "America/Los_Angeles" formatted time-zone,
                           type "csvtk fmtdate -h" for details

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## csvtk_mutate

### Tool Description
create new column from selected fields by regular expression

### Metadata
- **Docker Image**: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/csvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/csvtk/overview
- **Validation**: PASS

### Original Help Text
```text
create new column from selected fields by regular expression

Usage:
  csvtk mutate [flags] 

Flags:
      --after string     insert the new column right after the given column name
      --at int           where the new column should appear, 1 for the 1st column, 0 for the last column
      --before string    insert the new column right before the given column name
  -f, --fields string    select only these fields. e.g -f 1,2 or -f columnA,columnB (default "1")
  -h, --help             help for mutate
  -i, --ignore-case      ignore case
      --na               for unmatched data, use blank instead of original data
  -n, --name string      new column name
  -p, --pattern string   search regular expression with capture bracket. e.g. (default "^(.+)$")
  -R, --remove           remove input column

Global Flags:
  -C, --comment-char string    lines starting with commment-character will be ignored. if your header
                               row starts with '#', please assign "-C" another rare symbol, e.g. '$'
                               (default "#")
  -U, --delete-header          do not output header row
  -d, --delimiter string       delimiting character of the input CSV file (default ",")
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
```


## Metadata
- **Skill**: generated
