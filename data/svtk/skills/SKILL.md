---
name: svtk
description: The Structural Variant ToolKit (svtk) provides a suite of utilities for standardizing, clustering, and annotating structural variant calls from genomic data. Use when user asks to convert VCF files to BED format, cluster overlapping variants across samples, annotate variants with genomic features, or resolve complex structural events.
homepage: https://github.com/talkowski-lab/svtk
---


# svtk

## Overview
The Structural Variant ToolKit (svtk) is a suite of utilities designed to handle the complexities of structural variant discovery and refinement. It is particularly useful for bioinformaticians who need to standardize VCF outputs from different SV callers, cluster overlapping variants across samples, and annotate variants with genomic features. While the repository is archived in favor of the GATK-SV pipeline, svtk remains a core component for legacy workflows and specific SV manipulation tasks.

## Installation
Install via bioconda to ensure all dependencies (Python, pysam, etc.) are correctly managed:
```bash
conda install bioconda::svtk
```

## Common CLI Patterns

### Standardizing and Converting Formats
Convert VCF files to BED format for easier manipulation in genomic interval tools.
```bash
# Basic conversion
svtk vcf2bed input.vcf output.bed

# Handle complex insertions and report unresolved variants
svtk vcf2bed --split-sinks input.vcf output.bed
```

### Clustering Variants
Merge overlapping SV calls from multiple samples or callers to create a non-redundant site list.
```bash
# Cluster variants in a VCF
svtk vcfcluster input_list.txt output.vcf

# Cluster BED-formatted SVs with identical coordinates
svtk bedcluster input.bed output.bed
```

### Annotation
Annotate SVs with gene overlaps, functional impact (LOF), and specific chromosome naming conventions.
```bash
# Annotate a VCF with genomic features
svtk annotate input.vcf references/gencode.gtf output.vcf
```

### Quality Control and Statistics
Generate summaries of variant types across your dataset.
```bash
# Count SV types from a VCF (supports stdin)
cat input.vcf | svtk count-svtypes
```

### Resolving Complex Variants
Refine breakpoints and resolve complex event types (like inversions or translocations) that may be represented inconsistently by different callers.
```bash
svtk resolve raw_calls.vcf unresolved.vcf resolved.vcf
```

## Expert Tips
- **Coordinate Systems**: `svtk vcf2bed` converts VCF (1-based) to BED (0-based) coordinates. Always verify your coordinate system before downstream analysis.
- **Chromosome Naming**: The `annotate` command is flexible with chromosome prefixes; it accepts both "chr1" and "1" formats.
- **Complex Insertions**: When working with complex insertions (INS), use the latest version of `vcf2bed` to ensure complex classes are correctly parsed into separate variables.
- **Piping**: Many svtk subcommands, such as `count-svtypes`, support `stdin`, allowing for efficient integration into bash one-liners without creating intermediate files.

## Reference documentation
- [Anaconda Bioconda svtk Overview](./references/anaconda_org_channels_bioconda_packages_svtk_overview.md)
- [svtk GitHub Repository](./references/github_com_talkowski-lab_svtk.md)
- [svtk Master Commits](./references/github_com_talkowski-lab_svtk_commits_master.md)