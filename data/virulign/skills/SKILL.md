---
name: virulign
description: "Performs codon-correct pairwise alignments of viral genomes and annotates alignments with protein positions. Use when user asks to align viral sequences while preserving codon integrity and incorporating protein-level annotations."
homepage: https://github.com/rega-cev/virulign
---


# virulign

Performs codon-correct pairwise alignments of viral genomes and annotates alignments with protein positions.
  Use when you need to align viral sequences while preserving codon integrity and incorporating protein-level annotations.
  This tool is particularly useful for evolutionary analysis, variant tracking, and functional annotation of viral genomes.
---
## Overview

VIRULIGN is a specialized bioinformatics tool designed for creating codon-correct pairwise alignments of viral genomes. Beyond simple alignment, it offers the capability to annotate these alignments with the positions of proteins. This makes it invaluable for researchers studying viral evolution, identifying genetic variations, and understanding the functional implications of genomic changes.

## Usage Instructions

VIRULIGN is a command-line tool. The primary function is to perform pairwise alignments and annotate them.

### Core Functionality: Alignment and Annotation

The fundamental use of VIRULIGN involves providing two input sequences and generating an alignment. The tool's strength lies in its ability to maintain codon correctness during this process, which is crucial for analyzing protein-coding regions of viral genomes.

**Basic Alignment:**

While specific command-line examples are not detailed in the provided documentation, the general workflow would involve specifying input sequences and an output format.

**Annotation:**

The augmented functionality allows for the annotation of alignments with protein positions. This implies that VIRULIGN can identify protein-coding regions within the aligned sequences and mark them accordingly.

### Installation

VIRULIGN can be installed via Conda from the bioconda channel:

```bash
conda install bioconda::virulign
```

Alternatively, it can be built from source. Refer to the `BUILD.txt` file for detailed instructions on building from source.

### Key Considerations and Expert Tips

*   **Codon Correctness:** Always ensure that your input sequences are representative of viral genomes where codon-level analysis is important. VIRULIGN's core feature is preserving this integrity.
*   **Protein Annotation:** Leverage the protein annotation feature to gain deeper insights into the functional impact of sequence variations. This is particularly useful when comparing different strains or isolates.
*   **Input Formats:** The documentation does not explicitly state supported input sequence formats (e.g., FASTA, GenBank). It is recommended to use standard bioinformatics formats like FASTA.
*   **Output Formats:** Similarly, output formats are not specified. Common alignment formats like FASTA alignment, Clustal, or Phylip are likely supported or can be inferred.
*   **Error Handling:** The GitHub issues indicate potential issues like "Segmentation Fault" and "Misalignment of sequences." If encountering such problems, ensure your input data is clean and correctly formatted. Reviewing the `README.md` and `BUILD.txt` for build and usage details is advisable.

## Reference documentation

- [VIRULIGN README](./references/github_com_rega-cev_virulign.md)