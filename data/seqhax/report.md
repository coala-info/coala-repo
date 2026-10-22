# seqhax CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seqhax_anon | PASS |  |
| seqhax_clihist | PASS |  |
| seqhax_convert | PASS |  |
| seqhax_filter | PASS |  |
| seqhax_pairs | PASS |  |
| seqhax_pecheck | PASS |  |
| seqhax_preapp | PASS |  |
| seqhax_randseq | PASS |  |
| seqhax_rebarcode | PASS | synthetic data: Illumina index added to real read headers |
| seqhax_stats | PASS |  |
| seqhax_trunc | PASS |  |

## seqhax_anon

### Tool Description
Anonymize sequence headers in a file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kdmurray91/seqhax
- **Stars**: N/A
### Original Help Text
```text
USAGE:
    seqhax anon [options] FILE

OPTIONS:
    -x     Use base-16 sequence IDs.
    -p     Treat reads as pairs, add /1 or /2 to headers.
```

## seqhax_convert

### Tool Description
Convert sequence files to FASTA or FASTQ format

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
convert: invalid option -- '-'
USAGE:
    seqhax convert [options] FILE

OPTIONS:
    -a     Output FASTA.
    -q     Output FASTQ (adding qualities).
```

## seqhax_filter

### Tool Description
Filter sequence files based on length and format options.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax filter [options] FILE

OPTIONS:
    -l LENGTH  Minimum length of each read. [default 1]
    -f         Output as fasta (no qualities)
    -p         Paired mode: reads are kept/discared in pairs

FILE should be a sequence file in FASTA or FASTQ format.
To accept reads from standard input, use '/dev/stdin' as
the input file.
```

## seqhax_pairs

### Tool Description
Process and split paired-end sequence files in FASTA or FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax pairs [options] FILE [FILE2]

OPTIONS:
    -f         Force output to existing files.
    -l LENGTH  Minimum length of each read. [default 1]
    -1 FILE    Pair first mate output
    -2 FILE    Pair second mate output
    -p FILE    Interleaved pairs-only output
    -u FILE    Unpaired read output
    -s FILE    "Strict interleaved" output, all reads
    -b FILE    "Broken paired" output, all reads
    -y FILE    Output statistics to FILE.

Output files are NOT compressed. To apply compression, please use
subprocess streams, for example:

  seqhax pairs -1 >(gzip > read1.fq.gz) -2 >(gzip > read2.fq.gz) \
      -u >(gzip > unpaired.fq.gz) reads.fq.gz

One can of course use other compression algorithms, e.g zstd.

FILE should be a sequence file in FASTA or FASTQ format.
To accept reads from standard input, use '/dev/stdin' as
the input file. To output to standard output, use '/dev/stdout'.
To discard some reads (e.g. unpaired reads), use '/dev/null' as
the filename (i.e. -u /dev/null to discard unpaired reads).'
```

## seqhax_clihist

### Tool Description
Records a histogram of stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
Records a histogram of stdin.

USAGE:
    seqhax clihist < input.txt
```

## seqhax_pecheck

### Tool Description
Check that paired end reads match properly

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax pecheck [OPTIONS] r1fq r2fq [r1fq r2fq ...]
    seqhax pecheck [OPTIONS] -i ilfq [ilfq ilfq ...]

OPTIONS:
    -o FILE        Output interleaved reads to FILE. Use - for stdout.
                   All sets of paired end files will end up in same
                   output!!! (default: no output)
    -i             Interleaved inputs
    -q             Don't print tabular summary
    -t THREADS     Number of parallel threads (default: no output)
```

## seqhax_preapp

### Tool Description
Prepend or append string to sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax seq [options] FILE

OPTIONS:
    -P SEQ     Add SEQ as prefix, adding quality charachters if fastq.
    -S SEQ     Add SEQ as suffix, adding quality charachters if fastq.
    -p         Paired mode: reads are kept/discared in pairs

FILE should be a sequence file in FASTA or FASTQ format.
To accept reads from standard input, use '/dev/stdin' as
the input file.
```

## seqhax_randseq

### Tool Description
Generate a random sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax randseq [options]

OPTIONS:
    -n READS   Number of reads. Use 0 for infinite. [default 1000]
    -s SEED    Seed for RNG.
    -l LENGTH  Length of each read. [default 100]
    -p         Paired reads [default false]
    -f         Output as fasta (no qualities)
```

## seqhax_rebarcode

### Tool Description
Add index sequences from header to the start of reads

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax rebarcode [-o OUTPUT] r1 r2

OPTIONS:
    -o FILE    Output interleaved reads to FILE. Use - for stdout. (default: no output)
```

## seqhax_stats

### Tool Description
Basic statistics about sequence files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax stats FILE ...

OPTIONS:
    -t THREADS  Number of parallel jobs [1]

FILEs must be FASTQs, optionally gzip-compressed
```

## seqhax_trunc

### Tool Description
Truncate sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
    seqhax trunc [options] FILE

OPTIONS:
    -l LEN     Fixed (integer) length to truncate at.
    -p PROP    Truncate at PROP * length bases

At least one of `-l` and `-p` MUST be given.
FILE should be a sequence file in FASTA or FASTQ format.
To accept reads from standard input, use '/dev/stdin' as
the input file.
```

## Metadata
- **Skill**: generated
