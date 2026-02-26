# datamash CWL Generation Report

## datamash_groupby

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/datamash/overview
- **Total Downloads**: 24.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/agordon/datamash
- **Stars**: N/A
### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_crosstab

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_transpose

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_reverse

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_check

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_rmdup

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_base64

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_debase64

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_md5

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sha1

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sha224

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sha256

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sha384

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sha512

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_bin

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_strbin

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_round

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_floor

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_ceil

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_trunc

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_frac

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_dirname

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_basename

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_barename

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_extname

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_getnum

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_cut

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sum

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_min

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_max

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_absmin

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_absmax

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_range

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_count

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_first

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_last

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_rand

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_unique

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_collapse

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_countunique

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_mean

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_geomean

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_harmmean

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_trimmean

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_median

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_q1

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_q3

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_iqr

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_perc

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_mode

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_antimode

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_pstdev

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sstdev

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_pvar

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_svar

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_ms

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_rms

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_mad

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_madraw

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_pskew

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_sskew

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_pkurt

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_skurt

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_dpo

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_jarque

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_scov

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_pcov

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_spearson

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_ppearson

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```


## datamash_dotprod

### Tool Description
Performs numeric/string operations on input from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/datamash:1.9
- **Homepage**: https://github.com/agordon/datamash
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: datamash [OPTION] op [fld] [op fld ...]

Performs numeric/string operations on input from stdin.

'op' is the operation to perform.  If a primary operation is used,
it must be listed first, optionally followed by other operations.
'fld' is the input field to use.  'fld' can be a number (1=first field),
or a field name when using the -H or --header-in options.
Multiple fields can be listed with a comma (e.g. 1,6,8).  A range of
fields can be listed with a dash (e.g. 2-8).  Use colons for operations
which require a pair of fields (e.g. 'pcov 2:6').


Primary operations:
  groupby, crosstab, transpose, reverse, check
Line-Filtering operations:
  rmdup
Per-Line operations:
  base64, debase64, md5, sha1, sha224, sha256, sha384, sha512,
  bin, strbin, round, floor, ceil, trunc, frac,
  dirname, basename, barename, extname, getnum, cut
Numeric Grouping operations:
  sum, min, max, absmin, absmax, range
Textual/Numeric Grouping operations:
  count, first, last, rand, unique, collapse, countunique
Statistical Grouping operations:
  mean, geomean, harmmean, trimmean, median, q1, q3, iqr, perc,
  mode, antimode, pstdev, sstdev, pvar, svar, ms, rms, mad, madraw,
  pskew, sskew, pkurt, skurt, dpo, jarque,
  scov, pcov, spearson, ppearson, dotprod


Options:

Grouping Options:
  -C, --skip-comments       skip comment lines (starting with '#' or ';'
                              and optional whitespace)
  -f, --full                print entire input line before op results
                              (default: print only the grouped keys)
                            This option is only sensible for linewise
                            operations. Other uses are deprecated and
                            will be removed in a future version of GNU
                            Datamash.
  -g, --group=X[,Y,Z]       group via fields X,[Y,Z];
                              equivalent to primary operation 'groupby'
      --header-in           first input line is column headers
      --header-out          print column headers as first line
  -H, --headers             same as '--header-in --header-out'
  --vnlog                   Reads and writes data in the vnlog format.
                              Implies -C -H -W
  -i, --ignore-case         ignore upper/lower case when comparing text;
                              this affects grouping, and string operations
  -s, --sort                sort the input before grouping; this removes the
                              need to manually pipe the input through 'sort'
  -S, --seed                set a seed for operations that use randomization
  -c, --collapse-delimiter=X  use X to separate elements in collapse and
                              unique lists (default: comma)
File Operation Options:
      --no-strict           allow lines with varying number of fields
      --filler=X            fill missing values with X (default N/A)

General Options:
  -t, --field-separator=X   use X instead of TAB as field delimiter
      --format=FORMAT       print numeric values with printf style
                            floating-point FORMAT.
      --output-delimiter=X  use X instead as output field delimiter
                            (default: use same delimiter as -t/-W)
      --narm                skip NA/NaN values
  -R, --round=N             round numeric output to N decimal places
  -W, --whitespace          use whitespace (one or more spaces and/or tabs)
                              for field delimiters
  -z, --zero-terminated     end lines with 0 byte, not newline
      --sort-cmd=/path/to/sort   Alternative sort(1) to use.
  -h, --help     display this help and exit
  -V, --version  output version information and exit


Environment:
  LC_NUMERIC        decimal-point character and thousands separator


Examples:

Print the sum and the mean of values from column 1:
  $ seq 10 | datamash sum 1 mean 1
  55  5.5

Transpose input:
  $ seq 10 | paste - - | datamash transpose
  1    3    5    7    9
  2    4    6    8    10

For detailed usage information and examples, see
  man datamash
The manual and more examples are available at
  https://www.gnu.org/software/datamash
```

