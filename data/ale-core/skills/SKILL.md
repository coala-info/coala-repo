---
name: ale-core
description: ALE evaluates the quality of a genome assembly by calculating a likelihood score based on how well sequencing reads align to the contigs. Use when user asks to assess assembly accuracy, compute ALE scores from BAM files, or convert ALE output to wiggle format for visualization.
homepage: https://github.com/sc932/ALE
---


# ale-core

## Overview
ALE (Assembly Likelihood Estimator) is a reference-independent tool used to assess the quality of a genome assembly. It calculates a likelihood score by evaluating how well sequencing reads align to the assembled contigs or scaffolds. The tool analyzes various factors, including mate-pair orientations, insert sizes, and depth of coverage, to provide a probabilistic measure of assembly accuracy. This skill focuses on the core C-implemented scoring functionality and basic post-processing for visualization.

## Common CLI Patterns

### Core Scoring
The primary command computes the ALE score and outputs a `.ale` file containing the likelihood values.
```bash
ALE [options] <assembly.fasta> <alignments.bam> <output.ale>
```

### Visualization Preparation
Since the core package does not include plotting scripts, the standard workflow involves converting the output to a wiggle format for viewing in tools like IGV (Integrative Genomics Viewer).
```bash
ale2wiggle.py <output.ale>
```
*Note: For large genomes, it is recommended to further convert the resulting `.wig` files to the BigWig format using `wigToBigWig`.*

## Expert Tips and Best Practices

### Input Requirements
- **BAM Sorting**: Ensure your BAM file is properly indexed. While some versions of ALE attempt to autodetect sorting, using a name-sorted BAM is often preferred for mate-pair validation.
- **Secondary Alignments**: Recent updates to the tool allow for ignoring secondary alignments to improve the accuracy of the likelihood calculation.

### Parameter Tuning
- **--realign**: Use this flag to enable a more sensitive alignment check, though it increases computation time.
- **--SNPreport**: Generates a report of potential SNPs based on the alignment data.
- **-ro**: Use this flag for "read-only" detection if you are troubleshooting specific alignment issues without wanting to re-process the entire assembly.

### Interpreting Results
- **ALE Scores**: Higher (less negative) scores generally indicate a better fit between the reads and the assembly.
- **IGV Integration**: Import the assembly FASTA, the BAM file, and the converted wiggle files into IGV. Look for regions where the ALE score drops significantly, as these often correspond to misassemblies, gaps, or collapsed repeats.

## Reference documentation
- [ALE GitHub Repository](./references/github_com_sc932_ALE.md)
- [Bioconda ale-core Overview](./references/anaconda_org_channels_bioconda_packages_ale-core_overview.md)