# svtyper CWL Generation Report

## svtyper

### Tool Description
Compute genotype of structural variants based on breakpoint depth

### Metadata
- **Docker Image**: quay.io/biocontainers/svtyper:0.7.1--py_0
- **Homepage**: https://github.com/hall-lab/svtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/svtyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svtyper/overview
- **Total Downloads**: 56.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hall-lab/svtyper
- **Stars**: N/A
### Original Help Text
```text
usage: svtyper [-h] [-i FILE] [-o FILE] -B FILE [-T FILE] [-l FILE] [-m INT]
               [-n INT] [-q] [--max_reads INT] [--max_ci_dist INT]
               [--split_weight FLOAT] [--disc_weight FLOAT] [-w FILE]
               [--verbose]

svtyper
author: Colby Chiang (colbychiang@wustl.edu)
version: v0.7.1
description: Compute genotype of structural variants based on breakpoint depth

optional arguments:
  -h, --help            show this help message and exit
  -i FILE, --input_vcf FILE
                        VCF input (default: stdin)
  -o FILE, --output_vcf FILE
                        output VCF to write (default: stdout)
  -B FILE, --bam FILE   BAM or CRAM file(s), comma-separated if genotyping multiple samples
  -T FILE, --ref_fasta FILE
                        Indexed reference FASTA file (recommended for reading CRAM files)
  -l FILE, --lib_info FILE
                        create/read JSON file of library information
  -m INT, --min_aligned INT
                        minimum number of aligned bases to consider read as evidence [20]
  -n INT                number of reads to sample from BAM file for building insert size distribution [1000000]
  -q, --sum_quals       add genotyping quality to existing QUAL (default: overwrite QUAL field)
  --max_reads INT       maximum number of reads to assess at any variant (reduces processing time in high-depth regions, default: unlimited)
  --max_ci_dist INT     maximum size of a confidence interval before 95% CI is used intead (default: 1e10)
  --split_weight FLOAT  weight for split reads [1]
  --disc_weight FLOAT   weight for discordant paired-end reads [1]
  -w FILE, --write_alignment FILE
                        write relevant reads to BAM file
  --verbose             Report status updates
```

