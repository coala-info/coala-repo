# pbh5tools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pbh5tools_bash5tools.py | PASS |  |
| pbh5tools_cmph5tools_equal | PASS |  |
| pbh5tools_cmph5tools_merge | PASS |  |
| pbh5tools_cmph5tools_select | PASS |  |
| pbh5tools_cmph5tools_sort | PASS |  |
| pbh5tools_cmph5tools_stats | PASS |  |
| pbh5tools_cmph5tools_summarize | PASS |  |
| pbh5tools_cmph5tools_validate | PASS |  |

## Metadata
- **Skill**: generated

## pbh5tools_bash5tools.py

### Tool Description
Tool for extracting data from .bas.h5 files

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/zkennedy/pbh5tools
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: bash5tools.py [-h] [--verbose] [--version] [--profile] [--debug]
                     [--outFilePrefix OUTFILEPREFIX]
                     [--readType {ccs,subreads,unrolled}] [--outType OUTTYPE]
                     [--minLength MINLENGTH] [--minReadScore MINREADSCORE]
                     [--minPasses MINPASSES]
                     input.bas.h5

Tool for extracting data from .bas.h5 files

positional arguments:
  input.bas.h5          input .bas.h5 filename

optional arguments:
  -h, --help            show this help message and exit
  --verbose, -v         Set the verbosity level (default: None)
  --version             show program's version number and exit
  --profile             Print runtime profile at exit (default: False)
  --debug               Catch exceptions in debugger (requires ipdb) (default:
                        False)
  --outFilePrefix OUTFILEPREFIX
                        output filename prefix [None]
  --readType {ccs,subreads,unrolled}
                        read type (ccs, subreads, or unrolled) []
  --outType OUTTYPE     output file type (fasta, fastq) [fasta]

Read filtering arguments:
  --minLength MINLENGTH
                        min read length [0]
  --minReadScore MINREADSCORE
                        min read score, valid only with
                        --readType={unrolled,subreads} [0]
  --minPasses MINPASSES
                        min number of CCS passes, valid only with
                        --readType=ccs [0]
```

## pbh5tools_cmph5tools_select

### Tool Description
Create a new cmp.h5 file by selecting alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/PacificBiosciences/pbh5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pbh5tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cmph5tools.py select [-h] [--outFile out.cmp.h5] [--idxs N [N ...]]
                            [--groupBy groupBy-expression]
                            [--groupByCsv groupByCsv]
                            [--where where-expression] [--outDir outputDir]
                            input.cmp.h5

Create a new cmp.h5 file by selecting alignments. Users can specify indices
using the idx argument to select particular alignments. Alternatively, users
can specify a where expression which chooses the alignments which the
predicate is true. If a groupBy expression is specified then mulitple cmp.h5
files are generated according to the expression. For instance, if a user
wantedto generate a cmp.h5 file for each reference sequence then
--groupBy=Reference

positional arguments:
  input.cmp.h5

optional arguments:
  -h, --help            show this help message and exit
  --outFile out.cmp.h5  Either a pattern string or a filename
  --idxs N [N ...]      indices to select
  --groupBy groupBy-expression
                        groupBy expression, e.g., Movie*Barcode
  --groupByCsv groupByCsv
                        groupByCsv file, e.g.
                        Group,Movie,Barcode\ngroupname,movie,barcode
  --where where-expression
                        where expression, e.g., ReadLength > 500
  --outDir outputDir
```

## pbh5tools_cmph5tools_merge

### Tool Description
Merge two or more cmp.h5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/PacificBiosciences/pbh5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pbh5tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cmph5tools.py merge [-h] [--outFile OUTCMP]
                           [--referencesFile REFERENCESFILE]
                           input.cmp.h5 [input.cmp.h5 ...]

Merge two or more cmp.h5 files. The input.cmp.h5 files must have been aligned
to the same reference sequences

positional arguments:
  input.cmp.h5          input filenames

optional arguments:
  -h, --help            show this help message and exit
  --outFile OUTCMP      output filename [out.cmp.h5]
  --referencesFile REFERENCESFILE, -W REFERENCESFILE
```

## pbh5tools_cmph5tools_sort

### Tool Description
Sort cmp.h5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/PacificBiosciences/pbh5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pbh5tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cmph5tools.py sort [-h] [--outFile OUTCMP] [--deep] [--tmpDir TMPDIR]
                          [--usePythonIndexer] [--inPlace]
                          input.cmp.h5

Sort cmp.h5 files. If output-file is unspecified the input-file is overwritten

positional arguments:
  input.cmp.h5        input filename

optional arguments:
  -h, --help          show this help message and exit
  --outFile OUTCMP    output filename
  --deep              whether a deep sorting should be conducted, i.e. sort
                      theAlignmentArrays [False]
  --tmpDir TMPDIR     temporary directory to use when sorting in-place [/tmp]
  --usePythonIndexer  Whether to use native indexing [False].
  --inPlace           Whether to make a temporary copy of the original cmp.h5
                      file before sorting.
```

## pbh5tools_cmph5tools_equal

### Tool Description
Compare two cmp.h5 files for equivalence.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/PacificBiosciences/pbh5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pbh5tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cmph5tools.py equal [-h] cmp.h5.1 cmp.h5.2

Compare two cmp.h5 files for equivalence.

positional arguments:
  cmp.h5.1    filename 1
  cmp.h5.2    filename 2

optional arguments:
  -h, --help  show this help message and exit
```

## pbh5tools_cmph5tools_summarize

### Tool Description
Summarize cmp.h5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/PacificBiosciences/pbh5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pbh5tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cmph5tools.py summarize [-h] input.cmp.h5 [input.cmp.h5 ...]

Summarize cmp.h5 files.

positional arguments:
  input.cmp.h5  cmp.h5 files to summarize

optional arguments:
  -h, --help    show this help message and exit
```

## pbh5tools_cmph5tools_stats

### Tool Description
Emit statistics from a cmp.h5 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/PacificBiosciences/pbh5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pbh5tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cmph5tools.py stats [-h] [--outFile OUTCSV] [--what what-expression]
                           [--where where-expression]
                           [--groupBy groupBy-expression]
                           [--sortBy sortBy-expression]
                           [--limit maximum-records]
                           input.cmp.h5

Emit statistics from a cmp.h5 file.

positional arguments:
  input.cmp.h5          input filename

optional arguments:
  -h, --help            show this help message and exit
  --outFile OUTCSV      output csv filename
  --what what-expression
  --where where-expression
  --groupBy groupBy-expression
  --sortBy sortBy-expression
  --limit maximum-records
```

## pbh5tools_cmph5tools_validate

### Tool Description
Validate a cmp.h5 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/PacificBiosciences/pbh5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pbh5tools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cmph5tools.py validate [-h] input.cmp.h5

Validate a cmp.h5 file

positional arguments:
  input.cmp.h5  input filename

optional arguments:
  -h, --help    show this help message and exit
```
