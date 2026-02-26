# namfinder CWL Generation Report

## namfinder

### Tool Description
namfinder 0.1.2

### Metadata
- **Docker Image**: quay.io/biocontainers/namfinder:0.1.3--h077b44d_2
- **Homepage**: https://github.com/ksahlin/namfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/namfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/namfinder/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ksahlin/namfinder
- **Stars**: N/A
### Original Help Text
```text
namfinder reference [reads1] [reads2] {OPTIONS}

    namfinder 0.1.2

  OPTIONS:

      -h, --help    Print help and exit
      --version     Print version and exit
      -t [INT], --threads=[INT]
                    Number of threads [3]
      Input/output:
      -o [PATH]     redirect output to file [stdout]
      -v            Verbose output
      -S            Sort output NAMs for each query based on score. Default is to sort
                    first by ref ID, then by query coordinate, then by reference
                    coordinate.
      -N [INT]      Retain at most INT secondary alignments (is upper bounded by -M and
                    depends on -S) [0]
      --index-statistics=[PATH]
                    Print statistics of indexing to PATH
      -i, --create-index
                    Do not map reads; only generate the strobemer index and write it to
                    disk. If read files are provided, they are used to estimate read
                    length
      --use-index   Use a pre-generated index previously written with --create-index.
      Seeding:
      -m [INT]      Maximum seed length. the seed length distribution is usually
                    determined by parameters l and u. Then, this parameter is only active
                    in regions where syncmers are very sparse.
      -k [INT]      Strobe length, has to be below 32. [20]
      -l [INT]      Lower syncmer offset from k/(k-s+1). Start sample second syncmer
                    k/(k-s+1) + l syncmers downstream [0]
      -u [INT]      Upper syncmer offset from k/(k-s+1). End sample second syncmer
                    k/(k-s+1) + u syncmers downstream [7]
      -c [INT]      Bitcount length between 2 and 63. [8]
      -s [INT]      Submer size used for creating syncmers [k-4]. Only even numbers on k-s
                    allowed. A value of s=k-4 roughly represents w=10 as minimizer window
                    [k-4]. It is recommended not to change this parameter unless you have
                    a good understanding of syncmers as it will drastically change the
                    memory usage and results with non default values.
      Search parameters:
      -C [INT]      Mask (do not process) strobemer hits with count larger than C [1000]
      -L [INT]      Print at most L NAMs per query [1000]. Will print the NAMs with
                    highest score S = n_strobemer_hits * query_span.
      reference     Reference in FASTA format
      reads1        Reads 1 in FASTA or FASTQ format, optionally gzip compressed
      reads2        Reads 2 in FASTA or FASTQ format, optionally gzip compressed

Error: Option 'reference' is required
```

