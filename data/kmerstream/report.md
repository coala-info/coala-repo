# kmerstream CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kmerstream_KmerStream | PASS | real SARS-CoV-2 reads (ENA ERR5069949): total k-mer count F1 exact, F0 distinct estimate runs 7-17% below the exact count (about 1% off on simulated error-free reads); FASTA input and -o with --binary misbehave in the tool (segfault, odd file name) |
| kmerstream_KmerStreamEstimate.py | PASS | table from KmerStream --tsv gets genome size, error rate and coverage columns (about 25k genome size for a 30 kb genome sample) |
| kmerstream_KmerStreamJoin | PASS | two binary sketches joined: F1 11111315 equals the sum of both inputs, F0 79030 close to a direct run on both files |

## kmerstream_KmerStream

### Tool Description
Estimates occurrences of k-mers in fastq or fasta files and saves results

### Metadata
- **Docker Image**: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
- **Homepage**: https://github.com/pmelsted/KmerStream
- **Package**: https://anaconda.org/channels/bioconda/packages/kmerstream/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmerstream/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pmelsted/KmerStream
- **Stars**: N/A
### Original Help Text
```text
KmerStream 1.1

Estimates occurrences of k-mers in fastq or fasta files and saves results

Usage: KmerStream [options] ... FASTQ files

-k, --kmer-size=INT      Size of k-mers, either a single value or comma separated list
-q, --quality-cutoff=INT Comma separated list, keep k-mers with bases above quality threshold in PHRED (default 0)
-o, --output=STRING      Filename for output
-e, --error-rate=FLOAT   Error rate guaranteed (default value 0.01)
-t, --threads=INT        SNumber of threads to use (default value 1)
-s, --seed=INT           Seed value for the randomness (default value 0, use time based randomness)
-b, --bam                Input is in BAM format (default false)
    --binary             Output is written in binary format (default false)
    --tsv                Output is written in TSV format (default false)
    --verbose            Print lots of messages during run
    --online             Prints out estimates every 100K reads
    --q64                set if PHRED+64 scores are used (@...h) default used PHRED+33
```


## kmerstream_KmerStreamJoin

### Tool Description
Creates union of many stream estimates

### Metadata
- **Docker Image**: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
- **Homepage**: https://github.com/pmelsted/KmerStream
- **Package**: https://anaconda.org/channels/bioconda/packages/kmerstream/overview
- **Validation**: PASS

### Original Help Text
```text
KmerStreamJoin 1.1

Creates union of many stream estimates

Usage: KmerStreamJoin -o output files ...
       KmerStreamJoin merged-file

-o, --output=STRING      Filename for output
    --verbose            Print output at the end
```


## kmerstream_KmerStreamEstimate.py

### Tool Description
Estimates genome size, error rate and coverage from the TSV output of KmerStream.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
- **Homepage**: https://github.com/pmelsted/KmerStream
- **Package**: https://anaconda.org/channels/bioconda/packages/kmerstream/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: estimate.py TSV-FILE
```

## Metadata
- **Skill**: generated
