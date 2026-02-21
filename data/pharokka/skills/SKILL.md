---
name: pharokka
description: pharokka is a specialized annotation pipeline tailored specifically for bacteriophages.
homepage: https://github.com/gbouras13/pharokka
---

# pharokka

## Overview

pharokka is a specialized annotation pipeline tailored specifically for bacteriophages. While general tools like Prokka or Bakta are excellent for bacteria, pharokka excels in the viral domain by utilizing PHANOTATE—a gene predictor optimized for phage genomes—and the PHROGs (Phage Rare Gene Family) database. It provides a standardized output (GFF, GenBank, TSV) that is compatible with comparative genomics tools like Roary.

## Installation and Setup

Before running annotations, the databases must be downloaded and indexed.

```bash
# Install via Conda
conda install -c bioconda pharokka

# Download and install databases (required once)
install_databases.py -o /path/to/database_dir
```

## Common CLI Patterns

### Standard Annotation
The basic command for a single phage genome.
```bash
pharokka.py -i genome.fasta -o output_dir -d /path/to/database_dir -t 8
```

### Rapid Annotation
Use the `--fast` flag to speed up functional assignments using MMseqs2 instead of more intensive HMM searches.
```bash
pharokka.py -i genome.fasta -o output_dir -d /path/to/database_dir --fast
```

### Metagenomic Mode
When working with metagenomic viral contigs, use the `prodigal-gv` (GeneVieve) predictor, which is optimized for virus detection in mixed samples.
```bash
pharokka.py -i metagenome_contigs.fasta -o output_dir -d /path/to/database_dir -g prodigal-gv
```

### RNA Phage Annotation
For RNA phages or viruses, use the `pyrodigal-rv` predictor.
```bash
pharokka.py -i rna_phage.fasta -o output_dir -d /path/to/database_dir -g pyrodigal-rv
```

## Expert Tips and Best Practices

*   **Gene Predictor Selection:** While `phanotate` is the default and generally superior for phages, `prodigal` or `pyrodigal` can be used if you require consistency with specific bacterial annotation pipelines.
*   **Large Datasets:** If processing thousands of contigs, use the `--reverse_mmseqs2` flag. This makes the PHROG profile database the target rather than the query, significantly improving performance on massive datasets.
*   **Sensitivity:** Use the `--sensitivity` flag (values 1-7) to adjust MMseqs2 search depth. Higher values increase sensitivity at the cost of speed.
*   **Post-Processing with Phold:** For the highest quality annotation, take the GenBank output from pharokka and run it through **phold**. Phold uses structural homology (FoldSeek) to identify functions for "hypothetical" proteins that pharokka might miss.
*   **Pangenomics:** The `.gff` file produced by pharokka is specifically formatted to be compatible with Roary and Panaroo. Ensure you do not manually edit the GFF header if you plan to use these tools.

## Reference documentation
- [pharokka GitHub Repository](./references/github_com_gbouras13_pharokka.md)
- [pharokka Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pharokka_overview.md)