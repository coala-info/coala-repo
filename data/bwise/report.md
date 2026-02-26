# bwise CWL Generation Report

## bwise

### Tool Description
High order De Bruijn graph assembler

### Metadata
- **Docker Image**: quay.io/biocontainers/bwise:1.0.0--h8b12597_0
- **Homepage**: https://github.com/Malfoy/BWISE
- **Package**: https://anaconda.org/channels/bioconda/packages/bwise/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwise/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Malfoy/BWISE
- **Stars**: N/A
### Original Help Text
```text
*** This is BWISE - High order De Bruijn graph assembler ***

usage: bwise [-h] [-x PAIRED_READFILES] [-u SINGLE_READFILES]
             [-s KMER_SOLIDITY] [-S KMER_COVERAGE] [-p SR_SOLIDITY]
             [-P SR_COVERAGE] [-k K_MIN] [-K K_MAX] [-e MAPPING_EFFORT]
             [-a ANCHOR_SIZE] [-i FRACTION_ANCHOR] [-A MAX_OCCURENCE]
             [-m MISSMATCH_ALLOWED] [-g GREEDY_K2000] [-t NB_CORES]
             [-o OUT_DIR] [-H HAPLO_MODE] [--version]

Bwise - High order De Bruijn graph assembler

optional arguments:
  -h, --help            show this help message and exit
  -x PAIRED_READFILES   input fasta or (compressed .gz if -c option is != 0)
                        paired-end read files. Several read files must be
                        concatenated.
  -u SINGLE_READFILES   input fasta or (compressed .gz if -c option is != 0)
                        single-end read files. Several read files must be
                        concatenated.
  -s KMER_SOLIDITY      an integer, k-mers present strictly less than this
                        number of times in the dataset will be discarded
                        (default 2)
  -S KMER_COVERAGE      an integer, minimal unitig coverage for first cleaning
                        (default 5)
  -p SR_SOLIDITY        an integer, super-reads present strictly less than
                        this number of times will be discarded (default 3)
  -P SR_COVERAGE        an integer, unitigs with less than S reads mapped is
                        filtred (default 3)
  -k K_MIN              an integer, smallest k-mer size (default 63)
  -K K_MAX              an integer, largest k-mer size (default 201)
  -e MAPPING_EFFORT     Anchors to test for mapping (default 1000)
  -a ANCHOR_SIZE        Anchors size (default 31)
  -i FRACTION_ANCHOR    Fraction of the anchor that are indexed (default all,
                        put 10 to index one out of 10 anchors)
  -A MAX_OCCURENCE      maximal ccurence for an indexed anchor (default 1)
  -m MISSMATCH_ALLOWED  missmatch allowed in mapping (default 10)
  -g GREEDY_K2000       Greedy contig extension
  -t NB_CORES           number of cores used (default max)
  -o OUT_DIR            path to store the results (default = current
                        directory)
  -H HAPLO_MODE         Produce a haploid assembly
  --version             show program's version number and exit
```

