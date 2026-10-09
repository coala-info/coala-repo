# hiline CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hiline_align-one-read | PASS | read names shortened to the first word because the SRA length= field breaks samtools import |
| hiline_align-sam-reads | PASS | read names shortened to the first word because the SRA length= field breaks samtools import |
| hiline_align-two-reads | PASS | read names shortened to the first word because the SRA length= field breaks samtools import |
| hiline_index-only | PASS |  |
| hiline_read-sam | PASS | read names shortened to the first word because the SRA length= field breaks samtools import |

## hiline_align-two-reads

### Tool Description
Align Hi-C paired FASTQ reads (two read files), classify the pairs and write them out.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
- **Homepage**: https://github.com/wtsi-hpag/HiLine
- **Package**: https://anaconda.org/channels/bioconda/packages/hiline/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HiLine align-two-reads [OPTIONS] READS...

  Alignment with two read sources.

  READS:
      Two paths to reads in (gzipped) FASTQ format. Use "-" for stdin (for one and only-one path).

Options:
  --rmdups / --no-rmdups  Run samtools mark_dup pipeline on alignment.
                          Default=rmdups
  --trim / --no-trim      Run HiC read trimming, trim sections of reads that
                          align past restriction sites. Default=trim
  --bwa1                  Use bwa mem. Default=False
  --bwa2                  Use bwa-mem2. Default=True
  --minimap2              Use minimap2. Default=False
  --help                  Show this message and exit.
```

## hiline_align-one-read

### Tool Description
Align Hi-C interleaved FASTQ reads, classify the pairs and write them out.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
- **Homepage**: https://github.com/wtsi-hpag/HiLine
- **Package**: https://anaconda.org/channels/bioconda/packages/hiline/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HiLine align-one-read [OPTIONS] READS

  Alignment with one read source.

  READS:
      Path to interleaved reads in (gzipped) FASTQ format. Use "-" for stdin.

Options:
  --rmdups / --no-rmdups  Run samtools mark_dup pipeline on alignment.
                          Default=rmdups
  --trim / --no-trim      Run HiC read trimming, trim sections of reads that
                          align past restriction sites. Default=trim
  --bwa1                  Use bwa mem. Default=False
  --bwa2                  Use bwa-mem2. Default=True
  --minimap2              Use minimap2. Default=False
  --help                  Show this message and exit.
```

## hiline_align-sam-reads

### Tool Description
Align Hi-C reads given as SAM/BAM/CRAM, classify the pairs and write them out.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
- **Homepage**: https://github.com/wtsi-hpag/HiLine
- **Package**: https://anaconda.org/channels/bioconda/packages/hiline/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HiLine align-sam-reads [OPTIONS] READS

  Alignment with SAM/BAM/CRAM reads.

  READS:
      Path to reads in SAM/BAM/CRAM format. Use "-" for stdin.

Options:
  --rmdups / --no-rmdups  Run samtools mark_dup pipeline on alignment.
                          Default=rmdups
  -t, --tag TEXT          SAM tag(s) to append to reads.
  --trim / --no-trim      Run HiC read trimming, trim sections of reads that
                          align past restriction sites. Default=trim
  --bwa1                  Use bwa mem. Default=False
  --bwa2                  Use bwa-mem2. Default=True
  --minimap2              Use minimap2. Default=False
  --help                  Show this message and exit.
```

## hiline_read-sam

### Tool Description
Read an external Hi-C alignment, classify the pairs and write them out.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
- **Homepage**: https://github.com/wtsi-hpag/HiLine
- **Package**: https://anaconda.org/channels/bioconda/packages/hiline/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HiLine read-sam [OPTIONS] SAM

  Read in an external alignment.

  SAM:
      Path to alignment in SAM/BAM/CRAM format. Use "-" for stdin.

Options:
  --rmdups / --no-rmdups  Run samtools mark_dup pipeline on alignment.
                          Default=rmdups
  --help                  Show this message and exit.
```

## hiline_index-only

### Tool Description
Create and save the alignment index of a reference genome only.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
- **Homepage**: https://github.com/wtsi-hpag/HiLine
- **Package**: https://anaconda.org/channels/bioconda/packages/hiline/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HiLine index-only [OPTIONS]

  Alignment index only.

Options:
  --trim / --no-trim  Run HiC read trimming, trim sections of reads that align
                      past restriction sites. Default=trim
  --bwa1              Use bwa mem. Default=False
  --bwa2              Use bwa-mem2. Default=True
  --minimap2          Use minimap2. Default=False
  --help              Show this message and exit.
```
