# fastqtk CWL Generation Report

## fastqtk_interleave

### Tool Description
It interleaves two input paired-end FASTQ files into one output FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-06-08
- **GitHub**: https://github.com/ndaniel/fastqtk
- **Stars**: N/A
### Original Help Text
```text
Usage:   fastqtk  interleave  <in1.fq>  <in2.fq>  <out.fq>

It interleaves two input paired-end FASTQ files into one output FASTQ file.
For redirecting output to STDOUT use - instead of <out.fq>.
```


## fastqtk_deinterleave

### Tool Description
It splits an interleaved input FASTQ file into two paired-end FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  deinterleave  <in.fq>  <out1.fq>  <out2.fq>

It splits an interleaved input FASTQ file into two paired-end FASTQ files.
For input from STDIN use - instead of <in.fq>.
```


## fastqtk_count

### Tool Description
It provides the total number of reads from an input FASTQ file and outputs it to a text file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  count  <in.fq>  <out.txt>

It provides the total number of reads from an input FASTQ file and outputs it to a text file.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_lengths

### Tool Description
It provides a summary statistics regarding the lengths of the reads from an input FASTQ file and outputs it to a text file. The output text file contains the unique lengths of the reads found in the input file, which are sorted in descending order.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  lengths  <in.fq>  <out.txt>

It provides a summary statistics regarding the lengths of the reads from an input FASTQ file and outputs it to a text file.
The output text file contains the unique lengths of the reads found in the input file, which are sorted in descending order.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_count-lengths

### Tool Description
It provides total number of reads and a summary statistics regarding the lengths of the reads from an input FASTQ file and outputs it to a text file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  count-lengths  <in.fq>  <count.txt>  <statistics.txt>

It provides total number of reads and a summary statistics regarding the lengths of the reads from an input FASTQ file and outputs it to a text file.
```


## fastqtk_tab-4

### Tool Description
It converts a FASTQ file into a tab-delimited text file with four columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  tab-4  <in.fq>  <fastq.txt>

It converts a FASTQ file into a tab-delimited text file with four columns.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_tab-8

### Tool Description
It converts an interleaved paired-end FASTQ file into a tab-delimited text file with 8 columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  tab-8  <in.fq>  <fastq.txt>

It converts an interleaved paired-end FASTQ file into a tab-delimited text file with 8 columns.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_detab

### Tool Description
Converts a 4 or 8 columns text tab-delimited file into a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  detab  <fastq.txt>  <out.fq>

It converts a 4 or 8 columns text tab-delimited file into a FASTQ file.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_retain-5

### Tool Description
It retains the first N nucleotides from 5' end of the reads from a FASTQ file. N is a non-zero positive integer.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  retain-5  <N>  <in.fq>  <out.fq>

It retains the first N nucleotides from 5' end of the reads from a FASTQ file. N is a non-zero positive integer.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_retain-3

### Tool Description
It retains the last N nucleotides from 3' end of the reads from a FASTQ file. N is a non-zero positive integer.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  retain-3  <N>  <in.fq>  <out.fq>

It retains the last N nucleotides from 3' end of the reads from a FASTQ file. N is a non-zero positive integer.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_trim-5

### Tool Description
It trims N nucleotides from 5' end of the reads from a FASTQ file. N is a non-zero positive integer.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  trim-5  <N>  <in.fq>  <out.fq>

It trims N nucleotides from 5' end of the reads from a FASTQ file. N is a non-zero positive integer.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_trim-3

### Tool Description
It trims N nucleotides from 3' end of the reads from a FASTQ file. N is a non-zero positive integer.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  trim-3  <N>  <in.fq>  <out.fq>

It trims N nucleotides from 3' end of the reads from a FASTQ file. N is a non-zero positive integer.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_trim-id

### Tool Description
It retains the beginning part of the reads ids all the way to the first blank space or newline. Basically the reads ids are truncated after the first blank space if they have one. Also the trims ids for the quality sequences (every third line is changed to +).

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  trim-id  <in.fq>  <out.fq>

