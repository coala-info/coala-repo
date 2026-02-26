---
name: fgmp
description: FGMP evaluates the completeness of fungal genome assemblies by screening them against a curated set of conserved protein markers and genomic segments. Use when user asks to assess fungal genome assembly quality, identify conserved gene markers, or estimate genome completeness from raw reads.
homepage: https://github.com/stajichlab/FGMP
---


# fgmp

## Overview

FGMP (Fungal Genome Mapping Project) is a specialized bioinformatics pipeline used to evaluate the completeness of fungal genome assemblies. It functions by screening a genome against a curated set of 593 protein markers and 31 highly conserved fungal genomic segments. By utilizing a combination of TBLASTn, EXONERATE, AUGUSTUS, and HMMER, it identifies candidate regions and validates gene structures to provide a high-resolution assessment of gene content. This tool is particularly useful for researchers validating new fungal assemblies or comparing the quality of different assembly versions.

## Usage Patterns

### Basic Genome Assessment
The primary use case is running the pipeline against a completed or draft genome assembly in FASTA format.

```bash
fgmp.pl -g genome_assembly.fasta > fgmp_report.out
```

### Performance Optimization
For large genomes, always specify the number of threads to speed up the BLAST and HMMER steps.

```bash
fgmp.pl -g genome_assembly.fasta -T 8 > fgmp_report.out
```

### Working with Raw Reads (Experimental)
If an assembly is not yet available, FGMP can perform a reservoir sampling of raw reads to estimate marker presence.

```bash
fgmp.pl -g genome_assembly.fasta -T 4 -r raw_reads.fasta
```

### Customizing Markers and Cutoffs
You can override the default data files if you have specialized protein sets or specific profile cutoffs.

```bash
fgmp.pl -g genome.fasta -p custom_proteins.fa -c custom_cutoffs.tbl
```

## Output Interpretation

FGMP generates several files. The most critical for analysis are:

*   **`*.bestPreds.fas`**: The amino acid sequences of the best predicted markers found in the genome.
*   **`*.hmmsearch.summary_report`**: The primary summary file containing the final estimation of genome completeness.
*   **`*.hmmsearch.full_report`**: A detailed breakdown of every marker hit, useful for identifying which specific conserved genes might be missing from an assembly.

## Expert Tips

*   **Environment Setup**: FGMP relies on several external dependencies (NCBI BLAST+, HMMER, Exonerate, and Augustus). The most reliable way to ensure these are correctly configured is via Bioconda: `conda install -c bioconda fgmp`.
*   **Augustus Training**: The pipeline is designed to handle Augustus gene prediction internally. Manual training parameters are typically not required as the tool manages the training set generation based on the identified markers.
*   **Tagging Results**: Use the `--tag` option to organize outputs when running multiple versions of an assembly or comparing different species. This prevents intermediate files from being overwritten.
*   **Memory Management**: While `-T` increases CPU usage, ensure the system has sufficient RAM for Augustus and TBLASTn, especially when working with highly fragmented draft assemblies which can increase the number of candidate regions.

## Reference documentation

- [FGMP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fgmp_overview.md)
- [FGMP GitHub Repository](./references/github_com_stajichlab_FGMP.md)