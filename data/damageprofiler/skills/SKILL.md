---
name: damageprofiler
description: DamageProfiler is a specialized tool for paleogenomics used to authenticate ancient DNA sequences.
homepage: https://github.com/Integrative-Transcriptomics/dedup
---

# damageprofiler

## Overview
DamageProfiler is a specialized tool for paleogenomics used to authenticate ancient DNA sequences. It quantifies the chemical degradation characteristic of old DNA—primarily the deamination of cytosine to uracil, which appears as C-to-T substitutions at the 5' ends of fragments. This skill provides the necessary command-line patterns to generate damage plots and statistics required for aDNA validation.

## Usage Patterns

### Basic Damage Analysis
To run a standard profile on a mapped BAM file:
```bash
damageprofiler -i input.bam -r reference.fasta -o output_directory
```

### Common Parameters
- `-i, --input`: Path to the input BAM, SAM, or CRAM file.
- `-r, --reference`: Path to the reference genome in FASTA format.
- `-o, --output`: Directory where results (plots and text files) will be saved.
- `-s, --species`: (Optional) Specify a species name for the output title.
- `-t, --threshold`: Set the number of bases to consider at the ends of reads (default is usually 25).

### Interpreting Outputs
The tool generates several key files in the output directory:
- `misincorporation.txt`: Tab-separated values showing the frequency of substitutions at each position.
- `damage_plot.pdf`: Visual representation of C-to-T (5') and G-to-A (3') transitions.
- `length_plot.pdf`: Distribution of fragment lengths (aDNA is typically highly fragmented, often <100bp).
- `dna_damage_stats.json`: Summary statistics for programmatic filtering or multi-sample reporting.

## Expert Tips
- **Performance**: Since DamageProfiler is Java-based, ensure your environment has an appropriate JVM installed. It is significantly faster than mapDamage2 for large datasets.
- **Reference Indexing**: Ensure your reference FASTA is indexed (`samtools faidx`) to allow the tool to quickly fetch sequences for comparison.
- **Authentication**: Look for a "smile" pattern in the misincorporation plots (high C-to-T at 5' and high G-to-A at 3') to confirm the DNA is truly ancient and not modern contamination.

## Reference documentation
- [DamageProfiler Overview](./references/anaconda_org_channels_bioconda_packages_damageprofiler_overview.md)