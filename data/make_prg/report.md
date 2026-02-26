# make_prg CWL Generation Report

## make_prg_from_msa

### Tool Description
Creates a PRG from a Multiple Sequence Alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/make_prg:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/rmcolq/make_prg
- **Package**: https://anaconda.org/channels/bioconda/packages/make_prg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/make_prg/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rmcolq/make_prg
- **Stars**: N/A
### Original Help Text
```text
usage: make_prg from_msa

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Multiple sequence alignment file or a directory
                        containing such files
  -s SUFFIX, --suffix SUFFIX
                        If the input parameter (-i, --input) is a directory,
                        then filter for files with this suffix. If this
                        parameter is not given, all files in the input
                        directory is considered.
  -o OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        Prefix for the output files
  -f ALIGNMENT_FORMAT, --alignment-format ALIGNMENT_FORMAT
                        Alignment format of MSA, must be a biopython AlignIO
                        input alignment_format. See
                        http://biopython.org/wiki/AlignIO. Default: fasta
  -N MAX_NESTING, --max-nesting MAX_NESTING
                        Maximum number of levels to use for nesting. Default:
                        5
  -L MIN_MATCH_LENGTH, --min-match-length MIN_MATCH_LENGTH
                        Minimum number of consecutive characters which must be
                        identical for a match. Default: 7
  -O OUTPUT_TYPE, --output-type OUTPUT_TYPE
                        p: PRG, b: Binary, g: GFA, a: All. Combinations are
                        allowed i.e., gb: GFA and Binary. Default: a
  -F, --force           Force overwrite previous output
  -t THREADS, --threads THREADS
                        Number of threads. 0 will use all available. Default:
                        1
  -v, --verbose         Increase output verbosity (-v for debug, -vv for trace
                        - trace is for developers only)
  --log LOG             Path to write log to. Default is stderr
```


## make_prg_update

### Tool Description
Updates a PRG database with new sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/make_prg:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/rmcolq/make_prg
- **Package**: https://anaconda.org/channels/bioconda/packages/make_prg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: make_prg update

options:
  -h, --help            show this help message and exit
  -u UPDATE_DS, --update-DS UPDATE_DS
                        Filepath to the update data structures (a
                        *.update_DS.zip file created from make_prg from_msa or
                        update)
  -o OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        Prefix for the output files
  -d DENOVO_PATHS, --denovo-paths DENOVO_PATHS
                        Filepath containing denovo sequences. Should point to
                        a denovo_paths.txt file
  -D LONG_DELETION_THRESHOLD, --deletion-threshold LONG_DELETION_THRESHOLD
                        Ignores long deletions of the given size or longer. If
                        long deletions should not be ignored, put a large
                        value. Default: 10
  -O OUTPUT_TYPE, --output-type OUTPUT_TYPE
                        p: PRG, b: Binary, g: GFA, a: All. Combinations are
                        allowed i.e., gb: GFA and Binary. Default: a
  -F, --force           Force overwrite previous output
  -t THREADS, --threads THREADS
                        Number of threads. 0 will use all available. Default:
                        1
  -v, --verbose         Increase output verbosity (-v for debug, -vv for trace
                        - trace is for developers only)
  --log LOG             Path to write log to. Default is stderr
```

