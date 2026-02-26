---
name: footprint
description: The footprint tool analyzes chromatin accessibility data using a mixture model to identify transcription factor binding sites. Use when user asks to find footprints, quantify binding evidence with log-odds scores, or visualize signal profiles of transcription factors.
homepage: https://ohlerlab.mdc-berlin.de/software/Reproducible_footprinting_139/
---


# footprint

## Overview
The `footprint` skill provides a specialized workflow for analyzing chromatin accessibility data to pinpoint where transcription factors are bound. By integrating sequence bias, motif coordinates, and experimental signal (BAM), it uses a mixture model to distinguish true footprints from background noise. This skill is essential when you need to quantify binding evidence (log-odds scores) or visualize the learned signal profiles of specific transcription factors.

## Command Line Usage
The primary executable is `find_footprints.sh`. The command requires 11 positional arguments in a specific order.

### Basic Syntax
```bash
bash find_footprints.sh <bam_file> <chrom_sizes> <motif_coords> <genome_fasta> <factor_name> <bias_file> <peak_file> <no_of_components> <background> <fixed_bg>
```

### Argument Specifications
| Argument | Description | Requirements |
| :--- | :--- | :--- |
| `bam_file` | ATAC/DNase-seq alignment | Must be the only file in its directory. |
| `chrom_sizes` | Chromosome lengths | Tab-delimited: `chr\tlength`. |
| `motif_coords` | Candidate binding sites | 6-column BED (1-based coordinates). |
| `genome_fasta` | Reference sequence | Must be indexed (`.fai`) in the same directory. |
| `factor_name` | TF name | Used for output file naming. |
| `bias_file` | Hexamer bias file | Options: `ATAC`, `DNase_double_hit`, `DNase_single_hit`. |
| `peak_file` | ChIP-seq peaks | 3-column BED (Chr, Start, End). |
| `no_of_components` | Model complexity | `2` (1 fp, 1 bg) or `3` (2 fp, 1 bg). |
| `background` | Initialization mode | `Flat` (uniform) or `Seq` (bias-based). |
| `fixed_bg` | Background training | `TRUE` (fixed) or `FALSE` (re-estimated). |

## Expert Tips & Best Practices
- **Directory Isolation**: The pipeline generates temporary files in the directories containing the `bam_file` and `motif_coords`. To prevent data loss or overwriting, ensure these files are isolated in their own folders before running.
- **Background Selection**: If using `Seq` for the `background` argument (initializing from protocol bias), it is highly recommended to set `fixed_bg` to `TRUE`.
- **Coordinate System**: Ensure `motif_coords` are 1-based (closed) coordinates, as the pipeline expects this format rather than standard 0-based BED.
- **Interpreting Results**:
    - **.RESULTS**: Focus on the 7th column for the log-odds footprint score. Higher scores indicate stronger evidence of binding.
    - **.PARAM**: Use this to inspect the learned signal distribution across the footprint.
    - **plot2.png**: For 3-component models, this provides the weighted average of the two footprint components, representing the final profile.

## Reference documentation
- [Reproducible footprinting Pipeline Details](./references/ohlerlab_mdc-berlin_de_software_Reproducible_footprinting_139.md)
- [Bioconda footprint Package Overview](./references/anaconda_org_channels_bioconda_packages_footprint_overview.md)