---
name: plant_tribes_assembly_post_processor
description: The `AssemblyPostProcessor` is a specialized pipeline within the PlantTribes toolkit designed for comparative plant genomics.
homepage: https://github.com/dePamphilis/PlantTribes
---

# plant_tribes_assembly_post_processor

## Overview

The `AssemblyPostProcessor` is a specialized pipeline within the PlantTribes toolkit designed for comparative plant genomics. It transforms raw de novo assembly transcripts into high-quality protein and nucleotide sequences by identifying open reading frames (ORFs) and predicting coding regions. By utilizing external prediction engines like ESTScan or TransDecoder, it ensures that the resulting sequences are biologically relevant and formatted correctly for evolutionary studies, such as estimating substitution rates or building gene family phylogenies.

## Usage Patterns

### Basic Execution with ESTScan
The most common workflow uses ESTScan for coding sequence prediction. You must provide a species-specific score matrix.

```bash
AssemblyPostProcesser --transcripts transcripts.fasta --prediction_method estscan --score_matrices /path/to/matrices/Arabidopsis_thaliana.smat
```

### Core Arguments
- `--transcripts`: Path to the input FASTA file containing de novo assembled transcripts.
- `--prediction_method`: Method for ORF prediction (typically `estscan` or `transdecoder`).
- `--score_matrices`: Required when using `estscan`; points to the species-specific scoring model.
- `--min_coverage`: A float value between 0.0 and 1.0 used to filter assemblies based on coverage depth.

## Expert Tips and Best Practices

- **Matrix Selection**: When using ESTScan, select a score matrix from a species phylogenetically close to your target organism (e.g., use `Arabidopsis_thaliana.smat` for Brassicaceae) to improve prediction accuracy.
- **Dependency Management**: Ensure that `ESTScan` (v2.1), `TransDecoder` (v5.5.0), and `HMMER` (v3.1b1) are available in your `$PATH`. The pipeline relies on these external tools for its core logic.
- **Filtering Stringency**: Use the `--min_coverage` parameter to reduce noise in your dataset. A higher value (e.g., 0.8) will result in a more conservative set of predicted proteins, which is often preferable for high-confidence phylogenomic trees.
- **Output Handling**: The tool generates both amino acid (.faa) and nucleotide (.fna) files. Always verify the consistency between these files before proceeding to the `GeneFamilyClassifier` step.
- **Debugging**: If the pipeline fails without a clear error, check the external tool versions. Specifically, `AssemblyPostProcessor` is optimized for TransDecoder v5.5.0; newer versions may have different output formats that require manual parsing adjustments.

## Reference documentation
- [PlantTribes Overview and Usage](./references/github_com_dePamphilis_PlantTribes.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_plant_tribes_assembly_post_processor_overview.md)