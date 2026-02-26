---
name: mugsy
description: Mugsy aligns multiple whole genomes for comparative genomics analysis. Use when user asks to align multiple related genomes for comparative genomics analysis.
homepage: https://github.com/margyle/MugsyDev
---


# mugsy

yaml
name: mugsy
description: |
  A multiple whole genome aligner. Use when you need to align multiple related genomes for comparative genomics analysis.
  This skill is suitable for tasks involving the alignment of several DNA sequences to identify conserved regions, structural variations, and evolutionary relationships.
```
## Overview
Mugsy is a powerful tool designed for aligning multiple whole genomes. It's particularly useful in comparative genomics, where the goal is to understand the evolutionary relationships and structural similarities or differences between several related genomes. Use Mugsy when you have a set of genomes that you need to align simultaneously to identify conserved regions, detect structural variations, or perform other comparative analyses.

## Usage Instructions

Mugsy is a command-line tool. The primary command is `mugsy`.

### Basic Alignment

To perform a multiple whole genome alignment, you typically provide a list of input FASTA files.

```bash
mugsy input_genome1.fasta input_genome2.fasta input_genome3.fasta --output_dir alignment_results
```

**Key Arguments:**

*   **Input FASTA files**: One or more FASTA files containing the genomes to be aligned.
*   `--output_dir <directory>`: Specifies the directory where Mugsy will store the alignment results. If not provided, results are typically saved in the current directory.

### Common Workflow Patterns

1.  **Aligning a set of related species:**
    ```bash
    mugsy speciesA.fa speciesB.fa speciesC.fa --output_dir my_alignment
    ```
    This will generate alignment files and potentially other related outputs in the `my_alignment` directory.

2.  **Specifying a reference genome (optional but recommended for clarity):**
    While Mugsy performs a multiple alignment, specifying a reference can sometimes help in interpreting the output or guiding the alignment process if the tool supports it (check specific version documentation for advanced options). However, the core functionality is to align all provided genomes together.

### Expert Tips

*   **Input File Preparation**: Ensure all input FASTA files are correctly formatted and contain valid DNA sequences. Large genomes can take significant time and computational resources to align.
*   **Output Directory**: Always specify an output directory to keep your results organized.
*   **Version Specifics**: Refer to the official Mugsy documentation for the most up-to-date command-line options and parameters, as features and arguments can evolve between versions. The bioconda page provides installation and basic usage information.

## Reference documentation
- [Mugsy Overview](https://anaconda.org/bioconda/mugsy)