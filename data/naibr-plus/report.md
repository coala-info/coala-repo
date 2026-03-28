# naibr-plus CWL Generation Report

## naibr-plus_naibr

### Tool Description
NAIBR identifies novel adjacencies created by structural variation events such as deletions, duplications, inversions, and complex rearrangements using linked-read whole-genome sequencing data as produced by 10X Genomics. Please refer to the publication for details about the method.

### Metadata
- **Docker Image**: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/pontushojer/NAIBR
- **Package**: https://anaconda.org/channels/bioconda/packages/naibr-plus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/naibr-plus/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pontushojer/NAIBR
- **Stars**: N/A
### Original Help Text
```text
NAIBR - Novel Adjacency Identification with Barcoded Reads

Usage: naibr input.config

Running requires a config file with "=" separated parameters and values.

required:
    bam_file   - str  - Path to BAM file with phased linked reads, i.e. has BX and HP tags.

options:
    outdir     - str  - Path to output directory. Default: CWD
    blacklist  - str  - Path to BED file with regions to ignore
    candidates - str  - Path to BEDPE with candidiate SVs to evaluate
    d          - int  - Maximum distance between read-pairs in a linked-read. Default: 10,000
    min_mapq   - int  - Minimum mapping quality to evaluate reads. Default: 40
    k          - int  - Minimum number of barcode overlaps supporting a candidate NA. Default: 3
    min_sv     - int  - Minimum size of structural variant. Default: 1000
    sd_mult    - int  - Stddev multiplier for max/min insert size (LMAX/LMIN) calculcation. Default: 2
    min_len    - int  - Minimum length of linked read fragment. Default: 2*LMAX
    max_len    - int  - TO_BE_ADDED. Default: 200,000
    min_reads  - int  - Minimum reads in linked read fragment. Default: 2
    min_discs  - int  - Minimum number of discordant reads. Default: 2
    threads    - int  - Threads to use. Default: 1
    prefix     - str  - Prefix for output files. Default: NAIBR_SVs
    DEBUG      - bool - Run in debug mode. Default: False

About:

    NAIBR identifies novel adjacencies created by structural variation events such as
    deletions, duplications, inversions, and complex rearrangements using linked-read
    whole-genome sequencing data as produced by 10X Genomics. Please refer to the
    publication for details about the method.

Citation:

    Elyanow R, Wu HT, Raphael BJ. Identifying structural variants using linked-read
    sequencing data. Bioinformatics. 2018 Jan 15;34(2):353-360.
    doi: 10.1093/bioinformatics/btx712
```


## naibr-plus_bedpe_to_vcf.py

### Tool Description
Convert NAIBR BEDPE files to VCF

### Metadata
- **Docker Image**: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/pontushojer/NAIBR
- **Package**: https://anaconda.org/channels/bioconda/packages/naibr-plus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedpe_to_vcf.py [-h] -r REF [-o OUTPUT_VCF] [--add-chr]
                       [-s SAMPLE_NAME]
                       bedpe

Convert NAIBR BEDPE files to VCF

positional arguments:
  bedpe                 NAIBR-style BEDPE.

options:
  -h, --help            show this help message and exit
  -r REF, --ref REF     List of chromosome lengths e.g. `*.fai`
  -o OUTPUT_VCF, --output-vcf OUTPUT_VCF
                        Output VCF. Default: write to stdout
  --add-chr             Prepend 'chr' to chromsome names
  -s SAMPLE_NAME, --sample-name SAMPLE_NAME
                        Sample name. Default: SAMPLE
```


## Metadata
- **Skill**: generated
