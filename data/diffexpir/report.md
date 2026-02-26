# diffexpir CWL Generation Report

## diffexpir_diffexpIR

### Tool Description
Performs differential expression analysis.

### Metadata
- **Docker Image**: biocontainers/diffexpir:v0.0.1_cv5
- **Homepage**: https://github.com/r78v10a07/DiffExpIR
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/diffexpir/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/r78v10a07/DiffExpIR
- **Stars**: N/A
### Original Help Text
```text
Unsupported option: --help

********************************************************************************

Usage: diffexpIR

diffexpIR options:

-h    Display this usage information.
-g    GTF file
-o    Output file name
-d    Directory with the TPM output files
-k    Gene key to use from GTF file. Default: gene_id
-t    Transcript key to use from GTF file. Default: transcript_id
-c    Smaller size allowed for an intron created for genes. Default: 16. We recommend to use the reads length
-p    Prefix for grouping samples. (sample_1,sample_2)
-s    Stat method: ttest (default), wilcox
-f    Minimum fold change to filter out (default value: 2.0)
-v    Minimum P-Value to filter out (default value: 1.0E-6)
-r    Minimum fold change between intron and neighboring exons (default value: -1.0)
-fdr    FRD Correction on the P-Values

********************************************************************************

                        Roberto Vera Alvarez, PhD
            Emails: veraalva@ncbi.nlm.nih.gov, r78v10a07@gmail.com

********************************************************************************
```

