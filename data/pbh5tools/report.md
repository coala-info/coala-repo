# pbh5tools CWL Generation Report

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

## pbh5tools_cmph5tools.py

### Tool Description
Toolkit for command-line tools associated with cmp.h5 file processing.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
- **Homepage**: https://github.com/zkennedy/pbh5tools
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: cmph5tools.py [-h] [--verbose] [--version] [--profile] [--debug]
                     {select,merge,sort,equal,summarize,stats,listMetrics,validate}
                     ...

Toolkit for command-line tools associated with cmp.h5 file processing. Notes:
For all command-line arguments, default values are listed in [].

positional arguments:
  {select,merge,sort,equal,summarize,stats,listMetrics,validate}
    select              Create new cmp.h5 files from selections of
                        input.cmp.h5
    merge               Merge input.cmp.h5 files into out.cmp.h5
    sort                Sort input.cmp.h5 file
    equal               Compare two cmp.h5 files for equivalence
    summarize           Summarize contents of cmp.h5 files
    stats               Compute statistics from input.cmp.h5
    listMetrics         List available metrics
    validate            Validate input.cmp.h5

optional arguments:
  -h, --help            show this help message and exit
  --verbose, -v         Set the verbosity level (default: None)
  --version             show program's version number and exit
  --profile             Print runtime profile at exit (default: False)
  --debug               Catch exceptions in debugger (requires ipdb) (default:
                        False)
```

