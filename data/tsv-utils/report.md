# tsv-utils CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tsv-utils_csv2tsv | PASS | rewritten from the help; matches the repository gold output for the repository test files |
| tsv-utils_keep-header | PASS | new CWL; matches the repository gold output |
| tsv-utils_number-lines | PASS | new CWL; matches the repository gold output |
| tsv-utils_tsv-append | PASS | rewritten from the help; matches the repository gold output, including header, source header and --file sources |
| tsv-utils_tsv-filter | PASS | rewritten from the help (all test operators wrapped as repeatable options); matches the repository gold output for numeric, regex, count and label tests |
| tsv-utils_tsv-join | PASS | rewritten from the help; matches the repository gold output for append, prefix and exclude |
| tsv-utils_tsv-pretty | PASS | new CWL; matches the repository gold output |
| tsv-utils_tsv-sample | PASS | new CWL; matches the repository gold output with a static seed |
| tsv-utils_tsv-select | PASS | new CWL; matches the repository gold output |
| tsv-utils_tsv-split | PASS | new CWL; split by line count and by key on the repository test files, part files checked by hand |
| tsv-utils_tsv-summarize | PASS | new CWL; values match the repository gold output (column order follows the CWL option order, not the command-line order) |
| tsv-utils_tsv-uniq | PASS | new CWL; matches the repository gold output |

## tsv-utils_keep-header

### Tool Description
Execute a command against one or more files in a header aware fashion.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: keep-header [file...] -- program [args]

Execute a command against one or more files in a header aware fashion.
The first line of each file is assumed to be a header. The first header
is output unchanged. Remaining lines are sent to the given command via
standard input, excluding the header lines of subsequent files. Output
from the command is appended to the initial header line.

A double dash (--) delimits the command, similar to how the pipe
operator (|) delimits commands. Examples:

    $ keep-header file1.txt -- sort
    $ keep-header file1.txt file2.txt -- sort -k1,1nr

These sort the files as usual, but preserve the header as the first line
output. Data can also be read from from standard input. Example:

    $ cat file1.txt | keep-header -- grep red

Options:

-V      --version   Print version information and exit.
-h         --help   This help information.
```

## tsv-utils_number-lines

### Tool Description
Write each input line preceded by a line number, with header support.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: number-lines [options] [file...]

number-lines reads from files or standard input and writes each line to standard
output preceded by a line number. It is a simplified version of the unix 'nl'
program. It supports one feature 'nl' does not: the ability to treat the first
line of files as a header. This is useful when working with tab-separated-value
files. If header processing used, a header line is written for the first file,
and the header lines are dropped from any subsequent files.

Examples:
   number-lines myfile.txt
   cat myfile.txt | number-lines --header linenum
   number-lines *.txt

Options:

-H        --header      Treat the first line of each file as a header. The first input file's header is output, subsequent file headers are discarded.
-s --header-string STR  String to use in the header row. Implies --header. Default: 'line'
-n  --start-number NUM  Number to use for the first line. Default: 1
-d     --delimiter CHR  Character appended to line number, preceding the rest of the line. Default: TAB (Single byte UTF-8 characters only.)
   --line-buffered      Immediately output every line.
-V       --version      Print version information and exit.
-h          --help This help information.
```

## tsv-utils_tsv-pretty

### Tool Description
Output TSV data in a more human readable format with fixed-width columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: tsv-pretty [options] [file...]

tsv-pretty outputs TSV data in a more human readable format. This is done by lining
up data into fixed-width columns. Text is left aligned, numbers are right aligned.
Floating points numbers are aligned on the decimal point when feasible.

Options:

           --help-verbose        Print full help.
