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


## seqhax_preapp

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
docker: Error response from daemon: symlink ../df03e17b5de876a9a66c55087640a747e95980a4756a9cbe242e05bfa3252771/diff /var/lib/docker/overlay2/l/USIFJR6YE6VASWPT6J7CECCHEW: no space left on device

Run 'docker run --help' for more information
```


## seqhax_randseq

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
docker: Error response from daemon: mkdir /var/lib/docker/overlay2/96b0ed56bc5db6ca9f3dc5a98da5027af2a815569b94358c4d82fe157d77c08f-init: no space left on device

Run 'docker run --help' for more information
```


## seqhax_rebarcode

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
docker: Error response from daemon: mkdir /var/lib/docker/overlay2/3896599d2f5f666508106f4b8b70f2452f879c420092385f7c0d797c12c57587-init: no space left on device

Run 'docker run --help' for more information
```


## seqhax_stats

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
docker: Error response from daemon: mkdir /var/lib/docker/overlay2/4fbc085e4884e300d9a88cfe8c6fdf9cfd56559137d2fb02c86af388a3d200cf-init: no space left on device

Run 'docker run --help' for more information
```


## seqhax_trunc

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
- **Homepage**: https://github.com/kdmurray91/seqhax
- **Package**: https://anaconda.org/channels/bioconda/packages/seqhax/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
docker: Error response from daemon: mkdir /var/lib/docker/overlay2/daa9fa03c9b07777950b9127d492b03f8c6f695f95fcfb26a341ff62ddfbe1a7-init: no space left on device

Run 'docker run --help' for more information
```

