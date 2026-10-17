# ptools_bin CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ptools_bin_10x_bam2fastq | Failed | image problem: the command 10x_bam2fastq in the image has a syntax error (imports module ptools_bin.10xbam2fastq), so it cannot start |
| ptools_bin_compress | PASS |  |
| ptools_bin_createDiff | PASS |  |
| ptools_bin_getSeq_genome_wN | PASS |  |
| ptools_bin_getSeq_genome_woN | PASS |  |
| ptools_bin_make_unique | PASS | synthetic data: BC and QT tags of a real 10x BAM renamed to the SR and SY tags the tool needs |
| ptools_bin_pbam2bam | PASS | round trip with createDiff and compress restores clips and indels; base substitutions in M-only CIGARs are not restored, as designed |
| ptools_bin_pbam_mapped_transcriptome | PASS |  |
| ptools_bin_print_unique | PASS | synthetic data: BC and QT tags of a real 10x BAM renamed to the SR and SY tags the tool needs |

## ptools_bin_pbam2bam

### Tool Description
A tool for converting pBAM files to BAM files, supporting different modes such as genome-based conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ENCODE-DCC/ptools_bin
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/pbam2bam", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/ptools_bin/pbam2bam.py", line 17, in main
    if sys.argv[1] == "genome":
IndexError: list index out of range
```


## ptools_bin_pbam_mapped_transcriptome

### Tool Description
A tool to process mapped transcriptome data. Based on the source code, it requires at least one input file as a positional argument.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/pbam_mapped_transcriptome", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/ptools_bin/pbam_mapped_transcriptome.py", line 53, in main
    with open(sys.argv[1], "rt") as f1:
IndexError: list index out of range
```


## ptools_bin_createDiff

### Tool Description
Make a diff text from SAM records on standard input (CIGAR with S, H, I, D or X, plus AS, MD and NM tags)

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage (from the source code; the command has no help option):
createDiff < records.sam > diff.txt
```


## ptools_bin_compress

### Tool Description
Compress a raw file with zlib level 9

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage (from the source code; the command has no help option):
compress <raw file> <output file>
```


## ptools_bin_getSeq_genome_wN

### Tool Description
Rebuild a pBAM from SAM records with splice gaps (N in the CIGAR) using a reference genome

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage (from the source code; the command has no help option):
getSeq_genome_wN <reference.fa> <header.txt> <records.sam>
```


## ptools_bin_getSeq_genome_woN

### Tool Description
Rebuild a pBAM from SAM records without splice gaps using a reference genome

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage (from the source code; the command has no help option):
getSeq_genome_woN <reference.fa> <header.txt> <records.sam>
```


## ptools_bin_make_unique

### Tool Description
List pBAM reads with their SR, CR and UR 10x tags and line numbers (records on standard input)

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage (from the source code; the command has no help option):
make_unique < records.sam
```


## ptools_bin_print_unique

### Tool Description
Print the header and the selected records of a pBAM (reads header.txt and linenumbers.txt from the working directory)

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage (from the source code; the command has no help option):
print_unique < records.sam
```


## ptools_bin_10x_bam2fastq

### Tool Description
Convert 10x pBAM records on standard input to I1, R1 and R2 FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage (from the source code; the command has no help option):
10x_bam2fastq <prefix> < records.sam
```


## Metadata
- **Skill**: generated