It retains the beginning part of the reads ids all the way to the first blank space or newline. Basically the reads ids are
truncated after the first blank space if they have one. Also the trims ids for the quality sequences (every third line is changed to +).
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_trim-poly

### Tool Description
It trims poly-A/C/G/T/N tails at both ends of the reads sequences from a FASTQ file. For redirecting to STDOUT/STDIN use - instead of file name.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  trim-poly <A|C|G|T|N|ACGT>  <M> <in.fq>  <out.fq>

It trims poly-A/C/G/T/N tails at both ends of the reads sequences from a FASTQ file.
For redirecting to STDOUT/STDIN use - instead of file name.

Options:
     *  A|C|G|T|N|ACGT  (nucleotide or nucleotides that form the poly tails that will be trimmed):
               A             - poly-A tails are trimmed.
               C             - poly-C tails are trimmed.
               G             - poly-G tails are trimmed.
               T             - poly-T tails are trimmed.
               N             - poly-N tails are trimmed.
               ACGT          - poly-A, poly-C, poly-G, and poly-T tails are trimmed.
     *  M  (the length of the poly tail; all poly-tails equal or longer than M will be trimmed).
```


## fastqtk_drop-se

### Tool Description
It drops the unparied reads from an interleaved FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  drop-se  <in.fq>  <out.fq>

It drops the unparied reads from an interleaved FASTQ file.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_drop-short

### Tool Description
It drops the reads that have the sequences stricly shorter than N. N is a non-zero positive integer.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  drop-short  <N>  <in.fq>  <out.fq>

It drops the reads that have the sequences stricly shorter than N. N is a non-zero positive integer.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_fq2fa

### Tool Description
It a FASTQ file to FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  fq2fq  <in.fq>  <out.fa>

It a FASTQ file to FASTA file.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_fa2fq

### Tool Description
Converts a FASTA file to a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  fa2fq  <in.fa>  <out.fq>

It a FASTA (generated using 'fastqtk fq2fa') file to FASTQ file.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_compress-id

### Tool Description
It does lossy compression on the reads ids from a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  compress-id  [@|@@|/1|_1|/2|_2|/12|_12]  [N|counts.txt]  <in.fq>  <out.fq>

It does lossy compression on the reads ids from a FASTQ file.
For redirecting to STDOUT/STDIN use - instead of file name.

Options:
     *  N|counts.txt  (count reads; if here is a dot then it is considered that a file has been given):
               N             - number of reads in the input FASTQ file (or a much larger number). [500000].
               counts.txt    - file that contains number of reads in the input FASTQ file <in.fq>, that was generated
                               using 'fastqtk count in.fq counts.txt' beforehand.
     *  @|@@|/1|_1|/2|_2|/12|_12  (settings for generating reads ids):
               @             - does NOT add /1 or /2 to reads ids. (FASTQ file is NOT interleaved) [DEFAULT]
               @@            - does NOT add /1 or /2 to reads ids. (FASTQ file is INTERLEAVED)

               /1            - adds /1 to the end of the reads ids. (FASTQ file is NOT interleaved)
               /2            - adds /2 to the end of the reads ids. (FASTQ file is NOT interleaved)
               /12           - adds /1 and /2 to the end of the reads ids. (FASTQ file is INTERLEAVED
               _1            - adds _1 to the end of the reads ids. (FASTQ file is NOT interleaved)
               _2            - adds _2 to the end of the reads ids. (FASTQ file is NOT interleaved)
               _12           - adds _1 and _2 to the end of the reads ids. (FASTQ file is INTERLEAVED)
```


## fastqtk_NtoA

### Tool Description
It replaces all the As from reads sequences with As in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  NtoA  <in.fq>  <out.fq>

It replaces all the As from reads sequences with As in a FASTQ file.
For redirecting to STDOUT/STDIN use - instead of file name.
```


## fastqtk_rev-com

### Tool Description
It reverse complements all the reads from a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
- **Homepage**: https://github.com/ndaniel/fastqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fastqtk  rev-com  <in.fq>  <out.fq>

It reverse complements all the reads from a FASTQ file.
For redirecting to STDOUT/STDIN use - instead of file name.
```

