# mwga-utils CWL Generation Report

## mwga-utils_metrics

### Tool Description
Generate wig files with base metrics from a MAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
- **Homepage**: https://github.com/RomainFeron/mgwa_utils
- **Package**: https://anaconda.org/channels/bioconda/packages/mwga-utils/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mwga-utils/overview
- **Total Downloads**: 19.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RomainFeron/mgwa_utils
- **Stars**: N/A
### Original Help Text
```text
Generate wig files with base metrics from a MAF file.

    Usage:
      metrics <maf_file> [-p <prefix> -t <threads> -n <assemblies>]

    Options:
      <maf_file>       Path to a MAF file.
      -p <prefix>      Prefix for output wig files [default: no prefix]
      -n <assemblies>  Manually specify the number of assemblies in the alignment; if not, it is computed from the MAF [default: 0]
      -t <threads>     Number of threads to use [default: 1].
      -h --help        Show this screen.
```


## mwga-utils_missing_regions

### Tool Description
Add regions from the reference genome that are missing from a MAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
- **Homepage**: https://github.com/RomainFeron/mgwa_utils
- **Package**: https://anaconda.org/channels/bioconda/packages/mwga-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Add regions from the reference genome that are missing from a MAF file.

    Usage:
      missing_regions <maf_file> <reference>

    Options:
      <maf_file>       Path to a MAF file.
      <reference>      Path to a FASTA file for the reference assembly.
      -h --help        Show this screen.
```


## mwga-utils_stats

### Tool Description
Compute a series of statistics on a MAF file:
        - Number of BP aligned in each assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
- **Homepage**: https://github.com/RomainFeron/mgwa_utils
- **Package**: https://anaconda.org/channels/bioconda/packages/mwga-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Compute a series of statistics on a MAF file:
        - Number of BP aligned in each assembly

    Usage:
      stats <maf_file> [-p <prefix>]

    Options:
      <maf_file>       Path to a MAF file.
      -p <prefix>      Prefix for output stats files [default: stats]
      -h --help        Show this screen.
```

