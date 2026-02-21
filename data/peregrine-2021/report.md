# peregrine-2021 CWL Generation Report

## peregrine-2021

### Tool Description
FAIL to generate CWL: peregrine-2021 not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/cschin/peregrine-2021
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: peregrine-2021 not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: peregrine-2021 not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## peregrine-2021_pg_asm

### Tool Description
Peregrine-2021 genome assembler: the main workflow entry for end-to-end assembly from the reads

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS
### Original Help Text
```text
pg_asm peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler
pg_asm: the main workflow entry for end-to-end assembly from the reads
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_asm [FLAGS] [OPTIONS] <input_reads> <work_dir> [ARGS]

FLAGS:
        --fast          run the assembler in the fast mode
    -h, --help          Prints help information
        --keep          keep intermediate files
        --no_resolve    disable resolving repeats / dups at the end
    -V, --version       Prints version information

OPTIONS:
    -b, --bestn <bestn>              number of best overlaps for initial graph [default: 6]
    -k <k>                           Kmer size [default: 56]
    -l <layout_method>               layout version [default: 2]
        --log <log>                  log level: DBBUG or INFO (default)
    -c, --min_ec_cov <min_ec_cov>    Minimum error coverage [default: 1]
    -r <r>                           Reduction factor [default: 6]
    -t, --tol <tol>                  Alignment tolerance [default: 0.01]
    -w <w>                           Window size [default: 80]

ARGS:
    <input_reads>    Path to a file that contains the list of reads in .fa .fa.gz .fastq or fastq.gz formats
    <work_dir>       The path to a work directory for intermediate files and the results
    <NTHREADS>       Number of threads
    <NCHUNKS>        Number of partition
```

