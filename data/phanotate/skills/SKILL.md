---
name: phanotate
description: PHANOTATE is a specialized gene caller that uses a weighted graph approach to identify genes in phage genomes. Use when user asks to predict genes in phage genomes, identify overlapping open reading frames, or generate protein and nucleotide sequences from viral fasta files.
homepage: https://github.com/deprekate/PHANOTATE
---


# phanotate

## Overview

PHANOTATE is a specialized gene caller designed for the unique architecture of phage genomes. Unlike general-purpose prokaryotic gene callers, it treats the genome as a weighted graph to find the most likely path of genes. This approach is particularly effective at handling the high gene density and frequent overlaps characteristic of viruses, where non-coding regions are typically minimized. It is the preferred tool for phage researchers who require high-sensitivity gene calling that accounts for the evolutionary pressure on phages to maintain small, efficient genomes.

## Installation and Setup

PHANOTATE can be installed via Conda or Pip:

```bash
# Via Bioconda
conda install bioconda::phanotate

# Via Pip
pip3 install phanotate
```

## Common CLI Patterns

### Basic Gene Calling
The simplest usage outputs a list of predicted ORFs with their start, stop, strand, and score.
```bash
phanotate.py genome.fasta > predictions.txt
```

### Specifying Output Formats
PHANOTATE supports several standard bioinformatics formats using the `-f` flag:

*   **GenBank**: Useful for downstream annotation and visualization.
    ```bash
    phanotate.py genome.fasta -f genbank > genome.gb
    ```
*   **GFF3**: Standard format for genome browsers.
    ```bash
    phanotate.py genome.fasta -f gff3 > genome.gff3
    ```
*   **Protein FASTA (.faa)**: Extracts the translated amino acid sequences of predicted genes.
    ```bash
    phanotate.py genome.fasta -f faa > proteins.faa
    ```
*   **Nucleotide FASTA (.fna)**: Extracts the DNA sequences of the predicted genes.
    ```bash
    phanotate.py genome.fasta -f fna > genes.fna
    ```

## Expert Tips and Best Practices

### Handling Overlapping Genes
Because PHANOTATE uses a path-finding algorithm through a weighted graph, it is natively better at resolving overlapping genes than tools like Prodigal. If you are working with highly compact "jumbo" phages or small, dense genomes, PHANOTATE should be your primary choice.

### Filtering by Length
If your output contains too many small, likely spurious fragments, use the minimum ORF length parameter to clean up the results:
```bash
# Example: Filter for ORFs at least 90bp long
phanotate.py genome.fasta --min_orf_len 90
```

### tRNA Integration
Recent versions of PHANOTATE have added support for integrating tRNA masking (using tools like Aragorn). This prevents the gene caller from incorrectly identifying tRNA regions as protein-coding ORFs.

### Interpreting Scores
The scores provided in the output represent the log-likelihood of the path. Lower (more negative) scores generally indicate higher confidence in the gene call within the context of the entire genome's path.

## Reference documentation
- [PHANOTATE GitHub README](./references/github_com_deprekate_PHANOTATE.md)
- [Bioconda PHANOTATE Overview](./references/anaconda_org_channels_bioconda_packages_phanotate_overview.md)
- [PHANOTATE Commit History (Parameter Details)](./references/github_com_deprekate_PHANOTATE_commits_master.md)