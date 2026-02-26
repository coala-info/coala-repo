---
name: unitig-caller
description: unitig-caller identifies and calls specific sequence fragments (unitigs) across multiple genomic datasets. Use when user asks to extract unique unitigs, build a population graph, query for unitig presence in new datasets, or perform fast unitig presence/absence calling.
homepage: https://github.com/johnlees/unitig-caller
---


# unitig-caller

## Overview
`unitig-caller` is a specialized tool for bacterial genomics that identifies specific sequence fragments (unitigs) across multiple genomes or read sets. It acts as a bridge between raw sequence data and association studies, allowing you to define a "pangenome" of unitigs from a discovery set and then efficiently "call" those same sequences in validation or expansion cohorts. It supports three primary modes: building a population graph (`--call`), querying a graph (`--query`), and fast index-based searching (`--simple`).

## Core Workflows

### 1. Discovery: Building a Population Graph (--call)
Use this mode to extract all unique unitigs from a set of assemblies or reads. This is typically the first step in a GWAS pipeline.

*   **From raw files:**
    ```bash
    unitig-caller --call --refs assemblies.txt --reads reads.txt --out discovery_set --pyseer
    ```
    *Note: `assemblies.txt` and `reads.txt` should contain absolute paths, one per line.*
*   **From an existing Bifrost graph:**
    ```bash
    unitig-caller --call --graph population.gfa --colours population.bfg_colors --out discovery_set
    ```

### 2. Validation: Querying New Populations (--query)
Use this mode when you have a predefined list of unitigs (e.g., from a previous study) and want to check their presence in a new dataset using a de Bruijn graph.

```bash
unitig-caller --query --unitigs study_unitigs.fasta --refs new_samples.txt --out validation_set
```

### 3. Fast Search: FM-Index Matching (--simple)
Use this mode for the fastest presence/absence calling in assemblies using suffix arrays. It is ideal for applying existing pyseer models to new genomes.

```bash
unitig-caller --simple --refs genomes.txt --unitigs queries.txt --out results
```
*   **Input format:** `queries.txt` assumes a header row; the unitig sequence must be in the first column.
*   **Optimization:** By default, it saves `.idx` files next to your assemblies to speed up future runs. Use `--no-save-idx` to disable this if disk space is limited.

## Expert Tips & Best Practices

*   **Input Preparation:** Always use absolute paths in your input text files to avoid execution errors. A quick way to generate these: `ls -d -1 $PWD/*.fasta > refs.txt`.
*   **Read Filtering:** When using `--reads`, Bifrost automatically filters out kmers with coverage < 1 to eliminate sequencing errors. Ensure your high-quality assemblies are passed to `--refs` and raw data to `--reads` to maintain graph integrity.
*   **K-mer Selection:** The default k-mer size is 31. If working with highly repetitive regions or very short reads, you may need to adjust this using `--kmer`, but 31 is the standard for most bacterial applications.
*   **Output Formats:** 
    *   Use `--pyseer` for downstream association testing (unitig sequence followed by sample names).
    *   Use `--rtab` for a standard presence/absence matrix (1s and 0s).
*   **Performance:** Always specify `--threads` to match your environment, as graph construction and FM-index searching are computationally intensive.

## Reference documentation
- [GitHub Repository Documentation](./references/github_com_bacpop_unitig-caller.md)