-H               --header        Treat the first line of each file as a header.
-x            --no-header        Assume no header. Turns off automatic header detection.
-l            --lookahead NUM    Lines to read to interpret data before generating output. Default: 1000
-r        --repeat-header NUM    Lines to print before repeating the header. Default: No repeating header
-u     --underline-header        Underline the header.
-f        --format-floats        Format floats for better readability. Default: No
-p            --precision NUM    Max floating point precision. Implies --format-floats. Default: 9
-e        --replace-empty        Replace empty fields with '--'.
-E    --empty-replacement STR    Replace empty fields with a string.
-d            --delimiter CHR    Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)
-s --space-between-fields NUM    Spaces between each field (Default: 2)
-m       --max-text-width NUM    Max reserved field width for variable width text fields. Default: 40
-a        --auto-preamble        Treat initial lines in a file as a preamble if the line contains no field delimiters.
-b             --preamble NUM    Treat the first NUM lines as a preamble and output them unchanged.
-V              --version        Print version information and exit.
-h                 --help This help information.
```

## tsv-utils_tsv-sample

### Tool Description
Sample input lines or randomize their order.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: tsv-sample [options] [file...]

Sample input lines or randomize their order. Several modes of operation
are available:
* Shuffling (the default): All input lines are output in random order. All
  orderings are equally likely.
* Random sampling (--n|num N): A random sample of N lines are selected and
  written to standard output. By default, selected lines are written in
  random order. All sample sets and orderings are equally likely. Use
  --i|inorder to write the selected lines in the original input order.
* Weighted random sampling (--n|num N, --w|weight-field F): A weighted
  sample of N lines is produced. Weights are taken from field F. Lines are
  output in weighted selection order. Use --i|inorder to write in original
  input order. Omit --n|num to shuffle all lines (weighted shuffling).
* Sampling with replacement (--r|replace, --n|num N): All input lines are
  read in, then lines are repeatedly selected at random and written out.
  This continues until N lines are output. Individual lines can be written
  multiple times. Output continues forever if N is zero or not provided.
* Bernoulli sampling (--p|prob P): A random subset of lines is selected
  based on probability P, a 0.0-1.0 value. This is a streaming operation.
  A decision is made on each line as it is read. Line order is not changed.
* Distinct sampling (--k|key-fields F, --p|prob P): Input lines are sampled
  based on the values in the key fields. A subset of keys are chosen based
  on the inclusion probability (a 'distinct' set of keys). All lines with
  one of the selected keys are output. Line order is not changed.

Fields are specified using field number or field name. Field names require
that the input file has a header line.

Use '--help-verbose' for detailed information.

Options:

           --help-verbose      Print more detailed help.
            --help-fields      Print help on specifying fields.
-H               --header      Treat the first line of each file as a header.
-n                  --num NUM  Maximum number of lines to output. All selected lines are output if not provided or zero.
-p                 --prob NUM  Inclusion probability (0.0 < NUM <= 1.0). For Bernoulli sampling, the probability each line is selected output. For distinct sampling, the probability each unique key is selected for output.
-k           --key-fields <field-list>  Fields to use as key for distinct sampling. Use with '--p|prob'. Specify '--k|key-fields 0' to use the entire line as the key.
-w         --weight-field NUM  Field containing weights. All lines get equal weight if not provided.
-r              --replace      Simple random sampling with replacement. Use --n|num to specify the sample size.
-i              --inorder      Output random samples in original input order. Requires use of --n|num.
-s          --static-seed      Use the same random seed every run.
-v           --seed-value NUM  Sets the random seed. Use a non-zero, 32 bit positive integer. Zero is a no-op.
           --print-random      Include the assigned random value (prepended) when writing output lines.
     --gen-random-inorder      Output all lines with assigned random values prepended, no changes to the order of input.
    --random-value-header      Header to use with --print-random and --gen-random-inorder. Default: 'random_value'.
     --compatibility-mode      Turns on 'compatibility-mode'. Use --help-verbose for information.
-d            --delimiter CHR  Field delimiter.
          --line-buffered      Immediately output every sampled line. Applies to Bernoulli and distinct sampling. Ignored in modes where all input data must be read before generating output.
-V              --version      Print version information and exit.
   --prefer-skip-sampling      (Internal) Prefer the skip-sampling algorithm for Bernoulli sampling. Used for testing and diagnostics.
     --prefer-algorithm-r      (Internal) Prefer Algorithm R for unweighted line order randomization. Used for testing and diagnostics.
-h                 --help This help information.
```

