---
name: vamos
description: vamos characterizes the internal structure of tandem repeats by decomposing repeat sequences into specific motifs. Use when user asks to characterize tandem repeat structure, decompose repeat sequences into specific motifs, annotate haplotype-resolved assemblies, annotate aligned reads, or call variants for each haplotype.
homepage: https://github.com/ChaissonLab/vamos
---


# vamos

## Overview
vamos (Variable-number tandem repeats Annotation tool using efficient MOtif Sets) is a specialized genomic tool designed to characterize the internal structure of tandem repeats. While standard variant callers often report simple length differences, vamos decomposes repeat sequences into specific motifs. This provides a compact and biologically relevant representation of VNTR variation, accounting for both sequence motifs and copy number changes. It is particularly effective for analyzing complex loci in long-read datasets (PacBio/Oxford Nanopore) where high sequence diversity exists.

## Installation and Environment
The most reliable way to deploy vamos is via Bioconda.
```bash
conda install -c bioconda vamos
```
Ensure that `htslib` and `abpoa` are available in your environment, as they are core dependencies for BAM processing and partial-order alignment.

## Core CLI Patterns

### 1. Annotating Haplotype-Resolved Assemblies
Use the `--contig` mode when working with BAM files where each file represents a single haplotype (e.g., from a diploid assembly).
```bash
vamos --contig -b assembly.hap1.bam -r motifs.tsv -s sample_name -o hap1.vcf -t 8
```

### 2. Annotating Aligned Reads
Use the `--read` mode for standard aligned long-read BAM files. vamos will attempt to phase the reads.
```bash
vamos --read -b aligned_reads.bam -r motifs.tsv -s sample_name -o reads.vcf -t 8
```

### 3. Handling Phased Data
If your reads are already phased (e.g., using WhatsHap or HapCut2) and contain the `HA` SAM tag, vamos will automatically respect this phasing to call variants for each haplotype. If unphased, it employs a max-cut heuristic to pre-phase reads.

## Motif Catalog Requirements
The motif catalog (`-r`) is a tab-separated file. Ensure your catalog matches your reference genome (GRCh38 or CHM13).
*   **Column 4**: Contains the motifs to be used for annotation (comma-separated).
*   **Column 6**: Indicates the locus type (VNTR or STR).
*   **Column 7**: Period size of the motif consensus.

## Advanced Options (v3.0.0+)
*   **Zero-based Coordinates**: Use `-Z` if your input tandem repeat region file follows standard zero-based BED formatting.
*   **Local Alignment**: Use `-l` to enable local alignment options for motif matching.
*   **Sequence Reconstruction**: Use `-E` to reconstruct the TR sequence from the decomposition.

## Interpreting VCF Output
The output VCF contains specialized INFO fields:
*   **RU**: The set of repeating units (motifs) used for the locus.
*   **ALTANNO_H1 / ALTANNO_H2**: The motif indices (referencing the RU field) that describe the sequence for Haplotype 1 and 2.
*   **LEN_H1 / LEN_H2**: The total count of motifs in the respective haplotype.

## Expert Tips
*   **Memory and Threads**: Partial-order alignment (POA) is computationally intensive. Always specify `-t` to utilize multiple cores, especially for large VNTR loci.
*   **Reference Matching**: Ensure the chromosome naming convention in your BAM file (e.g., "chr1" vs "1") matches your motif catalog exactly to avoid empty outputs.
*   **Edit Distance**: vamos guarantees that the encoded sequence is within a bounded edit distance of the original. If you observe high edit distances in your analysis, verify if the motif catalog is comprehensive for your specific population.

## Reference documentation
- [vamos GitHub Repository](./references/github_com_ChaissonLab_vamos.md)
- [Bioconda vamos Package](./references/anaconda_org_channels_bioconda_packages_vamos_overview.md)