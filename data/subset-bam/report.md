# subset-bam CWL Generation Report

## subset-bam

### Tool Description
Subsetting 10x Genomics BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/subset-bam:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/10XGenomics/subset-bam
- **Package**: https://anaconda.org/channels/bioconda/packages/subset-bam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/subset-bam/overview
- **Total Downloads**: 961
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/10XGenomics/subset-bam
- **Stars**: N/A
### Original Help Text
```text
subset-bam 1.1.0
Ian Fiddes <ian.fiddes@10xgenomics.com>, Wyatt McDonnell <wyatt.mcdonnell@10xgenomics.com>
Subsetting 10x Genomics BAM files

USAGE:
    subset-bam [OPTIONS] --bam <FILE> --cell-barcodes <FILE> --out-bam <OUTPUT_FILE>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -b, --bam <FILE>               Cellranger BAM file.
        --bam-tag <bam_tag>        Change from default value (CB) to subset alignments based on alternative tags.
                                   [default: CB]
    -c, --cell-barcodes <FILE>     File with cell barcodes to be extracted.
        --cores <INTEGER>          Number of cores to use. If larger than 1, will write BAM subsets to temporary files
                                   before merging. [default: 1]
        --log-level <log_level>    Logging level. [default: error]  [possible values: info, debug, error]
    -o, --out-bam <OUTPUT_FILE>    Output BAM.
```

