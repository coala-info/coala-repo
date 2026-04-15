---
name: constax
description: CONSTAX improves the taxonomic resolution of environmental DNA sequences by generating a consensus classification from multiple alignment tools. Use when user asks to assign taxonomy to OTUs, run consensus taxonomic classification, or train classifiers on reference databases like SILVA or UNITE.
homepage: https://github.com/liberjul/CONSTAXv2
metadata:
  docker_image: "quay.io/biocontainers/constax:2.0.20--pyhdfd78af_0"
---

# constax

## Overview

CONSTAX (CONSensus TAXonomy) is a specialized tool designed to improve the taxonomic resolution of environmental DNA sequences. It operates on a "2 out of 3" consensus rule: it compares classifications from RDP Classifier, SINTAX, and BLAST (or UTAX) for each Operational Taxonomic Unit (OTU). If two classifiers agree on a taxon, that taxon is used; if all three differ, it uses p-value ties to determine the best fit. This approach significantly increases classification power compared to using any single tool in isolation.

## Installation and Setup

The most efficient way to deploy CONSTAX is via Bioconda:

```bash
conda install -c bioconda constax
```

Note: For large databases like SILVA, ensure the environment has sufficient resources (up to 128GB RAM may be required for RDP training).

## Common CLI Patterns

### Basic Classification
To run a standard consensus classification using an input FASTA file and a reference database:

```bash
constax -i input.fasta -d reference_db.fasta -o output_dir -n 4 -b
```
*   `-i`: Input sequences in FASTA format.
*   `-d`: Reference database.
*   `-o`: Output directory for results and logs.
*   `-n`: Number of threads for parallel processing.
*   `-b`: Enables BLAST classification (recommended over the legacy UTAX).

### Database Filtering
Before classification, you may need to subset a large database (like SILVA) for specific groups (e.g., Bacteria only):

```bash
python fasta_select_by_keyword.py -i SILVA_138.fasta -o SILVA_bact.fasta -k "Bacteria;"
```

### Training Only
If you only need to prepare the classifier training files without running a full classification:

```bash
constax -d reference_db.fasta -f training_files_dir --train_only
```

## Expert Tips and Best Practices

- **Confidence Thresholds**: The default confidence threshold is 0.8 (`-c 0.8`). Lowering this can increase the number of assignments but may introduce false positives.
- **Memory Management**: When working with the SILVA database, use a high-memory cluster or server. UNITE (for Fungi) is generally less resource-intensive and can often be trained on machines with 32GB RAM.
- **Input Extensions**: CONSTAXv2 supports `.fa`, `.fna`, and `.fasta` extensions for input files.
- **Handling Incertae Sedis**: Recent updates have improved how the tool handles "incertae sedis" (taxa of uncertain placement) to prevent them from causing misranked assignments in the final `constax_taxonomy.txt` output.
- **BLAST Pathing**: If BLAST is not in your system PATH, specify it explicitly using `--blast_path /path/to/blastn`.

## Reference documentation
- [CONSTAXv2 GitHub Repository](./references/github_com_liberjul_CONSTAXv2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_constax_overview.md)