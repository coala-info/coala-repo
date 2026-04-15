---
name: proteinortho
description: This tool detects orthologous genes within different species. Use when user asks to find orthologous genes, identify gene families conserved across multiple organisms, or find species-specific gene expansions.
homepage: https://gitlab.com/paulklemm_PHD/proteinortho/
metadata:
  docker_image: "quay.io/biocontainers/proteinortho:6.3.6--h2b77389_0"
---

# proteinortho

yaml
name: proteinortho
description: Detects orthologous genes within different species. Use when analyzing genomic data to identify gene families conserved across multiple organisms, or to find species-specific gene expansions.
```
## Overview
Proteinortho is a powerful command-line tool designed for identifying orthologous genes across a set of input genomes. It's essential for comparative genomics, helping researchers understand gene conservation, evolutionary relationships, and gene family dynamics between different species. Use Proteinortho when you need to systematically compare gene content across multiple bacterial, archaeal, or eukaryotic genomes to find genes that share a common evolutionary ancestor.

## Usage Instructions

Proteinortho requires a set of protein sequence files (in FASTA format) as input, one for each species you want to compare. The core functionality involves finding reciprocal best hits between all pairs of species.

### Basic Usage

The most straightforward way to run Proteinortho is by providing a list of input FASTA files.

```bash
proteinortho <file1.fasta> <file2.fasta> ... <fileN.fasta>
```

**Example:**

```bash
proteinortho speciesA.fasta speciesB.fasta speciesC.fasta
```

This command will compare the protein sequences from `speciesA.fasta`, `speciesB.fasta`, and `speciesC.fasta` to identify orthologous groups.

### Key Options and Parameters

Proteinortho offers several options to fine-tune its behavior and output. Here are some of the most commonly used:

*   **`-project <name>`**: Assigns a project name to the output files. This is highly recommended for organizing your results.
    ```bash
    proteinortho -project my_orthologs speciesA.fasta speciesB.fasta
    ```

*   **`-o <output_directory>`**: Specifies a directory where all output files will be saved.
    ```bash
    proteinortho -o ./results speciesA.fasta speciesB.fasta
    ```

*   **`-step <number>`**: Controls the number of steps in the orthology detection process. The default is usually sufficient, but advanced users might adjust this. Common values are 4 or 5.
    ```bash
    proteinortho -step 5 speciesA.fasta speciesB.fasta
    ```

*   **`-e <evalue>`**: Sets the E-value threshold for BLAST searches. A lower E-value stringently requires higher similarity. The default is typically `1e-05`.
    ```bash
    proteinortho -e 1e-10 speciesA.fasta speciesB.fasta
    ```

*   **`-blast <program>`**: Specifies the BLAST program to use (e.g., `blastp`, `blastx`). `blastp` is standard for protein-to-protein comparisons.
    ```bash
    proteinortho -blast blastp speciesA.fasta speciesB.fasta
    ```

*   **`-usearch`**: Enables the use of `usearch` for faster clustering, which can be significantly quicker for large datasets.
    ```bash
    proteinortho -usearch speciesA.fasta speciesB.fasta
    ```

*   **`-singles`**: Includes genes that do not have any orthologs in any of the other species. By default, these are excluded.
    ```bash
    proteinortho -singles speciesA.fasta speciesB.fasta
    ```

*   **`-allow_single_species`**: Allows ortholog groups to contain genes from only one species. This is useful for identifying species-specific gene families.
    ```bash
    proteinortho -allow_single_species speciesA.fasta speciesB.fasta
    ```

*   **`-gt <genome_threshold>`**: Sets a threshold for the minimum number of genomes an orthologous group must be present in to be considered.
    ```bash
    proteinortho -gt 2 speciesA.fasta speciesB.fasta speciesC.fasta
    ```

### Output Files

Proteinortho generates several output files, typically prefixed by the project name or the input filenames. Key files include:

*   **`.orthologs`**: A tab-separated file listing the orthologous groups. Each line represents a group, with gene identifiers from each species separated by spaces.
*   **`.summary`**: Provides a summary of the orthologous groups found, including counts and statistics.
*   **`.fasta`**: Concatenated FASTA files of the identified orthologs.

### Expert Tips

*   **Input Preparation**: Ensure your input FASTA files are clean and contain only protein sequences. Gene IDs within each file should be unique.
*   **Project Naming**: Always use the `-project` option to keep your output organized, especially when running multiple analyses.
*   **Resource Management**: For large datasets, consider using the `-usearch` option for significant speed improvements. Proteinortho can be computationally intensive, so running it on a cluster or HPC is often necessary.
*   **Interpreting Results**: Pay close attention to the `.orthologs` file. The structure of gene identifiers within this file will tell you which genes belong to the same orthologous group across species.
*   **Customizing BLAST**: If you need to use specific BLAST parameters not directly exposed by Proteinortho, you might need to pre-process your data or run BLAST separately and then use Proteinortho's options to leverage existing BLAST databases. However, direct command-line usage is preferred for simplicity.

## Reference documentation
- [README.md](./references/gitlab_com_paulklemm_PHD_proteinortho_-_blob_master_README.md)