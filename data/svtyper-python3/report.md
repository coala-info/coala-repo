# svtyper-python3 CWL Generation Report

## svtyper-python3_svtyper

### Tool Description
Compute genotype of structural variants based on breakpoint depth

### Metadata
- **Docker Image**: quay.io/biocontainers/svtyper-python3:0.7.1--pyhdfd78af_0
- **Homepage**: https://github.com/hall-lab/svtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/svtyper-python3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svtyper-python3/overview
- **Total Downloads**: 58
- **Last updated**: 2025-10-15
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

options:
  -h, --help            show this help message and exit
  -i, --input_vcf FILE  VCF input (default: stdin)
  -o, --output_vcf FILE
                        output VCF to write (default: stdout)
  -B, --bam FILE        BAM or CRAM file(s), comma-separated if genotyping multiple samples
  -T, --ref_fasta FILE  Indexed reference FASTA file (recommended for reading CRAM files)
  -l, --lib_info FILE   create/read JSON file of library information
  -m, --min_aligned INT
                        minimum number of aligned bases to consider read as evidence [20]
  -n INT                number of reads to sample from BAM file for building insert size distribution [1000000]
  -q, --sum_quals       add genotyping quality to existing QUAL (default: overwrite QUAL field)
  --max_reads INT       maximum number of reads to assess at any variant (reduces processing time in high-depth regions, default: unlimited)
  --max_ci_dist INT     maximum size of a confidence interval before 95% CI is used intead (default: 1e10)
  --split_weight FLOAT  weight for split reads [1]
  --disc_weight FLOAT   weight for discordant paired-end reads [1]
  -w, --write_alignment FILE
                        write relevant reads to BAM file
  --verbose             Report status updates
```


## svtyper-python3_svtyper-sso

### Tool Description
Compute genotype of structural variants based on breakpoint depth on a SINGLE sample

### Metadata
- **Docker Image**: quay.io/biocontainers/svtyper-python3:0.7.1--pyhdfd78af_0
- **Homepage**: https://github.com/hall-lab/svtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/svtyper-python3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtyper-sso [-h] [-i FILE] [-o FILE] -B FILE [-T FILE] [-l FILE]
                   [-m INT] [-n INT] [-q] [--max_reads INT]
                   [--max_ci_dist INT] [--split_weight FLOAT]
                   [--disc_weight FLOAT] [--cores INT] [--batch_size INT]

svtyper
author: Indraniel Das (idas@wustl.edu)
version: v0.7.1
description: Compute genotype of structural variants based on breakpoint depth on a SINGLE sample

options:
  -h, --help            show this help message and exit
  -i, --input_vcf FILE  VCF input (default: stdin)
  -o, --output_vcf FILE
                        output VCF to write (default: stdout)
  -B, --bam FILE        BAM or CRAM file(s), comma-separated if genotyping multiple samples
  -T, --ref_fasta FILE  Indexed reference FASTA file (recommended for reading CRAM files)
  -l, --lib_info FILE   create/read JSON file of library information
  -m, --min_aligned INT
                        minimum number of aligned bases to consider read as evidence [20]
  -n INT                number of reads to sample from BAM file for building insert size distribution [1000000]
  -q, --sum_quals       add genotyping quality to existing QUAL (default: overwrite QUAL field)
  --max_reads INT       maximum number of reads to assess at any variant (reduces processing time in high-depth regions, default: 1000)
  --max_ci_dist INT     maximum size of a confidence interval before 95% CI is used intead (default: 1e10)
  --split_weight FLOAT  weight for split reads [1]
  --disc_weight FLOAT   weight for discordant paired-end reads [1]
  --cores INT           number of workers to use for parallel processing
  --batch_size INT      number of breakpoints to batch for a parallel processing worker job
```


## Metadata
- **Skill**: generated
