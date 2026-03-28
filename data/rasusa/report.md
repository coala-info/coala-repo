# rasusa CWL Generation Report

## rasusa_reads

### Tool Description
Randomly subsample reads

### Metadata
- **Docker Image**: quay.io/biocontainers/rasusa:3.0.0--h54198d6_0
- **Homepage**: https://github.com/mbhall88/rasusa
- **Package**: https://anaconda.org/channels/bioconda/packages/rasusa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rasusa/overview
- **Total Downloads**: 50.1K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/mbhall88/rasusa
- **Stars**: N/A
### Original Help Text
```text
Randomly subsample reads

Usage: rasusa reads [OPTIONS] <FILE(S)>...

Arguments:
  <FILE(S)>...
          The fast{a,q} file(s) to subsample.
          
          For paired Illumina, the order matters. i.e., R1 then R2.

Options:
  -o, --output <OUTPUT>
          Output filepath(s); stdout if not present.
          
          For paired Illumina pass this flag twice `-o o1.fq -o o2.fq`
          
          NOTE: The order of the pairs is assumed to be the same as the input - e.g., R1 then R2.
          
          This option is required for paired input.

  -g, --genome-size <size|faidx>
          Genome size to calculate coverage with respect to. e.g., 4.3kb, 7Tb, 9000, 4.1MB
          
          Alternatively, a FASTA/Q index file can be provided and the genome size will be set to the sum of all reference sequences.
          
          If --bases is not provided, this option and --coverage are required

  -c, --coverage <FLOAT>
          The desired depth of coverage to subsample the reads to
          
          If --bases is not provided, this option and --genome-size are required

  -b, --bases <bases>
          Explicitly set the number of bases required e.g., 4.3kb, 7Tb, 9000, 4.1MB
          
          If this option is given, --coverage and --genome-size are ignored

  -n, --num <INT>
          Subsample to a specific number of reads
          
          If paired-end reads are passed, this is the number of (matched) reads from EACH file. This option accepts the same format as genome size - e.g., 1k will take 1000 reads

  -f, --frac <FLOAT>
          Subsample to a fraction of the reads - e.g., 0.5 samples half the reads
          
          Values >1 and <=100 will be automatically converted - e.g., 25 => 0.25

  -e, --strict
          Exit with an error if the requested coverage/bases/reads is not possible

  -s, --seed <INT>
          Random seed to use

  -v
          Switch on verbosity

  -O, --output-type <u|b|g|l|x|z>
          u: uncompressed; b: Bzip2; g: Gzip; l: Lzma; x: Xz (Lzma); z: Zstd
          
          Rasusa will attempt to infer the output compression format automatically from the filename extension. This option is used to override that. If writing to stdout, the default is uncompressed

  -l, --compress-level <1-21>
          Compression level to use if compressing output. Uses the default level for the format if not specified

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## rasusa_aln

### Tool Description
Randomly subsample alignments to a specified depth of coverage

### Metadata
- **Docker Image**: quay.io/biocontainers/rasusa:3.0.0--h54198d6_0
- **Homepage**: https://github.com/mbhall88/rasusa
- **Package**: https://anaconda.org/channels/bioconda/packages/rasusa/overview
- **Validation**: PASS

### Original Help Text
```text
Randomly subsample alignments to a specified depth of coverage

Usage: rasusa aln [OPTIONS] --coverage <INT> <FILE>

Arguments:
  <FILE>
          Path to the input alignment file (SAM/BAM/CRAM) to subsample
          
          Note: An index (.bai) is required when using '--strategy fetch'.

Options:
  -o, --output <FILE>
          Path to the output subsampled alignment file. Defaults to stdout (same format as input)
          
          The output is not guaranteed to be sorted. We recommend piping the output to `samtools sort`

  -O, --output-type <FMT>
          Output format. Rasusa will attempt to infer the format from the output file extension if not provided

  -c, --coverage <INT>
          The desired depth of coverage to subsample the alignment to

  -s, --seed <INT>
          Random seed to use

      --strategy <STRATEGY>
          Subsampling strategy

          Possible values:
          - stream: A linear scan approach using sweep line algorithm with random priority. Requires sorted alignment input
          - fetch:  A fetching approach to randomly subsample reads given read overlap position. Requires indexed input (.bai)
          
          [default: stream]

      --swap-distance <INT>
          [Stream] A maximum distance (bp) allowed between start position of new read and the worst read in the heap to consider them to be 'swappable'.
          
          Larger values allow swapping reads over greater distances, but may cause local undersampling. A value of `0` means only allows swap between reads that have the same start position.
          
          [default: 5]

      --step-size <INT>
          [Fetch] When a region has less than the desired coverage, the step size to move along the chromosome to find more reads.
          
          The lowest of the step and the minimum end coordinate of the reads in the region will be used. This parameter can have a significant impact on the runtime of the subsampling process.
          
          [default: 100]

      --batch-size <INT>
          [Fetch] The size of the genomic window (bp) to cache into memory at once.
          
          Larger values reduce disk seeking, but at the cost of high memory usage. The minimum value is 1,000 bp to avoid small region queries.
          
          [default: 10000]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## rasusa_cite

### Tool Description
Rasusa: Randomly subsample sequencing reads to a specified coverage

### Metadata
- **Docker Image**: quay.io/biocontainers/rasusa:3.0.0--h54198d6_0
- **Homepage**: https://github.com/mbhall88/rasusa
- **Package**: https://anaconda.org/channels/bioconda/packages/rasusa/overview
- **Validation**: PASS

### Original Help Text
```text
@article{Hall2022,
  doi = {10.21105/joss.03941},
  url = {https://doi.org/10.21105/joss.03941},
  year = {2022},
  publisher = {The Open Journal},
  volume = {7},
  number = {69},
  pages = {3941},
  author = {Michael B. Hall},
  title = {Rasusa: Randomly subsample sequencing reads to a specified coverage},
  journal = {Journal of Open Source Software}
}
```


## Metadata
- **Skill**: generated
