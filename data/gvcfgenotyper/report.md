# gvcfgenotyper CWL Generation Report

## gvcfgenotyper

### Tool Description
GVCF merging and genotyping for Illumina GVCFs

### Metadata
- **Docker Image**: quay.io/biocontainers/gvcfgenotyper:2019.02.26--h13024bc_6
- **Homepage**: https://github.com/Illumina/gvcfgenotyper
- **Package**: https://anaconda.org/channels/bioconda/packages/gvcfgenotyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gvcfgenotyper/overview
- **Total Downloads**: 16.2K
- **Last updated**: 2025-10-07
- **GitHub**: https://github.com/Illumina/gvcfgenotyper
- **Stars**: N/A
### Original Help Text
```text
About:   GVCF merging and genotyping for Illumina GVCFs
Version: 2019.02.26
Usage:   gvcfgenotyper -f ref.fa -l gvcf_list.txt

Options:
    -l, --list          <file>          plain text list of gvcfs to merge
    -f, --fasta-ref     <file>          reference sequence
    -o, --output-file   <file>          output file name [stdout]
    -L, --log-file      <file>          logging information
    -O, --output-type   <b|u|z|v>       b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed VCF [v]
    -r, --region        <region>        region to genotype eg. chr1 or chr20:5000000-6000000
    -M, --max-alleles   INT             maximum number of alleles [50]

ERROR: --list is required
Exiting...
```

