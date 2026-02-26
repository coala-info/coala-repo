---
name: bmge
description: BMGE identifies and extracts phylogenetically informative regions from multiple sequence alignments while removing noisy or gap-rich sites. Use when user asks to trim sequence alignments, filter noisy regions for phylogenetics, or remove gaps and high-entropy sites from DNA or protein data.
homepage: https://bioweb.pasteur.fr/packages/pack@BMGE@1.12
---


# bmge

## Overview
BMGE is a specialized tool designed to refine multiple sequence alignments before they are used for phylogenetic tree reconstruction. It identifies and extracts blocks of characters that carry reliable phylogenetic information while discarding noisy regions (such as those with high entropy or excessive gaps) that can lead to artifacts in tree building. It is particularly useful for large-scale phylogenomic datasets where automated trimming is required to ensure consistency and computational efficiency.

## Usage Guidelines

### Basic Command Structure
BMGE is typically executed as a Java application. The basic syntax is:
```bash
java -jar BMGE.jar -i <input_alignment> -t <sequence_type> -o <output_file>
```

### Key Parameters
- `-i`: Input alignment file (e.g., FASTA, PHYLIP).
- `-t`: Type of data. Use `AA` for Amino Acids or `DNA` for Nucleotides.
- `-m`: Substitution matrix (e.g., BLOSUM62 for proteins).
- `-h`: Entropy threshold (default is 0.5). Lower values are more stringent (removing more sites).
- `-g`: Gap fraction threshold (default is 0.2). Sites with gaps exceeding this proportion are removed.
- `-of`: Output format (e.g., FASTA, PHYLIP, NEXUS).

### Common CLI Patterns
- **Standard Protein Trimming**:
  ```bash
  java -jar BMGE.jar -i alignment.fasta -t AA -m BLOSUM62 -h 0.5 -of fasta -o trimmed_alignment.fasta
  ```
- **Strict DNA Filtering**:
  To retain only the most conserved regions in a DNA alignment:
  ```bash
  java -jar BMGE.jar -i dna_align.fasta -t DNA -h 0.3 -g 0.1 -o strict_align.fasta
  ```

### Expert Tips
- **Entropy Selection**: The entropy threshold (`-h`) is the most critical parameter. If your resulting tree has low bootstrap support, consider lowering the threshold to remove more noise.
- **Matrix Choice**: When working with proteins, ensure the substitution matrix (`-m`) matches the expected evolutionary distance of your taxa.
- **Data Inspection**: Always compare the length of the alignment before and after BMGE to ensure you haven't inadvertently removed too much informative data.

## Reference documentation
- [BMGE Overview](./references/anaconda_org_channels_bioconda_packages_bmge_overview.md)