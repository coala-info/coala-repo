# seqhax CWL Generation Report

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

## Metadata
- **Skill**: generated
