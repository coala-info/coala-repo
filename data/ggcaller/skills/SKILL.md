---
name: ggcaller
description: ggCaller performs graph-based gene calling and pangenome analysis for bacterial genomics by traversing population-level de Bruijn graphs. Use when user asks to call genes across multiple bacterial strains, perform pangenome clustering, or identify open reading frames using a graph-based approach.
homepage: https://github.com/samhorsfield96/ggCaller
---


# ggcaller

## Overview
ggCaller is a specialized tool for bacterial genomics that combines graph-based gene calling with pangenome analysis. By traversing a population-level de Bruijn graph (Bifrost) rather than individual assemblies, it identifies genes with high consistency across closely related strains. It integrates Balrog for high-specificity ORF filtering and Panaroo for pangenome clustering and quality control, making it an efficient alternative to traditional "call-then-cluster" workflows.

## Common CLI Patterns

### Basic Gene Calling and Pangenome Analysis
To run the full pipeline (graph construction, gene calling, and pangenome clustering):
```bash
ggcaller --refs genomes_list.txt --out output_directory
```
*Note: `genomes_list.txt` should be a text file containing paths to your input FASTA or GFA files, one per line.*

### Gene Finding Only
If you only need the gene calls (ORFs) and do not require pangenome clustering or alignment:
```bash
ggcaller --refs genomes_list.txt --out output_directory --gene-finding-only
```

### Using with Docker
When using the official Docker container, ensure you map your local directories and point to the internal Balrog database:
```bash
docker run --rm -it -v $(pwd):/workdir samhorsfield96/ggcaller:latest \
    ggcaller --balrog-db /app/ggc_db \
    --refs /workdir/input_genomes.txt \
    --out /workdir/ggc_results
```

## Expert Tips and Best Practices

### Input Preparation
*   **Graph Inputs**: ggCaller can take both raw reads/assemblies (FASTA) and pre-constructed Bifrost graphs (GFA).
*   **Reference Lists**: Ensure absolute paths are used in your `--refs` file if running from different directories to avoid file-not-found errors during the Bifrost graph construction phase.

### Performance Optimization
*   **Memory Management**: Graph construction is memory-intensive. For large datasets, ensure the environment has sufficient RAM for the Bifrost graph representation.
*   **Parallelization**: ggCaller natively utilizes multi-threading. Use the `-t` or `--threads` flag to specify the number of CPU cores.

### Workflow Integration
*   **Annotation**: ggCaller integrates with DIAMOND and HMMER. If you require functional annotation, ensure these dependencies are in your PATH or use the provided Conda environment.
*   **Output Files**: The primary output is a GFF3 file containing gene calls and a pangenome graph. If `--gene-finding-only` is used, focus on the `called_genes.gff` and `called_genes.fasta` files.

## Reference documentation
- [ggCaller GitHub Repository](./references/github_com_samhorsfield96_ggCaller.md)
- [ggCaller Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ggcaller_overview.md)