---
name: naibr-plus
description: naibr-plus (Novel Adjacency Identification with Barcoded Reads) is a specialized tool designed to detect structural variants by leveraging the spatial information provided by barcoded linked-reads.
homepage: https://github.com/pontushojer/NAIBR
---

# naibr-plus

## Overview
naibr-plus (Novel Adjacency Identification with Barcoded Reads) is a specialized tool designed to detect structural variants by leveraging the spatial information provided by barcoded linked-reads. It identifies "novel adjacencies" that differ from the reference genome, providing a statistical likelihood score for each event. It is particularly effective for analyzing 10X Genomics data processed through the Long Ranger pipeline, allowing for high-precision SV calling and haplotyping.

## Installation
The tool is available via Bioconda:
`conda install bioconda::naibr-plus`

## Configuration and Execution
naibr-plus is executed by passing a configuration file to the main command:
`naibr <configfile>`

### Configuration Parameters
The configuration file should be a plain text file using a `parameter : value` format. Key parameters include:

- **bam_file**: Path to the input BAM. Reads must have barcode tags (`BX`). For haplotyped SVs, reads should be phased with `HP` tags.
- **min_mapq**: Minimum mapping quality (default: 40). High values reduce false positives.
- **outdir**: Output directory path.
- **prefix**: String prefix for output files (default: `NAIBR_SVs`).
- **d**: Maximum distance in basepairs between reads within a single linked-read molecule (default: 10000).
- **k**: Minimum number of barcode overlaps required to support a candidate SV (default: 3).
- **min_sv**: Minimum size of SV to detect (default is the 95th percentile of the insert size distribution).
- **threads**: Number of threads for parallel processing.
- **blacklist**: (Optional) BED file containing regions to exclude from analysis.

## Output Interpretation
The tool produces three main output files:

1. **<prefix>.bedpe**: A custom format containing breakpoint coordinates, split molecule counts, discordant read counts, and the log-likelihood score.
2. **<prefix>.reformat.bedpe**: A standard 10X Genomics BEDPE format optimized for visualization in IGV.
3. **<prefix>.vcf**: The results translated into VCF format for compatibility with benchmarking tools like Truvari.

### Orientation Codes
The "Orientation" column in the output indicates the type of structural variant:
- **+-**: Suggests a Deletion (DEL).
- **++** or **--**: Suggests an Inversion (INV).
- **-+**: Suggests a Duplication (DUP).

## Expert Tips
- **Filtering**: Focus on entries marked as "PASS" in the final column. These have met the internal likelihood threshold.
- **VCF Conversion**: If you have an existing NAIBR BEDPE file and need to regenerate the VCF, use the utility script: `bedpe_to_vcf.py`.
- **Performance**: For deep coverage WGS data, ensure `threads` is set appropriately to manage the computational load of barcode overlap analysis.
- **Candidate Scoring**: If you have a list of known SVs you wish to score specifically, use the `candidates` parameter in the config file to point to a BEDPE file of those regions.

## Reference documentation
- [Bioconda naibr-plus Overview](./references/anaconda_org_channels_bioconda_packages_naibr-plus_overview.md)
- [NAIBR GitHub Repository](./references/github_com_pontushojer_NAIBR.md)