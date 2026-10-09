# ibdmix CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ibdmix | PASS |  |
| ibdmix_generate_gt | PASS |  |
| ibdmix_gt_lods | PASS |  |

## ibdmix

### Tool Description
ibdmix is a tool for admixture analysis of diploid populations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
- **Homepage**: https://github.com/PrincetonUniversity/IBDmix
- **Package**: https://anaconda.org/channels/bioconda/packages/ibdmix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ibdmix/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PrincetonUniversity/IBDmix
- **Stars**: N/A
### Original Help Text
```text
Find probable IBD regions
Usage: ibdmix [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -g,--genotype TEXT:FILE REQUIRED
                              The genotype file
  -o,--output TEXT            The output file location
  -s,--sample TEXT:FILE       File containing samples to select from genotype.  Default to all samples in genotype.
  -n,--archaic TEXT           Name of archaic sample, default to first sample in genotype file
  -r,--mask TEXT:FILE         Mask of regions to 'remove'. Regions in bed file have LOD set to 0
  -d,--LOD-threshold FLOAT    Threshold for emitting regions
  -m,--minor-allele-count-threshold INT
                              Threshold count for filtering minor alleles
  -a,--archaic-error FLOAT    Allele error rate for archaic DNA
  -e,--modern-error-max FLOAT Maximum allele error rate for modern samples
  -c,--modern-error-proportion FLOAT
                              Ratio between allele error rate and minor allele frequency
  -t,--more-stats             Flag to report additional region-level statistics
  -i,--inclusive-end          Change regions to be closed over [start, end]
  -w,--write-snps             Also include positions with positive LOD as a CSV list
  --write-lods                Also include LOD scores of positive LOD as a CSV list. Same order as SNPs.
```

## ibdmix_generate_gt

### Tool Description
Produce genotype files from vcfs

### Metadata
- **Docker Image**: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
- **Homepage**: https://github.com/PrincetonUniversity/IBDmix
- **Package**: https://anaconda.org/channels/bioconda/packages/ibdmix/overview
- **Validation**: PASS

### Original Help Text
```text
Produce genotype files from vcfs
Usage: generate_gt [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -a,--archaic TEXT:FILE REQUIRED
                              The archaic sample vcf
  -m,--modern TEXT:FILE REQUIRED
                              The modern sample vcf
  -o,--output TEXT            The output file location
```

## ibdmix_gt_lods

### Tool Description
Calculate population specific LOD scores for all sites

### Metadata
- **Docker Image**: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
- **Homepage**: https://github.com/PrincetonUniversity/IBDmix
- **Package**: https://anaconda.org/channels/bioconda/packages/ibdmix/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate population specific LOD scores for all sites
Usage: gt_lods [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -g,--genotype TEXT:FILE REQUIRED
                              The genotype file
  -o,--output TEXT            The output file location
  -s,--sample TEXT:FILE       File containing samples to select from genotype.  Default to all samples in genotype.
  -n,--archaic TEXT           Name of archaic sample, default to first sample in genotype file
  -r,--mask TEXT:FILE         Mask of regions to 'remove'. Regions in bed file have LOD set to 0
  -m,--minor-allele-count-threshold INT
                              Threshold count for filtering minor alleles
  -a,--archaic-error FLOAT    Allele error rate for archaic DNA
  -e,--modern-error-max FLOAT Maximum allele error rate for modern samples
  -c,--modern-error-proportion FLOAT
                              Ratio between allele error rate and minor allele frequency
  --include-ninfs             Include sites with -ninf as LOD scores.  Will translate to -100 as the LOD score
  --include-zeros             Include sites where all LODs are 0. Commonly occurs for sites in masked regions.
```
