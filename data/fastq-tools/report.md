# fastq-tools CWL Generation Report

## fastq-tools_fastq-sample

### Tool Description
Sample random reads from a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastq-tools:0.8.3--h1104d80_7
- **Homepage**: http://homes.cs.washington.edu/~dcjones/fastq-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/fastq-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastq-tools/overview
- **Total Downloads**: 21.3K
- **Last updated**: 2025-08-19
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
fastq-sample [OPTION]... FILE [FILE2]
Sample random reads from a FASTQ file.Options:
  -n N                    the number of reads to sample (default: 10000)
  -p N                    the proportion of the total reads to sample
  -o, --output=PREFIX     output file prefix
 (Default: "sample")  -c, --complement-output=PREFIX
                          output reads not included in the random sample to
                          a file (or files) with the given prefix (by default,
                          they are not output).
  -r, --with-replacement  sample with replacement
  -s, --seed=SEED         a manual seed to the random number generator
  -h, --help              print this message
  -V, --version           output version information and exit
```


## fastq-tools_fastq-sort

### Tool Description
Concatenate and sort FASTQ files and write to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastq-tools:0.8.3--h1104d80_7
- **Homepage**: http://homes.cs.washington.edu/~dcjones/fastq-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/fastq-tools/overview
- **Validation**: PASS

### Original Help Text
```text
fastq-sort [OPTION]... [FILE]...
Concatenate and sort FASTQ files and write to standard output.
Options:
  -r, --reverse      sort in reverse (i.e., descending) order
  -i, --id           sort alphabetically by read identifier
  -n, --idn          sort alphanumerically by read identifier according to "samtools sort -n"
  -s, --seq          sort alphabetically by sequence
  -R, --random       randomly shuffle the sequences
      --seed[=SEED]  seed to use for random shuffle.
  -G, --gc           sort by GC content
  -M, --mean-qual    sort by median quality score
  -S, --buffer-size=SIZE         amount of memory to use for sorting
  -T, --temporary-directory=DIR  write temporary files here, instead of $TMPDIR, or /tmp
  -h, --help         print this message
  -V, --version      output version information and exit
```

