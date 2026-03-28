# kfilt CWL Generation Report

## kfilt_build

### Tool Description
Build a fast hybrid index (Bloom filter + hash table + BK-tree) for efficient k-mer matching

### Metadata
- **Docker Image**: quay.io/biocontainers/kfilt:0.1.1--he881be0_0
- **Homepage**: https://github.com/davidebolo1993/kfilt
- **Package**: https://anaconda.org/channels/bioconda/packages/kfilt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kfilt/overview
- **Total Downloads**: 484
- **Last updated**: 2025-12-28
- **GitHub**: https://github.com/davidebolo1993/kfilt
- **Stars**: N/A
### Original Help Text
```text
Build a fast hybrid index (Bloom filter + hash table + BK-tree) for efficient k-mer matching

Usage:
  kfilt build [flags]

Flags:
  -h, --help            help for build
  -K, --kmer-size int   K-mer size (default 31)
  -k, --kmers string    Input k-mer file (meryl print output)
  -o, --output string   Output index file (default "kfilt.idx")
```


## kfilt_filter

### Tool Description
Filter FASTA/FASTQ reads using hybrid index with Bloom filter quick rejection.

### Metadata
- **Docker Image**: quay.io/biocontainers/kfilt:0.1.1--he881be0_0
- **Homepage**: https://github.com/davidebolo1993/kfilt
- **Package**: https://anaconda.org/channels/bioconda/packages/kfilt/overview
- **Validation**: PASS

### Original Help Text
```text
Filter FASTA/FASTQ reads using hybrid index with Bloom filter quick rejection.

Supports three input modes:
  1. Paired-end (separate files): -1 R1.fq -2 R2.fq
  2. Single-end: -1 reads.fq
  3. Interleaved (mixed paired/single): -I interleaved.fq

For paired-end reads:
  - By default, keeps pair if combined matches >= threshold
  - With --both-match, requires BOTH reads to meet threshold individually

All formats support gzip compression with the -z flag.

Usage:
  kfilt filter [flags]

Flags:
  -B, --both-match             For pairs, require BOTH reads meet threshold
  -z, --compress               Compress output with gzip
  -Z, --compress-level int     Gzip compression level (1-9) (default 6)
  -m, --hamming-dist int       Maximum Hamming distance (default 1)
  -h, --help                   help for filter
  -i, --index string           Index file (default "kfilt.idx")
  -1, --input1 string          Input FASTA/FASTQ R1 or single-end
  -2, --input2 string          Input FASTA/FASTQ R2 for paired-end
  -I, --interleaved string     Interleaved FASTA/FASTQ (mixed paired/single)
  -n, --min-matches int        Minimum matching k-mers required (default 5)
  -o, --output string          Output file
  -f, --output-format string   Output format: fasta or fastq (default "fastq")
  -t, --threads int            Number of threads (default 20)
  -v, --verbose string         Verbose per-read output file (optional)
```


## Metadata
- **Skill**: generated