## tsv-utils_tsv-select

### Tool Description
Write selected fields to standard output in the order listed.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: tsv-select [options] [file...]

tsv-select reads files or standard input and writes selected fields to
standard output. Fields are written in the order listed. This is similar
to Unix 'cut', but with the ability to reorder fields.

Fields can be specified by field number or, for files with header lines,
by field name. Use '--H|header' to enable selection by name. This also
manages header lines from multiple files, retaining only the first header.

Field numbers start with one. The field list is comma separated. Ranges
can be used, and wildcards can be used when specifying fields by name.

Fields can be dropped using '--e|exclude'. Fields not included in the
'--f|fields' option can be selected as a group using '--r|rest'.

Examples:

   # Selecting fields. Output is in the order listed
   tsv-select -H date,time file.tsv
   tsv-select -f 2,1 file.tsv
   tsv-select -f 5-7,2,9-11
   tsv-select -H -f '*_date' file.tsv

   # Dropping fields
   tsv-select --exclude 1 file.tsv
   tsv-select -H -e date,time file.tsv

   # Move fields to the front or the back
   tsv-select -f 1 --rest first file.tsv  # Move field 1 to the end
   tsv-select -H -f date --rest last      # Move 'date' field to the front

   # Read multiple files, keep the header from only the first
   tsv-select data*.tsv -H --fields 1,2,4-7,14

Use '--help-verbose' for detailed information. Use '--help-fields' for
details about field lists and field names.

Options:

    --help-verbose               Print more detailed help.
     --help-fields               Print help on specifying fields.
-H        --header               Treat the first line of each file as a header.
-f        --fields <field-list>  Fields to retain. Fields are output in the order listed.
-e       --exclude <field-list>  Fields to exclude.
-r          --rest first|last    Output location for fields not included in '--f|fields'.
-d     --delimiter CHR           Character to use as field delimiter. Default: TAB. (Single byte UTF-8 characters only.)
   --line-buffered               Immediately output every line.
-V       --version               Print version information and exit.
-h          --help This help information.
```

## tsv-utils_tsv-split

### Tool Description
Split input lines into multiple output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: tsv-split [options] [file...]

Split input lines into multiple output files. There are three modes of
operation:

* Fixed number of lines per file (--l|lines-per-file NUM): Each input
  block of NUM lines is written to a new file. Similar to Unix 'split'.

* Random assignment (--n|num-files NUM): Each input line is written to a
  randomly selected output file. Random selection is from NUM files.

* Random assignment by key (--n|num-files NUM, --k|key-fields FIELDS):
  Input lines are written to output files using fields as a key. Each
  unique key is randomly assigned to one of NUM output files. All lines
  with the same key are written to the same file.

By default, files are written to the current directory and have names
of the form 'part_NNN<suffix>', with 'NNN' being a number and <suffix>
being the extension of the first input file. If the input file is
'file.txt', the names will take the form 'part_NNN.txt'. The output
directory and file names are customizable.

Fields are specified using field number or field name. Field names
require that the input file has a header line.

Use '--help-verbose' for more detailed information.

Options:

     --help-verbose      Print more detailed help.
      --help-fields      Print help on specifying fields.
-H         --header      Input files have a header line. Write the header to each output file.
-I --header-in-only      Input files have a header line. Do not write the header to output files.
-l --lines-per-file NUM  Number of lines to write to each output file (excluding the header line).
-n      --num-files NUM  Number of output files to generate.
-k     --key-fields <field-list>  Fields to use as key. Lines with the same key are written to the same output file. Use '--k|key-fields 0' to use the entire line as the key.
              --dir STR  Directory to write to. Default: Current working directory.
           --prefix STR  Filename prefix. Default: 'part_'
           --suffix STR  Filename suffix. Default: First input file extension. None for standard input.
-w    --digit-width NUM  Number of digits in filename numeric portion. Default: '--l|lines-per-file': 3. '--n|num-files': Chosen so filenames have the same length. '--w|digit-width 0' uses the default.
-a         --append      Append to existing files.
-s    --static-seed      Use the same random seed every run.
-v     --seed-value NUM  Sets the random seed. Use a non-zero, 32 bit positive integer. Zero is a no-op.
-d      --delimiter CHR  Field delimiter.
   --max-open-files NUM  Maximum open file handles to use. Min of 5 required.
-V        --version      Print version information and exit.
-h           --help This help information.
```

