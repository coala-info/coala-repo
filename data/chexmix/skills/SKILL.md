---
name: chexmix
description: ChExMix identifies genomic binding locations and categorizes them into distinct subtypes using a mixture modeling framework for ChIP-exo data. Use when user asks to identify protein-DNA binding events, discover crosslinking subtypes, or perform motif-based analysis on ChIP-exo experiments.
homepage: http://mahonylab.org/software/chexmix/
---


# chexmix

## Overview

ChExMix (ChIP-exo Mixture Model) is a specialized tool for processing ChIP-exo data. Unlike standard peak callers, it uses a mixture modeling framework to simultaneously identify genomic binding locations and categorize them into distinct "subtypes" based on their unique crosslinking signatures and DNA sequence motifs. This allows for a more nuanced understanding of how proteins interact with DNA in different regulatory contexts.

## Execution and Memory Management

ChExMix is a Java-based tool that is both memory and CPU intensive.

- **Run via JAR**: `java -Xmx20G -jar chexmix.jar <options>`
- **Memory Allocation**: Always specify the `-Xmx` flag. For large datasets or multiple conditions, 20GB is a recommended starting point.
- **Parallelization**: Use `--threads <n>` to speed up binding event detection.

## Core Configuration

### Genome Specification
- **Genome Info**: Provide a tab-separated file (`chrName\tchrLength`) using `--geninfo <file>`.
- **Motif Discovery**: To enable motif-based subtype discovery, you must provide:
  - `--seq <fasta directory>`: Directory containing fasta files for each chromosome.
  - `--back <file>`: Markov background model file.
  - **Note**: MEME must be installed and available in your `$PATH`.

### Data Input
- **Direct Specification**: Use `--exptCOND-REP <file>` for signal and `--ctrlCOND-REP <file>` for controls.
- **Design File**: For complex experiments, use `--design <file>`. The file should be tab-separated:
  `File_Name | Signal/Control | Format | Condition | Replicate | [Type] | [Read_Limit]`
- **Formats**: Supported formats include `SAM`, `BAM`, `BED`, and `IDX`.

## Expert Tips and Best Practices

### Read Filtering and Artifacts
- **Blacklisting**: Use `--exclude <file>` or `--excludebed <file>` to ignore mitochondrial DNA or known artifactual regions (blacklists). This prevents the model from wasting resources on non-biological enrichment.
- **Duplicate Handling**: If your library has high PCR duplication, enable `--readfilter`. You can set a fixed limit with `--fixedpb <value>` or a local Poisson-based limit with `--poissongausspb <value>`.

### Scaling and Normalization
- **Default Scaling**: ChExMix uses NCIS (Normalization of ChIP-seq) by default.
- **Verification**: Use `--plotscaling` to generate diagnostic plots and ensure the signal-to-control scaling is appropriate for your data.
- **Alternatives**: If NCIS fails, consider `--medianscale` or `--sesscale` (the latter requires a smaller `--scalewin`, e.g., 200bp).

### Model Tuning
- **Strictness**: Increase `--alphascale` (default 1.0) to make binding event calls stricter (higher sparse prior).
- **Subtype Balance**: Adjust `--epsilonscale` (default 0.2) to balance the influence of DNA motifs versus read distribution in subtype assignment. Increasing it favors motifs.
- **Initialization**: If you have pre-existing peak calls, use `--peakf <file>` to initialize component positions and potentially speed up convergence.

## Reference documentation
- [ChExMix | Mahony Lab](./references/mahonylab_org_software_chexmix.md)
- [chexmix - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_chexmix_overview.md)