---
name: whatsgnu
description: WhatsGNU ranks protein sequences based on their frequency across public genomes to identify novel proteins. Use when user asks to identify novel proteins, create custom protein databases, identify missing genes, download protein databases, or generate visual reports of proteomic novelty.
homepage: https://github.com/ahmedmagds/WhatsGNU
metadata:
  docker_image: "quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0"
---

# whatsgnu

## Overview
WhatsGNU (What's Gene Novelty Unit) is a specialized proteomic tool that ranks protein sequences based on their frequency of occurrence across thousands of public genomes. By compressing protein databases into unique variants, it allows for rapid exact-match searching. This skill enables the identification of "novel" proteins—those with low or zero GNU scores—which are often of high interest in clinical microbiology, evolutionary biology, and pangenome studies.

## Installation and Setup
The most efficient way to deploy WhatsGNU is via Bioconda:

```bash
conda create -n WhatsGNU -c bioconda whatsgnu
conda activate WhatsGNU
```

For manual installations, ensure dependencies (Python 3, NumPy, SciPy, Matplotlib, and optionally Blastp) are available in your environment.

## Core Workflows

### 1. Database Acquisition
Before running analysis, you must obtain the compressed protein databases.
- **Automatic Download**: Use the built-in utility to fetch available databases.
  ```bash
  WhatsGNU_db_download.py
  ```
- **Manual Download**: Use `wget` for specific species (e.g., S. aureus Ortholog, E. coli Hashed). Hashed databases are recommended for large datasets like RefSeq to save memory.

### 2. Identifying Novelty (Basic Mode)
Use the main script to calculate GNU scores for a set of query proteins against a species-specific database.
```bash
WhatsGNU_main.py -i query_proteins.fasta -d species_database.pickle -o output_report.txt
```

### 3. High-Efficiency Searching (Hashed Mode)
For extremely large databases (e.g., RefSeq, which contains hundreds of millions of proteins), use the hashed implementation to reduce memory overhead.
```bash
WhatsGNU_main_hashes.py -i query_proteins.fasta -d hashed_database_folder/
```

### 4. Custom Database Creation
If working with private or newly sequenced genomes:
1. **Download Genomes**: `WhatsGNU_get_GenBank_genomes.py`
2. **Customize Headers**: Add strain names to protein FASTA headers to ensure proper tracking.
   ```bash
   WhatsGNU_database_customizer.py -i input_folder -o customized_folder
   ```

## Expert Tips and Best Practices
- **GNU Score Interpretation**: A GNU score of 0 indicates a completely novel protein variant not found in the reference database. High scores indicate highly conserved proteins.
- **Memory Management**: When working with the E. coli or RefSeq databases, always prefer the "Hashed" versions. The standard pickle files for these species can exceed 90GB, whereas hashed versions are significantly more compact (e.g., 7.5GB for E. coli).
- **Ortholog vs. Basic Mode**: Use **Ortholog Mode** when you need to know if a specific gene is missing from a genome's pangenome context. Use **Basic Mode** for simple novelty detection across all known variants.
- **Visualization**: After running the main analysis, use `WhatsGNU_plotter.py` to generate visual reports of proteomic novelty across your samples.

## Reference documentation
- [WhatsGNU GitHub Repository](./references/github_com_ahmedmagds_WhatsGNU.md)
- [Bioconda WhatsGNU Package Overview](./references/anaconda_org_channels_bioconda_packages_whatsgnu_overview.md)