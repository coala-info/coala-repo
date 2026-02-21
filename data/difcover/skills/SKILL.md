---
name: difcover
description: The difcover pipeline provides a specialized workflow for detecting differential genomic coverage between two samples aligned to the same reference.
homepage: https://github.com/timnat/DifCover
---

# difcover

## Overview

The difcover pipeline provides a specialized workflow for detecting differential genomic coverage between two samples aligned to the same reference. Unlike standard tools that use fixed-size windows, difcover employs a "stretched window" technique. This method sequentially scans scaffolds to form windows containing a predefined number of "valid" bases—bases that fall within user-defined minimum and maximum coverage thresholds. This approach effectively bridges gaps and repetitive regions, allowing for more precise copy number variation (CNV) and genomic difference analysis in complex genomes.

## Installation and Setup

The tool is available via Bioconda. Ensure all dependencies (BEDTOOLS, SAMTOOLS, AWK, and the R package DNAcopy) are in your PATH.

```bash
conda install bioconda::difcover
```

If running from source, you must compile the core C++ component:
```bash
cd DifCover/dif_cover_scripts/
make # Compiles from_unionbed_to_ratio_per_window_CC0
chmod +x *sh
```

## Core Workflow

The pipeline can be executed in bulk using `run_difcover.sh` or step-by-step for fine-tuned parameter control.

### Bulk Execution
1. Copy `run_difcover.sh` to your working directory.
2. Edit the script to define paths to your BAM files and set filtering parameters.
3. Execute: `./run_difcover.sh`

### Stage-by-Stage Execution
For complex projects, running stages manually allows for intermediate data inspection:

1. **Generate UnionBed**: Combine BAM coverage data.
   `from_bams_to_unionbed.sh sample1.bam sample2.bam`
2. **Calculate Ratios**: Apply stretched windows and calculate coverage ratios.
   `from_unionbed_to_ratio_per_window_CC0 <unionbed_file> <a> <A> <b> <B> <v> <l>`
3. **DNAcopy Processing**: Generate circular binary segmentation output.
   `from_ratio_per_window__to__DNAcopy_output.sh <ratio_file> <AC>`
4. **Extract Fragments**: Identify regions exceeding the enrichment threshold.
   `from_DNAcopyout_to_p_fragments.sh <dnacopy_file> <P>`

## Key Parameters and Best Practices

| Parameter | Description | Recommendation |
| :--- | :--- | :--- |
| `a` / `b` | Min coverage for Sample 1 / 2 | Set to exclude under-represented/low-quality regions. |
| `A` / `B` | Max coverage for Sample 1 / 2 | Set to exclude repetitive sequences/multi-copy regions. |
| `v` | Target valid bases per window | Typically 1000; higher values increase smoothing. |
| `l` | Min window size | Minimum physical length of the window to be reported. |
| `AC` | Adjustment Coefficient | Set to 1.0 if modal coverage is equal; otherwise, use to normalize samples. |
| `P` | Enrichment threshold | Log2-based; P=2 identifies ~4x coverage differences. |

### Expert Tips
- **Input Preparation**: BAM files must be coordinate-sorted.
- **Handling Zeros**: If Sample 2 has zero coverage in a window, the tool uses a small constant (CC0) to avoid division by zero errors.
- **Fragmented Assemblies**: DifCover is specifically optimized for scaffolds; it handles large numbers of small contigs more gracefully than tools designed for chromosome-level assemblies.
- **Normalization**: Always check the modal coverage of your samples. If one sample has significantly higher global depth, calculate the `AC` (Adjustment Coefficient) to prevent false positives.

## Reference documentation
- [DifCover GitHub README](./references/github_com_timnat_DifCover.md)
- [DifCover Wiki - Usage and Stages](./references/github_com_timnat_DifCover_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_difcover_overview.md)