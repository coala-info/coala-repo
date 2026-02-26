# vartrix CWL Generation Report

## vartrix

### Tool Description
Variant assignment for single cell genomics

### Metadata
- **Docker Image**: quay.io/biocontainers/vartrix:1.1.22--h9ee0642_6
- **Homepage**: https://github.com/10XGenomics/vartrix
- **Package**: https://anaconda.org/channels/bioconda/packages/vartrix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vartrix/overview
- **Total Downloads**: 4.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/10XGenomics/vartrix
- **Stars**: N/A
### Original Help Text
```text
vartrix 1.1.22
Ian Fiddes <ian.fiddes@10xgenomics.com> and Patrick Marks <patrick@10xgenomics.com>
Variant assignment for single cell genomics

USAGE:
    vartrix [FLAGS] [OPTIONS] --bam <FILE> --cell-barcodes <FILE> --fasta <FILE> --vcf <FILE>

FLAGS:
    -h, --help                  Prints help information
        --no-duplicates         Do not consider duplicate alignments
        --primary-alignments    Use primary alignments only
        --umi                   Consider UMI information when populating coverage matrices?
    -V, --version               Prints version information

OPTIONS:
    -b, --bam <FILE>                         Cellranger BAM file
        --bam-tag <bam_tag>                  BAM tag to consider for marking cells? [default: CB]
    -c, --cell-barcodes <FILE>               File with cell barcodes to be evaluated
    -f, --fasta <FILE>                       Genome fasta file
        --log-level <log_level>              Logging level [default: error]  [possible values: info, debug, error]
        --mapq <INTEGER>                     Minimum read mapping quality to consider [default: 0]
        --out-barcodes <OUTPUT_FILE>         Output cell barcode file. Barcode labels of output matrices. Will have
                                             duplicate barcodes removed compared to input barcodes file.
    -o, --out-matrix <OUTPUT_FILE>           Output Matrix Market file (.mtx) [default: out_matrix.mtx]
        --out-variants <OUTPUT_FILE>         Output variant file. Reports ordered list of variants to help with loading
                                             into downstream tools
    -p, --padding <INTEGER>                  Number of padding to use on both sides of the variant. Should be at least
                                             1/2 of read length [default: 100]
        --ref-matrix <OUTPUT_FILE>           Location to write reference Matrix Market file. Only used if --scoring-
                                             method is coverage [default: ref_matrix.mtx]
    -s, --scoring-method <scoring_method>    Type of matrix to produce. In 'consensus' mode, cells with both ref and alt
                                             reads are given a 3, alt only reads a 2, and ref only reads a 1. Suitable
                                             for clustering.  In 'coverage' mode, it is required that you set --ref-
                                             matrix to store the second matrix in. The 'alt_frac' mode will report
                                             the fraction of alt reads, which is effectively the ratio of the alternate
                                             matrix to the sum of the alternate and coverage matrices. [default:
                                             consensus]  [possible values: consensus, coverage, alt_frac]
        --threads <INTEGER>                  Number of parallel threads to use [default: 1]
        --valid-chars <valid_chars>          Valid characters in an alternative haplotype. This prevents non sequence-
                                             resolved variants from being genotyped. [default: ATGCatgc]
    -v, --vcf <FILE>                         Called variant file (VCF)
```