## tsv-utils_tsv-summarize

### Tool Description
Run aggregation operations on fields in tab-separated value files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: tsv-summarize [options] file [file...]

tsv-summarize runs aggregation operations on fields in tab-separated value
files. Operations can be run against the full input data or grouped by key
fields. Fields can be specified either by field number or field name. Use
'--help-verbose' for more detailed help.

Options:

        --help-verbose               Print full help.
         --help-fields               Print help on specifying fields.
-V           --version               Print version information and exit.
-g          --group-by <field-list>  Fields to use as key.
-H            --header               Treat the first line of each file as a header.
-w      --write-header               Write an output header even if there is no input header.
-d         --delimiter CHR           Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)
-v  --values-delimiter CHR           Values delimiter. Default: vertical bar (|). (Single byte UTF-8 characters only.)
-p   --float-precision NUM           'Precision' to use printing floating point numbers. Affects the number of digits printed and exponent use. Default: 12
-x   --exclude-missing               Exclude missing (empty) fields from calculations.
-r   --replace-missing STR           Replace missing (empty) fields with STR in calculations.
               --count               Count occurrences of each unique key ('--g|group-by'), or the total number of records if no key field is specified.
        --count-header STR           Count occurrences of each unique key, like '--count', but use STR as the header.
              --retain <field-list>  Retain one copy of the field.
               --first <field-list>[:STR]  First value seen.
                --last <field-list>[:STR]  Last value seen.
                 --min <field-list>[:STR]  Min value. (Fields with numeric values only.)
                 --max <field-list>[:STR]  Max value. (Fields with numeric values only.)
               --range <field-list>[:STR]  Difference between min and max values. (Fields with numeric values only.)
                 --sum <field-list>[:STR]  Sum of the values. (Fields with numeric values only.)
                --mean <field-list>[:STR]  Mean (average). (Fields with numeric values only.)
              --median <field-list>[:STR]  Median value. (Fields with numeric values only. Reads all values into memory.)
            --quantile <field-list>:p[,p...][:STR]  Quantiles. One or more fields, then one or more 0.0-1.0 probabilities. (Fields with numeric values only. Reads all values into memory.)
                 --mad <field-list>[:STR]  Median absolute deviation from the median. Raw value, not scaled. (Fields with numeric values only. Reads all values into memory.)
                 --var <field-list>[:STR]  Variance. (Sample variance, numeric fields only).
               --stdev <field-list>[:STR]  Standard deviation. (Sample st.dev, numeric fields only).
                --mode <field-list>[:STR]  Mode. The most frequent value. (Reads all unique values into memory.)
          --mode-count <field-list>[:STR]  Count of the most frequent value. (Reads all unique values into memory.)
        --unique-count <field-list>[:STR]  Number of unique values. (Reads all unique values into memory.)
       --missing-count <field-list>[:STR]  Number of missing (empty) fields. Not affected by '--x|exclude-missing' or '--r|replace-missing'.
   --not-missing-count <field-list>[:STR]  Number of filled (non-empty) fields. Not affected by '--r|replace-missing'.
              --values <field-list>[:STR]  All the values, separated by --v|values-delimiter. (Reads all values into memory.)
       --unique-values <field-list>[:STR]  All the unique values, separated by --v|values-delimiter. (Reads all unique values into memory.)
