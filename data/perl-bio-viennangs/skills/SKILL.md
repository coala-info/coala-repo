---
name: perl-bio-viennangs
description: The `Bio::ViennaNGS` suite provides a collection of high-level Perl modules and command-line utilities designed to streamline NGS data processing.
homepage: http://metacpan.org/pod/Bio::ViennaNGS
---

# perl-bio-viennangs

## Overview
The `Bio::ViennaNGS` suite provides a collection of high-level Perl modules and command-line utilities designed to streamline NGS data processing. It is particularly effective for researchers working with non-standard RNA-seq protocols, requiring precise control over genomic intervals, or needing to interface with the ViennaRNA package. This skill facilitates the execution of its core utilities for data conversion, normalization, and structural analysis of sequencing reads.

## Core Utilities and Usage Patterns

### Genomic Interval Manipulation
Use these tools to handle BED and GTF files with high precision:
*   **`kallisto_quant_merge.pl`**: Consolidate multiple Kallisto abundance estimates into a single expression matrix.
*   **`bed2gff.pl`**: Convert BED format intervals to GFF3, ensuring proper attribute mapping for downstream annotation pipelines.
*   **`gff2bed.pl`**: Extract genomic features from GFF3 files into BED format for visualization or intersection analysis.

### BAM and Alignment Processing
*   **`bam_split.pl`**: Split BAM files based on specific criteria (e.g., strand-specific reads), which is essential for processing dends-specific RNA-seq data.
*   **`bam_to_bigwig.pl`**: Generate strand-specific BigWig tracks from BAM files for genome browser visualization (UCSC/IGV). It handles normalization automatically if requested.

### RNA-seq Specific Workflows
*   **`trim_split.pl`**: Pre-process fastq files by trimming adapters and splitting multiplexed reads.
*   **`sj_visualize.pl`**: Create visualization-ready files for splice junctions identified in RNA-seq alignments.
*   **`assembly_stats.pl`**: Generate descriptive statistics for de novo assemblies or mapped contigs.

## Expert Tips and Best Practices
*   **Strand Awareness**: Many `ViennaNGS` tools default to strand-specific processing. Always verify if your library prep was dUTP/Forward/Reverse to ensure correct flag usage in `bam_split.pl`.
*   **Memory Management**: When processing large BAM files for BigWig conversion, ensure `samtools` is in your PATH, as `ViennaNGS` often wraps these C-based utilities for performance.
*   **Pipe Integration**: These Perl utilities are designed to work within standard Unix pipes. You can often stream output from `samtools view` directly into `ViennaNGS` scripts to save disk I/O.
*   **Annotation Consistency**: When converting between BED and GFF, ensure your chromosome naming conventions (e.g., "chr1" vs "1") match your reference genome to avoid empty output files.

## Reference documentation
- [Bio::ViennaNGS Documentation](./references/metacpan_org_pod_Bio__ViennaNGS.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-viennangs_overview.md)