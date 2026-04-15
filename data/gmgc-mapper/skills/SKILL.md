---
name: gmgc-mapper
description: The gmgc-mapper tool queries microbial sequences against the Global Microbial Gene Catalog to identify gene counterparts and functional annotations. Use when user asks to map genomes or predicted gene sets to the GMGC, find microbial gene distributions across environments, or perform functional annotation of unknown sequences.
homepage: https://github.com/BigDataBiology/GMGC-mapper
metadata:
  docker_image: "quay.io/biocontainers/gmgc-mapper:0.2.0--pyh864c0ab_1"
---

# gmgc-mapper

## Overview
The `gmgc-mapper` tool is a specialized utility for querying the Global Microbial Gene Catalog. It allows researchers to take unknown microbial sequences—either as whole genomes or predicted gene sets—and find their counterparts in a massive, standardized catalog of microbial life. This process is essential for functional annotation and understanding the distribution of specific genes across different environments.

## Installation and Dependencies
The tool requires Python (3.6–3.10). If you are performing genome-wide analysis, `prodigal` must be installed and available in your system PATH.

- **Conda (Recommended):** `conda install -c bioconda gmgc-mapper` (automatically handles the `prodigal` dependency).
- **Pip:** `pip install GMGC-mapper` (requires manual installation of `prodigal` for genome mode).

## Common CLI Patterns

### 1. Mapping a Genome Sequence
When starting with a raw genome (FASTA), the tool uses Prodigal to predict genes before mapping.
```bash
gmgc-mapper -i input.fasta -o output_directory
```

### 2. Mapping Pre-predicted Genes
If you already have gene sequences, you can provide nucleotide (NT) and/or amino acid (AA) files.
```bash
# Using both NT and AA sequences (recommended for higher quality hits)
gmgc-mapper --nt-genes genes.fna --aa-genes genes.faa -o output_directory

# Using only protein sequences
gmgc-mapper --aa-genes genes.faa -o output_directory
```

## Parameters and Best Practices
- **Input Compression:** The tool natively supports compressed FASTA files (`.gz`, `.bz2`, or `.xz`). You do not need to decompress them manually.
- **Output Structure:** The output directory will contain:
    - `prodigal.out`: Gene predictions (if run in genome mode).
    - `gmgc_hits.tsv`: A detailed table of all hits found in the GMGC.
    - `gmgc_mags.tsv`: A table listing found genome bins (MAGs).
    - `summary.txt`: A human-readable summary of the results.
- **Quality Refinement:** While `--aa-genes` is sufficient for mapping, providing the corresponding `--nt-genes` allows the tool to refine hit quality based on nucleotide identity.

## Expert Tips
- **Metagenomic Workflows:** For metagenomic data, it is recommended to perform assembly and gene prediction using a tool like `NGLess` before passing the resulting genes to `gmgc-mapper`.
- **Path Management:** If using the pip installation, ensure `prodigal` is executable from your terminal, or the `-i` (genome) mode will fail.
- **Resource Citation:** If using results for publication, cite: *Coelho, L.P., et al. Towards the biogeography of prokaryotic genes. Nature 601, 252–256 (2022).*

## Reference documentation
- [GMGC-mapper GitHub Repository](./references/github_com_BigDataBiology_GMGC-mapper.md)
- [GMGC-mapper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gmgc-mapper_overview.md)