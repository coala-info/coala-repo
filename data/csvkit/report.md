# csvkit CWL Generation Report

## csvkit

### Tool Description
FAIL to generate CWL: csvkit not found in Docker image. The image may not provide this executable.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/main/packages/csvkit/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2026-04-10
- **GitHub**: https://github.com/wireservice/csvkit
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: csvkit not found in Docker image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: csvkit not found in Docker image. The image may not provide this executable.



### Original Help Text
```text

```
## Metadata
- **Skill**: generated

## csvkit_csvlook

### Tool Description
Render a CSV file in the console as a Markdown-compatible, fixed-width table.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: csvlook [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
               [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
               [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
               [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
               [--no-leading-zeroes] [-H] [-K SKIP_LINES] [-v] [-l]
               [--add-bom] [--zero] [-V] [--max-rows MAX_ROWS]
               [--max-columns MAX_COLUMNS]
               [--max-column-width MAX_COLUMN_WIDTH]
               [--max-precision MAX_PRECISION] [--no-number-ellipsis]
               [-y SNIFF_LIMIT] [-I]
               [FILE]

Render a CSV file in the console as a Markdown-compatible, fixed-width table.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -L, --locale LOCALE   Specify the locale (en_US) of any formatted numbers.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  --blanks              Do not convert "", "na", "n/a", "none", "null", "." to
                        NULL.
  --null-value NULL_VALUES [NULL_VALUES ...]
                        Convert this value to NULL. --null-value can be
                        specified multiple times.
  --date-format DATE_FORMAT
                        Specify a strptime date format string like "%m/%d/%Y".
  --datetime-format DATETIME_FORMAT
                        Specify a strptime datetime format string like
                        "%m/%d/%Y %I:%M %p".
  --no-leading-zeroes   Do not convert a numeric value with leading zeroes to
                        a number.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  --max-rows MAX_ROWS   The maximum number of rows to display before
                        truncating the data.
  --max-columns MAX_COLUMNS
                        The maximum number of columns to display before
                        truncating the data.
  --max-column-width MAX_COLUMN_WIDTH
                        Truncate all columns to at most this width. The
                        remainder will be replaced with ellipsis.
  --max-precision MAX_PRECISION
                        The maximum number of decimal places to display. The
                        remainder will be replaced with ellipsis.
  --no-number-ellipsis  Disable the ellipsis if --max-precision is exceeded.
  -y, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.
```

## csvkit_csvcut

### Tool Description
Filter and truncate CSV files. Like the Unix "cut" command, but for tabular data.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvcut [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
              [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-S] [-H]
              [-K SKIP_LINES] [-v] [-l] [--add-bom] [--zero] [-V] [-n]
              [-c COLUMNS] [-C NOT_COLUMNS] [-x]
              [FILE]

Filter and truncate CSV files. Like the Unix "cut" command, but for tabular
data.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -n, --names           Display column names and indices from the input CSV
                        and exit.
  -c, --columns COLUMNS
                        A comma-separated list of column indices, names or
                        ranges to be extracted, e.g. "1,id,3-5". Defaults to
                        all columns.
  -C, --not-columns NOT_COLUMNS
                        A comma-separated list of column indices, names or
                        ranges to be excluded, e.g. "1,id,3-5". Defaults to no
                        columns.
  -x, --delete-empty-rows
                        After cutting, delete rows which are completely empty.
```

## csvkit_csvstat

### Tool Description
Print descriptive statistics for each column in a CSV file.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvstat [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
               [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
               [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
               [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
               [--no-leading-zeroes] [-H] [-K SKIP_LINES] [-v] [-l]
               [--add-bom] [--zero] [-V] [--csv] [--json] [-i INDENT] [-n]
               [-c COLUMNS] [--type] [--nulls] [--non-nulls] [--unique]
               [--min] [--max] [--sum] [--mean] [--median] [--stdev] [--len]
               [--max-precision] [--freq] [--freq-count FREQ_COUNT] [--count]
               [--decimal-format DECIMAL_FORMAT] [-G] [-y SNIFF_LIMIT] [-I]
               [FILE]

Print descriptive statistics for each column in a CSV file.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -L, --locale LOCALE   Specify the locale (en_US) of any formatted numbers.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  --blanks              Do not convert "", "na", "n/a", "none", "null", "." to
                        NULL.
  --null-value NULL_VALUES [NULL_VALUES ...]
                        Convert this value to NULL. --null-value can be
                        specified multiple times.
  --date-format DATE_FORMAT
                        Specify a strptime date format string like "%m/%d/%Y".
  --datetime-format DATETIME_FORMAT
                        Specify a strptime datetime format string like
                        "%m/%d/%Y %I:%M %p".
  --no-leading-zeroes   Do not convert a numeric value with leading zeroes to
                        a number.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  --csv                 Output results as a CSV table, rather than plain text.
  --json                Output results as JSON text, rather than plain text.
  -i, --indent INDENT   Indent the output JSON this many spaces. Disabled by
                        default.
  -n, --names           Display column names and indices from the input CSV
                        and exit.
  -c, --columns COLUMNS
                        A comma-separated list of column indices, names or
                        ranges to be examined, e.g. "1,id,3-5". Defaults to
                        all columns.
  --type                Only output data type.
  --nulls               Only output whether columns contains nulls.
  --non-nulls           Only output counts of non-null values.
  --unique              Only output counts of unique values.
  --min                 Only output smallest values.
  --max                 Only output largest values.
  --sum                 Only output sums.
  --mean                Only output means.
  --median              Only output medians.
  --stdev               Only output standard deviations.
  --len                 Only output the length of the longest values.
  --max-precision       Only output the most decimal places.
  --freq                Only output lists of frequent values.
  --freq-count FREQ_COUNT
                        The maximum number of frequent values to display.
  --count               Only output total row count.
  --decimal-format DECIMAL_FORMAT
                        %-format specification for printing decimal numbers.
                        Defaults to locale-specific formatting with "%.3f".
  -G, --no-grouping-separator
                        Do not use grouping separators in decimal numbers.
  -y, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.
```

## csvkit_csvgrep

### Tool Description
Search CSV files. Like the Unix "grep" command, but for tabular data.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvgrep [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
               [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-S] [-H]
               [-K SKIP_LINES] [-v] [-l] [--add-bom] [--zero] [-V] [-n]
               [-c COLUMNS] [-m PATTERN] [-r REGEX] [-f MATCHFILE] [-i] [-a]
               [FILE]

Search CSV files. Like the Unix "grep" command, but for tabular data.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -n, --names           Display column names and indices from the input CSV
                        and exit.
  -c, --columns COLUMNS
                        A comma-separated list of column indices, names or
                        ranges to be searched, e.g. "1,id,3-5".
  -m, --match PATTERN   A string to search for.
  -r, --regex REGEX     A regular expression to match.
  -f, --file MATCHFILE  A path to a file. For each row, if any line in the
                        file (stripped of line separators) is an exact match
                        of the cell value, the row matches.
  -i, --invert-match    Select non-matching rows, instead of matching rows.
  -a, --any-match       Select rows in which any column matches, instead of
                        all columns.
```

## csvkit_csvsort

### Tool Description
Sort CSV files. Like the Unix "sort" command, but for tabular data.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvsort [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
               [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
               [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
               [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
               [--no-leading-zeroes] [-H] [-K SKIP_LINES] [-v] [-l]
               [--add-bom] [--zero] [-V] [-n] [-c COLUMNS] [-r] [-i]
               [-y SNIFF_LIMIT] [-I]
               [FILE]

Sort CSV files. Like the Unix "sort" command, but for tabular data.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -L, --locale LOCALE   Specify the locale (en_US) of any formatted numbers.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  --blanks              Do not convert "", "na", "n/a", "none", "null", "." to
                        NULL.
  --null-value NULL_VALUES [NULL_VALUES ...]
                        Convert this value to NULL. --null-value can be
                        specified multiple times.
  --date-format DATE_FORMAT
                        Specify a strptime date format string like "%m/%d/%Y".
  --datetime-format DATETIME_FORMAT
                        Specify a strptime datetime format string like
                        "%m/%d/%Y %I:%M %p".
  --no-leading-zeroes   Do not convert a numeric value with leading zeroes to
                        a number.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -n, --names           Display column names and indices from the input CSV
                        and exit.
  -c, --columns COLUMNS
                        A comma-separated list of column indices, names or
                        ranges to sort by, e.g. "1,id,3-5". Defaults to all
                        columns.
  -r, --reverse         Sort in descending order.
  -i, --ignore-case     Perform case-independent sorting.
  -y, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.
```

## csvkit_in2csv

### Tool Description
Convert common, but less awesome, tabular data formats to CSV.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: in2csv [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
              [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
              [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
              [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
              [--no-leading-zeroes] [-H] [-K SKIP_LINES] [-v] [-l] [--add-bom]
              [--zero] [-V] [-f {csv,dbf,fixed,geojson,json,ndjson,xls,xlsx}]
              [-s SCHEMA] [-k KEY] [-n] [--sheet SHEET]
              [--write-sheets WRITE_SHEETS] [--use-sheet-names]
              [--reset-dimensions] [--encoding-xls ENCODING_XLS]
              [-y SNIFF_LIMIT] [-I]
              [FILE]

Convert common, but less awesome, tabular data formats to CSV.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -L, --locale LOCALE   Specify the locale (en_US) of any formatted numbers.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  --blanks              Do not convert "", "na", "n/a", "none", "null", "." to
                        NULL.
  --null-value NULL_VALUES [NULL_VALUES ...]
                        Convert this value to NULL. --null-value can be
                        specified multiple times.
  --date-format DATE_FORMAT
                        Specify a strptime date format string like "%m/%d/%Y".
  --datetime-format DATETIME_FORMAT
                        Specify a strptime datetime format string like
                        "%m/%d/%Y %I:%M %p".
  --no-leading-zeroes   Do not convert a numeric value with leading zeroes to
                        a number.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -f, --format {csv,dbf,fixed,geojson,json,ndjson,xls,xlsx}
                        The format of the input file. If not specified will be
                        inferred from the file type.
  -s, --schema SCHEMA   Specify a CSV-formatted schema file for converting
                        fixed-width files. See web documentation.
  -k, --key KEY         Specify a top-level key to look within for a list of
                        objects to be converted when processing JSON.
  -n, --names           Display sheet names from the input Excel file.
  --sheet SHEET         The name of the Excel sheet to operate on.
  --write-sheets WRITE_SHEETS
                        The names of the Excel sheets to write to files, or
                        "-" to write all sheets.
  --use-sheet-names     Use the sheet names as file names when --write-sheets
                        is set.
  --reset-dimensions    Ignore the sheet dimensions provided by the XLSX file.
  --encoding-xls ENCODING_XLS
                        Specify the encoding of the input XLS file.
  -y, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        CSV input.

Some command-line flags only pertain to specific input formats.
```

## csvkit_csvclean

### Tool Description
Report and fix common errors in a CSV file.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvclean [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}]
                [-b] [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-S]
                [-H] [-K SKIP_LINES] [-v] [-l] [--add-bom] [--zero] [-V]
                [--length-mismatch] [--empty-columns] [-a] [--omit-error-rows]
                [--label LABEL] [--header-normalize-space] [--join-short-rows]
                [--separator SEPARATOR] [--fill-short-rows]
                [--fillvalue FILLVALUE]
                [FILE]

Report and fix common errors in a CSV file.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  --length-mismatch     Report data rows that are shorter or longer than the
                        header row.
  --empty-columns       Report empty columns as errors.
  -a, --enable-all-checks
                        Enable all error reporting.
  --omit-error-rows     Omit data rows that contain errors, from standard
                        output.
  --label LABEL         Add a "label" column to standard error. Useful in
                        automated workflows. Use "-" to default to the input
                        filename.
  --header-normalize-space
                        Strip leading and trailing whitespace and replace
                        sequences of whitespace characters by a single space
                        in the header.
  --join-short-rows     Merges short rows into a single row.
  --separator SEPARATOR
                        The string with which to join short rows. Defaults to
                        a newline.
  --fill-short-rows     Fill short rows with the missing cells.
  --fillvalue FILLVALUE
                        The value with which to fill short rows. Defaults to
                        none.
```

## csvkit_csvformat

### Tool Description
Convert a CSV file to a custom output format.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvformat [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}]
                 [-b] [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING]
                 [-L LOCALE] [-S] [-H] [-K SKIP_LINES] [-v] [-l] [--add-bom]
                 [--zero] [-V] [-E] [-D OUT_DELIMITER] [-T] [-A]
                 [-Q OUT_QUOTECHAR] [-U {0,1,2,3,4,5}] [-B]
                 [-P OUT_ESCAPECHAR] [-M OUT_LINETERMINATOR]
                 [FILE]

Convert a CSV file to a custom output format.

positional arguments:
  FILE                  The CSV file to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -L, --locale LOCALE   Specify the locale (en_US) of any formatted numbers.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -E, --skip-header     Do not output a header row.
  -D, --out-delimiter OUT_DELIMITER
                        Delimiting character of the output file.
  -T, --out-tabs        Specify that the output file is delimited with tabs.
                        Overrides "-D".
  -A, --out-asv         Specify that the output file is delimited with the
                        ASCII unit separator and record separator. Overrides
                        "-T", "-D" and "-M".
  -Q, --out-quotechar OUT_QUOTECHAR
                        Character used to quote strings in the output file.
  -U, --out-quoting {0,1,2,3,4,5}
                        Quoting style used in the output file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -B, --out-no-doublequote
                        Whether or not double quotes are doubled in the output
                        file.
  -P, --out-escapechar OUT_ESCAPECHAR
                        Character used to escape the delimiter in the output
                        file if --quoting 3 ("Quote None") is specified and to
                        escape the QUOTECHAR if --out-no-doublequote is
                        specified.
  -M, --out-lineterminator OUT_LINETERMINATOR
                        Character used to terminate lines in the output file.
```

## csvkit_csvsql

### Tool Description
Generate SQL statements for one or more CSV files, or execute those statements directly on a database, and execute one or more SQL queries.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvsql [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
              [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
              [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
              [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
              [--no-leading-zeroes] [-H] [-K SKIP_LINES] [-v] [-l] [--add-bom]
              [--zero] [-V] [-i {mssql,mysql,oracle,postgresql,sqlite}]
              [--db CONNECTION_STRING]
              [--engine-option ENGINE_OPTION ENGINE_OPTION] [--query QUERIES]
              [--insert] [--prefix PREFIX] [--before-insert BEFORE_INSERT]
              [--after-insert AFTER_INSERT] [--sql-delimiter SQL_DELIMITER]
              [--tables TABLE_NAMES] [--no-constraints]
              [--unique-constraint UNIQUE_CONSTRAINT] [--no-create]
              [--create-if-not-exists] [--overwrite] [--db-schema DB_SCHEMA]
              [-y SNIFF_LIMIT] [-I] [--chunk-size CHUNK_SIZE]
              [--min-col-len MIN_COL_LEN]
              [--col-len-multiplier COL_LEN_MULTIPLIER]
              [FILE ...]

Generate SQL statements for one or more CSV files, or execute those statements
directly on a database, and execute one or more SQL queries.

positional arguments:
  FILE                  The CSV file(s) to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -L, --locale LOCALE   Specify the locale (en_US) of any formatted numbers.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  --blanks              Do not convert "", "na", "n/a", "none", "null", "." to
                        NULL.
  --null-value NULL_VALUES [NULL_VALUES ...]
                        Convert this value to NULL. --null-value can be
                        specified multiple times.
  --date-format DATE_FORMAT
                        Specify a strptime date format string like "%m/%d/%Y".
  --datetime-format DATETIME_FORMAT
                        Specify a strptime datetime format string like
                        "%m/%d/%Y %I:%M %p".
  --no-leading-zeroes   Do not convert a numeric value with leading zeroes to
                        a number.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -i, --dialect {mssql,mysql,oracle,postgresql,sqlite}
                        Dialect of SQL to generate. Cannot be used with --db.
  --db CONNECTION_STRING
                        If present, a SQLAlchemy connection string to use to
                        directly execute generated SQL on a database.
  --engine-option ENGINE_OPTION ENGINE_OPTION
                        A keyword argument to SQLAlchemy's create_engine(), as
                        a space-separated pair. This option can be specified
                        multiple times. For example: thick_mode True
  --query QUERIES       Execute one or more SQL queries delimited by --sql-
                        delimiter, and output the result of the last query as
                        CSV. QUERY may be a filename. --query may be specified
                        multiple times.
  --insert              Insert the data into the table. Requires --db.
  --prefix PREFIX       Add an expression following the INSERT keyword, like
                        OR IGNORE or OR REPLACE.
  --before-insert BEFORE_INSERT
                        Before the INSERT command, execute one or more SQL
                        queries delimited by --sql-delimiter. Requires
                        --insert.
  --after-insert AFTER_INSERT
                        After the INSERT command, execute one or more SQL
                        queries delimited by --sql-delimiter. Requires
                        --insert.
  --sql-delimiter SQL_DELIMITER
                        Delimiter separating SQL queries in --query, --before-
                        insert, and --after-insert.
  --tables TABLE_NAMES  A comma-separated list of names of tables to be
                        created. By default, the tables will be named after
                        the filenames without extensions or "stdin".
  --no-constraints      Generate a schema without length limits or null
                        checks. Useful when sampling big tables.
  --unique-constraint UNIQUE_CONSTRAINT
                        A column-separated list of names of columns to include
                        in a UNIQUE constraint.
  --no-create           Skip creating the table. Requires --insert.
  --create-if-not-exists
                        Create the table if it does not exist, otherwise keep
                        going. Requires --insert.
  --overwrite           Drop the table if it already exists. Requires
                        --insert. Cannot be used with --no-create.
  --db-schema DB_SCHEMA
                        Optional name of database schema to create table(s)
                        in.
  -y, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.
  --chunk-size CHUNK_SIZE
                        Chunk size for batch insert into the table. Requires
                        --insert.
  --min-col-len MIN_COL_LEN
                        The minimum length of text columns.
  --col-len-multiplier COL_LEN_MULTIPLIER
                        Multiply the maximum column length by this multiplier
                        to accomodate larger values in later runs.
```

## csvkit_csvjoin

### Tool Description
Execute a SQL-like join to merge CSV files on a specified column or columns.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvjoin [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}] [-b]
               [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-L LOCALE]
               [-S] [--blanks] [--null-value NULL_VALUES [NULL_VALUES ...]]
               [--date-format DATE_FORMAT] [--datetime-format DATETIME_FORMAT]
               [--no-leading-zeroes] [-H] [-K SKIP_LINES] [-v] [-l]
               [--add-bom] [--zero] [-V] [-c COLUMNS] [--outer] [--left]
               [--right] [-y SNIFF_LIMIT] [-I]
               [FILE ...]

Execute a SQL-like join to merge CSV files on a specified column or columns.

positional arguments:
  FILE                  The CSV files to operate on. If only one is specified,
                        it will be copied to STDOUT.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -L, --locale LOCALE   Specify the locale (en_US) of any formatted numbers.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  --blanks              Do not convert "", "na", "n/a", "none", "null", "." to
                        NULL.
  --null-value NULL_VALUES [NULL_VALUES ...]
                        Convert this value to NULL. --null-value can be
                        specified multiple times.
  --date-format DATE_FORMAT
                        Specify a strptime date format string like "%m/%d/%Y".
  --datetime-format DATETIME_FORMAT
                        Specify a strptime datetime format string like
                        "%m/%d/%Y %I:%M %p".
  --no-leading-zeroes   Do not convert a numeric value with leading zeroes to
                        a number.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -c, --columns COLUMNS
                        The column name(s) on which to join. Should be either
                        one name (or index) or a comma-separated list with one
                        name (or index) per file, in the same order in which
                        the files were specified. If not specified, the two
                        files will be joined sequentially without matching.
  --outer               Perform a full outer join, rather than the default
                        inner join.
  --left                Perform a left outer join, rather than the default
                        inner join. If more than two files are provided this
                        will be executed as a sequence of left outer joins,
                        starting at the left.
  --right               Perform a right outer join, rather than the default
                        inner join. If more than two files are provided this
                        will be executed as a sequence of right outer joins,
                        starting at the right.
  -y, --snifflimit SNIFF_LIMIT
                        Limit CSV dialect sniffing to the specified number of
                        bytes. Specify "0" to disable sniffing entirely, or
                        "-1" to sniff the entire file.
  -I, --no-inference    Disable type inference (and --locale, --date-format,
                        --datetime-format, --no-leading-zeroes) when parsing
                        the input.

Note that the join operation requires reading all files into memory. Don't try
this on very large files.
```

## csvkit_csvstack

### Tool Description
Stack up the rows from multiple CSV files, optionally adding a grouping value.

### Metadata
- **Docker Image**: ghcr.io/wireservice/csvkit:latest
- **Homepage**: https://github.com/wireservice/csvkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: csvstack [-h] [-d DELIMITER] [-t] [-q QUOTECHAR] [-u {0,1,2,3,4,5}]
                [-b] [-p ESCAPECHAR] [-z FIELD_SIZE_LIMIT] [-e ENCODING] [-S]
                [-H] [-K SKIP_LINES] [-v] [-l] [--add-bom] [--zero] [-V]
                [-g GROUPS] [-n GROUP_NAME] [--filenames]
                [FILE ...]

Stack up the rows from multiple CSV files, optionally adding a grouping value.

positional arguments:
  FILE                  The CSV file(s) to operate on. If omitted, will accept
                        input as piped data via STDIN.

options:
  -h, --help            show this help message and exit
  -d, --delimiter DELIMITER
                        Delimiting character of the input CSV file.
  -t, --tabs            Specify that the input CSV file is delimited with
                        tabs. Overrides "-d".
  -q, --quotechar QUOTECHAR
                        Character used to quote strings in the input CSV file.
  -u, --quoting {0,1,2,3,4,5}
                        Quoting style used in the input CSV file: 0 quote
                        minimal, 1 quote all, 2 quote non-numeric, 3 quote
                        none.
  -b, --no-doublequote  Whether or not double quotes are doubled in the input
                        CSV file.
  -p, --escapechar ESCAPECHAR
                        Character used to escape the delimiter if --quoting 3
                        ("quote none") is specified and to escape the
                        QUOTECHAR if --no-doublequote is specified.
  -z, --maxfieldsize FIELD_SIZE_LIMIT
                        Maximum length of a single field in the input CSV
                        file.
  -e, --encoding ENCODING
                        Specify the encoding of the input CSV file.
  -S, --skipinitialspace
                        Ignore whitespace immediately following the delimiter.
  -H, --no-header-row   Specify that the input CSV file has no header row.
                        Will create default headers (a,b,c,...).
  -K, --skip-lines SKIP_LINES
                        Specify the number of initial lines to skip before the
                        header row (e.g. comments, copyright notices, empty
                        rows).
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  --add-bom             Add the UTF-8 byte-order mark (BOM) to the output, for
                        Excel compatibility
  --zero                When interpreting or displaying column numbers, use
                        zero-based numbering instead of the default 1-based
                        numbering.
  -V, --version         Display version information and exit.
  -g, --groups GROUPS   A comma-separated list of values to add as "grouping
                        factors", one per CSV being stacked. These are added
                        to the output as a new column. You may specify a name
                        for the new column using the -n flag.
  -n, --group-name GROUP_NAME
                        A name for the grouping column, e.g. "year". Only used
                        when also specifying -g.
  --filenames           Use the filename of each input file as its grouping
                        value. When specified, -g will be ignored.
```

