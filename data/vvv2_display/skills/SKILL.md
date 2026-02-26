---
name: vvv2_display
description: The `vvv2_display` tool creates a PNG image visualizing genomic variants relative to genes and features by integrating VarDict and VADR data. Use when user asks to visualize genomic variants, display variant locations relative to genes and features, or generate a variant visualization image.
homepage: https://github.com/ANSES_Ploufragan/vvv2_display/
---


# vvv2_display

## Overview
The `vvv2_display` tool is a specialized visualization utility designed for genomic surveillance and variant analysis. It integrates data from two specific sources—VarDict (for variant calling and allele frequencies) and VADR (for structural annotations)—to produce a comprehensive PNG image. This visualization allows researchers to see exactly where variants occur relative to genes and other features, making it easier to identify hotspots or functional impacts in a single view.

## Usage Guidelines

### Core Command Pattern
The tool typically requires the output files from VarDict and VADR to generate the visualization.
```bash
vvv2_display --vardict <variants.vcf> --vadr <annotations.gff> --output <result.png>
```

### Key Inputs
- **VarDict Data**: Ensure your input contains the frequency/proportion data for variants. The tool specifically looks for the proportions to scale the visual representation.
- **VADR Annotations**: Use the GFF or feature table outputs from VADR to provide the genomic context (CDS, mature peptides, etc.).

### Best Practices
- **Resolution**: The output is a PNG file. If the genome is particularly large, ensure the annotation density is manageable to maintain readability in the final image.
- **File Naming**: Use descriptive names for the output PNG to distinguish between different samples or runs, as the tool is often used in comparative genomics pipelines.
- **Environment**: Since this is a Bioconda package, ensure the environment is activated (`conda activate vvv2_display_env`) before execution to resolve dependencies like R or Python libraries used for the rendering.

## Reference documentation
- [vvv2_display Overview](./references/anaconda_org_channels_bioconda_packages_vvv2_display_overview.md)