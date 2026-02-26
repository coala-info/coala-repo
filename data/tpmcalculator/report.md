# tpmcalculator CWL Generation Report

## tpmcalculator_TPMCalculator

### Tool Description
TPMCalculator calculates TPM values for genes and transcripts from BAM files and a GTF annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/tpmcalculator:0.0.6--h2bd4fab_0
- **Homepage**: https://github.com/ncbi/TPMCalculator
- **Package**: https://anaconda.org/channels/bioconda/packages/tpmcalculator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tpmcalculator/overview
- **Total Downloads**: 13.7K
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/ncbi/TPMCalculator
- **Stars**: N/A
### Original Help Text
```text
Unsupported option: --help

********************************************************************************

Usage: TPMCalculator

TPMCalculator options:

-v    Print info
-version    Print version
-h    Display this usage information.
-g    GTF file
-d    Directory with the BAM files
-b    BAM file
-k    Gene key to use from GTF file. Default: gene_id
-t    Transcript key to use from GTF file. Default: transcript_id
-c    Smaller size allowed for an intron created for genes. Default: 16. We recommend to use the reads length
-p    Use only properly paired reads. Default: No. Recommended for paired-end reads.
-q    Minimum MAPQ value to filter out reads. Default: 0. This value depends on the aligner MAPQ value.
-o    Minimum overlap between a reads and a feature. Default: 8.
-e    Extended output. This will include transcript level TPM values. Default: No.
-a    Print out all features with read counts equal to zero. Default: No.

********************************************************************************

                        Roberto Vera Alvarez, PhD
                      Emails: veraalva@ncbi.nlm.nih.gov

********************************************************************************
```

