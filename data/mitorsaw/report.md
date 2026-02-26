# mitorsaw CWL Generation Report

## mitorsaw_build

### Tool Description
Download and build the mitochondria database

### Metadata
- **Docker Image**: quay.io/biocontainers/mitorsaw:0.2.7--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/mitorsaw
- **Package**: https://anaconda.org/channels/bioconda/packages/mitorsaw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mitorsaw/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-12-02
- **GitHub**: https://github.com/PacificBiosciences/mitorsaw
- **Stars**: N/A
### Original Help Text
```text
Download and build the mitochondria database

Usage: mitorsaw build [OPTIONS] --reference <FASTA> --output-db <JSON>

Options:
  -v, --verbose...  Enable verbose output
  -h, --help        Print help
  -V, --version     Print version

Input/Output:
  -r, --reference <FASTA>  Reference FASTA file
  -o, --output-db <JSON>   Output database location (JSON)

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## mitorsaw_haplotype

### Tool Description
Run the haplotyper on a dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/mitorsaw:0.2.7--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/mitorsaw
- **Package**: https://anaconda.org/channels/bioconda/packages/mitorsaw/overview
- **Validation**: PASS

### Original Help Text
```text
Run the haplotyper on a dataset

Usage: mitorsaw haplotype [OPTIONS] --reference <FASTA> --bam <BAM> --output-vcf <VCF>

Options:
  -v, --verbose...  Enable verbose output
  -h, --help        Print help
  -V, --version     Print version

Input/Output:
  -r, --reference <FASTA>        Reference FASTA file
  -b, --bam <BAM>                Input alignment file in BAM format, can be specified multiple times
  -d, --database <JSON>          Input database file (Optional, JSON)
  -o, --output-vcf <VCF>         Output variant call file (VCF)
      --output-hap-stats <JSON>  Optional haplotype stats
      --output-debug <DIR>       Optional output debug folder
      --sample-name <STRING>     Sample name to use in VCF output (default: BAM RG tag or "SAMPLE")

Heuristics:
      --minimum-read-count <INT>  Minimum read count to consider a heteroplasmic variant [default: 3]
      --minimum-maf <FLOAT>       Minimum allele frequency to consider a heteroplasmic variant [default: 0.10]
      --minimum-map-frac <FLOAT>  Minimum fraction of read that must map to pass filters [default: 0.90]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated

## mitorsaw

### Tool Description
a tool for haplotyping mitochondria from HiFi data. Select a subcommand to see more usage information:

### Metadata
- **Docker Image**: quay.io/biocontainers/mitorsaw:0.2.7--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/mitorsaw
- **Package**: https://anaconda.org/channels/bioconda/packages/mitorsaw/overview
- **Validation**: PASS
### Original Help Text
```text
Mitorsaw, a tool for haplotyping mitochondria from HiFi data. Select a subcommand to see more usage information:

Usage: mitorsaw <COMMAND>

Commands:
  build      Download and build the mitochondria database
  haplotype  Run the haplotyper on a dataset
  help       Print this message or the help of the given subcommand(s)

Options:
  -h, --help     Print help
  -V, --version  Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

