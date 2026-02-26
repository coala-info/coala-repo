# hificnv CWL Generation Report

## hificnv

### Tool Description
Copy number variant caller and depth visualization utility for PacBio HiFi reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hificnv:1.0.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/HiFiCNV
- **Package**: https://anaconda.org/channels/bioconda/packages/hificnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hificnv/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/HiFiCNV
- **Stars**: N/A
### Original Help Text
```text
hificnv 1.0.1-4de7d40
Chris Saunders <csaunders@pacificbiosciences.com>, J. Matthew Holt <mholt@pacificbiosciences.com>
Copy number variant caller and depth visualization utility for PacBio HiFi reads

Usage: hificnv [OPTIONS] --ref <FILE> --bam <FILE>

Options:
      --ref <FILE>              Genome reference in FASTA format
      --bam <FILE>              Alignment file for the query sample in BAM format. BAM file must be indexed
      --maf <FILE>              Variant file used to generate minor allele frequency track, in VCF or BCF format
      --exclude <FILE>          Regions of the genome to exclude from CNV analysis, in BED format
      --expected-cn <FILE>      Expected copy number values, in BED format
      --output-prefix <PREFIX>  Prefix used for all file output. If the prefix includes a directory, the directory must already exist [default: hificnv]
      --threads <THREAD_COUNT>  Number of threads to use. Defaults to all logical cpus detected
      --disable-vcf-filters     Disables all FILTER flags in HiFiCNV output
      --cov-regex <REGEX>       Regex used to select chromosomes for mean haploid coverage estimation. All selected chromosomes are assumed diploid [default: ^(chr)?\d{1,2}$]
      --debug-gc-correction     Output files for debugging GC-correction
  -h, --help                    Print help
  -V, --version                 Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
