---
name: hap-ibd
description: "hap-ibd identifies identity-by-descent (IBD) and homozygosity-by-descent (HBD) segments in phased genomic data. Use when user asks to detect shared genomic segments between individuals, analyze recent ancestry, or identify runs of homozygosity."
homepage: https://github.com/browning-lab/hap-ibd
---


# hap-ibd

## Overview

The `hap-ibd` tool identifies genomic segments shared between individuals (IBD) or within a single individual (HBD) due to common ancestry. It is designed to process phased VCF files and requires a genetic map to estimate centimorgan (cM) distances. Use this skill when you need to analyze recent ancestry, kinship, or autozygosity in datasets containing up to hundreds of thousands of samples.

## Installation

The tool can be installed via Bioconda or by downloading the executable JAR file:

```bash
# Via Conda
conda install bioconda::hap-ibd

# Via JAR download
wget https://faculty.washington.edu/browning/hap-ibd.jar
```

## Core Usage Pattern

The program requires Java 1.8 or later. The basic execution syntax uses `parameter=value` pairs:

```bash
java -Xmx[GB]g -jar hap-ibd.jar gt=[input.vcf.gz] map=[map_file.map] out=[output_prefix] [optional_parameters]
```

### Required Parameters
- `gt=[file]`: A phased VCF file. All genotypes must be phased with no missing alleles.
- `map=[file]`: A PLINK format genetic map (cM units). Chromosome identifiers must match the VCF.
- `out=[string]`: Prefix for the output files.

### Key Optional Parameters
- `min-seed=[2.0]`: Minimum cM length for an initial IBS segment to be considered for extension.
- `min-output=[2.0]`: Minimum cM length for reported IBD/HBD segments.
- `max-gap=[1000]`: Maximum base-pair gap allowed between IBS segments to merge them (accounts for errors/mutations). Set to `-1` to disable extension.
- `min-markers=[100]`: Minimum number of markers in a segment. Increase this for sparse data to reduce false positives.
- `nthreads=[CPU_cores]`: Number of computational threads.

## Expert Tips and Best Practices

- **Memory Allocation**: Always specify the `-Xmx` flag. For very large datasets (hundreds of thousands of samples), ensure the system has sufficient RAM to hold the phased genotypes in memory.
- **Data Preparation**: If your data is unphased or contains missing alleles, you must process it with a tool like Beagle before running `hap-ibd`.
- **Handling Multi-allelic Sites**: `hap-ibd` supports multi-allelic records, but it filters markers based on the Minor Allele Count (`min-mac`). The default `min-mac=2` excludes singletons.
- **Output Files**:
    - `.ibd.gz`: Contains IBD segments between different individuals.
    - `.hbd.gz`: Contains HBD segments (runs of homozygosity) within individuals.
    - `.log`: Contains summary statistics, including the mean number of segments per sample.
- **Interpolation**: The tool uses linear interpolation for genetic positions. Ensure your genetic map is high-density for the most accurate cM length estimates.

## Reference documentation
- [hap-ibd Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hap-ibd_overview.md)
- [hap-ibd GitHub Documentation](./references/github_com_browning-lab_hap-ibd.md)