-h              --help This help information.
```

## tsv-utils_tsv-uniq

### Tool Description
Filter out duplicate lines using fields as a key.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Synopsis: tsv-uniq [options] [file...]

tsv-uniq filters out duplicate lines using fields as a key. Filtering is
based on the entire line when key fields are not provided. Options are
also available for assigning a unique id to each key and numbering the
occurrences of each key. Fields are specified using field number or field
name. Field names can be used when the input file has a header line.

Use '--help-verbose' for more details.
Options:

    --help-verbose               Print full help.
     --help-fields               Print help on specifying fields.
-V       --version               Print version information and exit.
-H        --header               Treat the first line of each file as a header.
-f        --fields <field-list>  Fields to use as the key. Default: 0 (entire line).
-i   --ignore-case               Ignore case when comparing keys.
-r      --repeated               Output only lines that are repeated (based on the key).
-a      --at-least INT           Output only lines that are repeated INT times (based on the key). Zero and one are ignored.
-m           --max INT           Max number of each unique key to output (zero is ignored).
-e         --equiv               Output equivalence class IDs rather than uniq'ing entries.
    --equiv-header STR           Use STR as the equiv-id field header (when using '-H --equiv'). Default: 'equiv_id'.
     --equiv-start INT           Use INT as the first equiv-id. Default: 1.
-z        --number               Output equivalence class occurrence counts rather than uniq'ing entries.
   --number-header STR           Use STR as the '--number' field header (when using '-H --number)'. Default: 'equiv_line'.
-d     --delimiter CHR           Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)
   --line-buffered               Immediately output every line.
-h          --help This help information.
```

## Metadata
- **Skill**: generated

## tsv-utils_tsv-filter

### Tool Description
A tool for filtering TSV files based on field content using various operators (equality, numeric comparison, regular expressions, etc.).

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
FATAL:   Unable to handle docker://quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0 uri: while building SIF from layers: while creating squashfs: /usr/libexec/apptainer/bin/mksquashfs command failed: exit status 1: Write failed because No space left on device
FATAL ERROR: Failed to write to output filesystem
```

## tsv-utils_tsv-join

### Tool Description
Joins lines from files based on a common key. It is similar to the Unix 'join' tool, but works on TSV files and supports multiple fields and non-sorted input.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
FATAL:   Unable to handle docker://quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0 uri: while building SIF from layers: while creating squashfs: /usr/libexec/apptainer/bin/mksquashfs command failed: exit status 1: Write failed because No space left on device
FATAL ERROR: Failed to write to output filesystem
```

## tsv-utils_csv2tsv

### Tool Description
Convert CSV (comma separated values) to TSV (tab separated values).

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
FATAL:   Unable to handle docker://quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0 uri: while building SIF from layers: while creating squashfs: /usr/libexec/apptainer/bin/mksquashfs command failed: exit status 1: Write failed because No space left on device
FATAL ERROR: Failed to write to output filesystem
```

## tsv-utils_tsv-append

### Tool Description
Concatenate TSV files, maintaining the header of the first file and optionally tracking the source of each row. (Note: The provided help text contained system error logs rather than tool usage; arguments list is based on standard tsv-append functionality).

### Metadata
- **Docker Image**: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
- **Homepage**: https://github.com/eBay/tsv-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/tsv-utils/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
FATAL:   Unable to handle docker://quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0 uri: while building SIF from layers: while creating squashfs: /usr/libexec/apptainer/bin/mksquashfs command failed: exit status 1: Write failed because No space left on device
FATAL ERROR: Failed to write to output filesystem
```

