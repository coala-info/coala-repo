---
name: naibr-plus
description: naibr-plus identifies structural variants in linked-read whole genome sequencing data by analyzing barcode overlaps and discordant read pairs. Use when user asks to identify structural variants in 10X Genomics data, convert BEDPE files to VCF format, or score specific genomic rearrangement candidates.
homepage: https://github.com/pontushojer/NAIBR
---


# naibr-plus

## Overview
The naibr-plus skill enables the identification of structural variants by leveraging the barcode information in linked-read WGS data. It is a refactored, more user-friendly version of the original NAIBR tool. It analyzes barcode overlaps and discordant read pairs to score and predict genomic rearrangements. Use this skill when you need to perform SV calling on 10X Genomics data, convert specialized BEDPE outputs to standard VCF files, or optimize SV detection parameters for linked-read datasets.

## Configuration and Execution
The tool primarily runs via a configuration file. You must define the paths and thresholds before execution.

### 1. Create a Configuration File
Create a text file (e.g., `naibr.config`) with the following key parameters:
- `bam_file`: Path to the input BAM (must have `BX` tags; `HP` tags required for haplotyping).
- `blacklist`: Path to a BED file of regions to exclude (e.g., high-coverage or repetitive regions).
- `outdir`: Directory for output files.
- `threads`: Number of CPU cores to utilize.
- `min_mapq`: Minimum mapping quality (default is 40).
- `k`: Minimum number of barcode overlaps required to support a candidate (default is 3).
- `d`: Maximum distance (bp) between reads to be considered part of the same linked-read (default is 10000).

### 2. Run the Analysis
Execute the tool by passing the config file:
```bash
naibr naibr.config
```

## Working with Outputs
The tool generates three primary files in the specified `outdir`:
- `<prefix>.bedpe`: The raw results containing breakpoint positions, split molecule counts, orientation, and log-likelihood scores.
- `<prefix>.reformat.bedpe`: A version compatible with IGV for visual inspection.
- `<prefix>.vcf`: Standard VCF format for downstream analysis with tools like truvari.

## Converting Formats
If you have an existing NAIBR BEDPE file and need to generate a VCF manually, use the included utility script:
```bash
bedpe_to_vcf.py --input NAIBR_SVs.bedpe --output NAIBR_SVs.vcf
```

## Expert Tips and Best Practices
- **Phasing Requirement**: While `naibr-plus` can run on unphased data, providing a phased BAM (with `HP` tags) is highly recommended to identify haplotyped SVs and improve accuracy.
- **Distance Parameter (`d`)**: If your library has particularly long or short molecules, adjust the `d` parameter. Setting this too high can lead to false barcode overlaps, while setting it too low may fragment single molecules.
- **Candidate Scoring**: If you have a specific set of SVs you wish to validate, use the `candidates` parameter in the config file to provide a BEDPE of specific regions. This bypasses automatic discovery and focuses the tool on scoring your provided regions.
- **Filtering**: Pay attention to the `Score` column in the output. Higher log-likelihood scores indicate higher confidence. The "PASS/FAIL" filter is a helpful baseline, but manual inspection of scores near the threshold is recommended for complex samples.



## Subcommands

| Command | Description |
|---------|-------------|
| bedpe_to_vcf.py | Convert NAIBR BEDPE files to VCF |
| naibr | NAIBR identifies novel adjacencies created by structural variation events such as deletions, duplications, inversions, and complex rearrangements using linked-read whole-genome sequencing data as produced by 10X Genomics. Please refer to the publication for details about the method. |

## Reference documentation
- [NAIBR - Novel Adjacency Identification with Barcoded Reads](./references/github_com_pontushojer_NAIBR_blob_main_README.md)
- [naibr-plus Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_naibr-plus_overview.md)