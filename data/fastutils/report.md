# fastutils CWL Generation Report

## fastutils_stat

### Tool Description
Compute statistics for fasta/q files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/haghshenas/fastutils
- **Stars**: N/A
### Original Help Text
```text
Usage: fastutils stat [options]

I/O options:
     -i,--in STR         input file in fasta/q format [stdin]
     -o,--out STR        output file [stdout]

More options:
     -m,--minLen INT     min read length [0]
     -M,--maxLen INT     max read length [INT64_MAX]
     -h,--help           print this help
```


## fastutils_length

### Tool Description
Calculates length statistics for sequences in FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fastutils length [options]

I/O options:
     -i,--in STR            input file in fasta/q format [stdin]
     -o,--out STR           output file [stdout]

More options:
     -m,--minLen INT        min read length [0]
     -M,--maxLen INT        max read length [LLONG_MAX]
     -t,--total             print total number of bases in third column
     -h,--help              print this help
```


## fastutils_format

### Tool Description
Format FASTA/FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fastutils format [options]

I/O options:
     -i,--in STR            input file in fasta/q format [stdin]
     -o,--out STR           output file [stdout]

More options:
     -w,--lineWidth INT     size of lines in fasta output. Use 0 for no wrapping [0]
     -m,--minLen INT        min read length [0]
     -M,--maxLen INT        max read length [LLONG_MAX]
     -q,--fastq             output reads in fastq format if possible
     -n,--noN               do not print entries with N's
     -c,--comment           print comments in headers
     -d,--digital           use read index instead as read name
     -k,--keep              keep name as a comment when using -d
     -p,--prefix STR        prepend STR to the name
     -s,--suffix STR        append STR to the name
     -P,--pacbio            use pacbio's header format
     -f,--fofn              input file is a file of file names
     -h,--help              print this help
```


## fastutils_interleave

### Tool Description
Interleaves paired-end sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fastutils interleave [options] -1 lib1_1.fq -2 lib1_2.fq [-1 lib2_1.fq -2 lib2_2.fq ...]

I/O options:
     -1,--in1 STR           fasta/q file containing forward (left) reads [required]
     -2,--in2 STR           fasta/q file containing reverse (right) reads [required]
     -o,--out STR           output interlaced reads in STR file [stdout]
More options:
     -q,--fastq              output reads in fastq format if possible
     -s,--separator CHR     separator character [.]
     -h,--help              print this help
```


## fastutils_revcomp

### Tool Description
Reverse complement sequences in FASTA/Q format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fastutils revcomp

I/O options:
     -i,--in STR            input file in fasta/q format [stdin]
     -o,--out STR           output file [stdout]

More options:
     -w,--lineWidth INT     size of lines in fasta output. Use 0 for no wrapping [0]
     -q,--fastq             output reads in fastq format if possible
     -c,--comment           print comments in headers
     -l,--lex               output lexicographically smaller sequence
     -h,--help              print this help
```


## fastutils_subsample

### Tool Description
Subsamples reads from an input file based on coverage depth and genome size.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fastutils subsample -i input -d depth -g genomeSize

I/O options:
     -i,--in STR            input file in fasta/q format. This options is required if -r or -l are used [stdin]
     -o,--out STR           output file [stdout]

More options:
     -d,--depth INT         coverage of the subsampled set [required]
     -g,--genomeSize FLT    length of the genome. Accepted suffixes are k,m,g [required]
     -r,--random            subsample randomly instead of selecting top reads
     -l,--longest           subsample longest reads instead of selecting top reads
     -s,--seed INT          seed for random number generator
     -q,--fastq             output reads in fastq format if possible
     -c,--comment           print comments in headers
     -n,--num               use read index instead of read name
     -k,--keep              keep name as a comment when using -n
     -f,--fofn              input file is a file of file names
     -h,--help              print this help
```


## fastutils_subseq

### Tool Description
Extract subsequences from FASTX files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fastutils subseq [options] <name:start-end>

Required options:
         -i STR        input file in fastx format. Use - for stdin.
         -o STR        output file. Use - for stdout.

More options:
         -v            print version and build date
         -h            print this help
```


## fastutils_cutN

### Tool Description
Cut Ns from fastx sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/fastutils:0.3--h077b44d_5
- **Homepage**: https://github.com/haghshenas/fastutils
- **Package**: https://anaconda.org/channels/bioconda/packages/fastutils/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fastutils cutN [options]

Required options:
         -i STR        input file in fastx format. Use - for stdin.
         -o STR        output file in fasta format. Use - for stdout.

More options:
         -v            print version and build date
         -h            print this help
```


## Metadata
- **Skill**: generated
