# bamhash CWL Generation Report

## bamhash_bamhash_checksum_bam

### Tool Description
Checksum of a sam, bam or cram file

### Metadata
- **Docker Image**: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
- **Homepage**: https://github.com/DecodeGenetics/BamHash
- **Package**: https://anaconda.org/channels/bioconda/packages/bamhash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamhash/overview
- **Total Downloads**: 19.8K
- **Last updated**: 2025-10-14
- **GitHub**: https://github.com/DecodeGenetics/BamHash
- **Stars**: N/A
### Original Help Text
```text
bamhash_checksum_bam - Checksum of a sam, bam or cram file
==========================================================

SYNOPSIS
    bamhash_checksum_bam [OPTIONS] <in.bam> <in2.bam> ...

DESCRIPTION
    Program for checksum of sequence reads.

    -h, --help
          Display the help message.
    --version
          Display version information.

  Options:
    -d, --debug
          Debug mode. Prints full hex for each read to stdout
    -R, --no-readnames
          Do not use read names as part of checksum
    -Q, --no-quality
          Do not use read quality as part of checksum
    -P, --no-paired
          Cram files were not generated with paired-end reads
    -r, --reference-file FILE
          Path to reference-file if reference not given in header Valid
          filetype is: fa.

VERSION
    Last update: Oct 2018
    bamhash_checksum_bam version: 1.3
    SeqAn version: 2.1.0
```


## bamhash_bamhash_checksum_fastq

### Tool Description
Program for checksum of sequence reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
- **Homepage**: https://github.com/DecodeGenetics/BamHash
- **Package**: https://anaconda.org/channels/bioconda/packages/bamhash/overview
- **Validation**: PASS

### Original Help Text
```text
bamhash_checksum_fastq - Checksum of a set of fastq files
=========================================================

SYNOPSIS
    bamhash_checksum_fastq [OPTIONS] <in1.fastq.gz> [in2.fastq.gz ... ]

DESCRIPTION
    Program for checksum of sequence reads.

    -h, --help
          Display the help message.
    --version
          Display version information.

  Options:
    -d, --debug
          Debug mode. Prints full hex for each read to stdout
    -R, --no-readnames
          Do not use read names as part of checksum
    -Q, --no-quality
          Do not use read quality as part of checksum
    -P, --no-paired
          List of fastq files are not paired-end reads

VERSION
    Last update: Okt 2018
    bamhash_checksum_fastq version: 1.3
    SeqAn version: 2.1.0
```


## bamhash_bamhash_checksum_fasta

### Tool Description
Checksum of a set of fasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
- **Homepage**: https://github.com/DecodeGenetics/BamHash
- **Package**: https://anaconda.org/channels/bioconda/packages/bamhash/overview
- **Validation**: PASS

### Original Help Text
```text
bamhash_checksum_fasta - Checksum of a set of fasta files
=========================================================

SYNOPSIS
    bamhash_checksum_fasta [OPTIONS] <in1.fasta> [in2.fasta ... ]

DESCRIPTION
    Program for checksum of sequence reads.

    -h, --help
          Display the help message.
    --version
          Display version information.

  Options:
    -d, --debug
          Debug mode. Prints full hex for each read to stdout
    -R, --no-readnames
          Do not use read names as part of checksum

VERSION
    Last update: Okt 2018
    bamhash_checksum_fasta version: 1.3
    SeqAn version: 2.1.0
```


## Metadata
- **Skill**: generated
