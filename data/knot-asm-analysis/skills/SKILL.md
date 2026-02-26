---
name: knot-asm-analysis
description: knot-asm-analysis investigates and resolves fragmented long-read assemblies by identifying paths between contig extremities to produce an Augmented Assembly Graph. Use when user asks to resolve fragmented assemblies, identify connections between contigs using long reads, or generate an Augmented Assembly Graph report.
homepage: https://github.com/natir/knot
---


# knot-asm-analysis

## Overview
KNOT (Knowledge Network Overlap exTraction) is a diagnostic tool designed to investigate and resolve fragmented long-read assemblies. By leveraging the original read set (raw or corrected), KNOT identifies paths between contig extremities that were not captured by the primary assembler. It produces an Augmented Assembly Graph (AAG) that distinguishes between likely true adjacencies and repeat-induced paths, providing a clearer picture of the genomic architecture.

## Core Workflows

### Running the Analysis
The primary command `knot` executes a Snakemake-based pipeline. You must provide the contigs and the reads used to generate them.

**Basic command for raw reads:**
```bash
knot -r raw_reads.fasta -c contigs.fasta -o output_prefix -- -j 8
```

**Using corrected reads:**
If using corrected reads, use the `-C` flag (or `-m` in some versions) to skip internal error correction steps:
```bash
knot -C corrected_reads.fasta -c contigs.fasta -o output_prefix -- -j 8
```

**Including an assembly graph:**
If your assembler produced a GFA file, providing it can improve the results:
```bash
knot -r raw_reads.fasta -c contigs.fasta -g assembly.gfa -o output_prefix -- -j 8
```

### Generating the HTML Report
After the initial `knot` run, use `knot.analysis` to create a visual representation of the AAG.

```bash
knot.analysis -i output_prefix -c -p -o knot_report.html
```
*   `-c`: Performs path classification (length and composition).
*   `-p`: Executes a Hamiltonian path search to suggest a potential scaffolding order.

## CLI Parameter Optimization

| Parameter | Usage |
| :--- | :--- |
| `--read-type` | Set to `pb` (PacBio) or `ont` (Oxford Nanopore). Default is `pb`. |
| `--search-mode` | Use `base` to optimize for path length or `node` to optimize for the number of intermediate reads. |
| `--contig-min-length` | Filter out small, noisy contigs (e.g., `<1000` bp) to simplify the resulting graph. |
| `--` | Any parameters following the double dash are passed directly to Snakemake (e.g., `-j` for threads, `--rerun-incomplete`). |

## Interpreting Results

### The Augmented Assembly Graph (AAG)
The main output is `{prefix}_AAG.csv`. Key columns for manual investigation include:
*   **tig1 / tig2**: The contig names and extremities (begin/end) being linked.
*   **nb_read**: The number of reads forming the path between contigs.
*   **nb_base**: The estimated distance (in bases) between the contigs.
*   **paths**: The specific read IDs involved in the connection.

### Best Practices
*   **Input Format**: KNOT requires FASTA format for reads. If you have FASTQ files, convert them to FASTA before running.
*   **Bacterial Focus**: While KNOT can run on larger genomes, it is optimized for bacterial genome complexity. For large genomes, focus on the CSV output rather than the HTML report, as visualization may become cluttered.
*   **Adjacency Validation**: Short paths (low `nb_base`) with a high number of supporting reads (`nb_read`) are the strongest candidates for manual joining or scaffolding.

## Reference documentation
- [KNOT Overview](./references/anaconda_org_channels_bioconda_packages_knot-asm-analysis_overview.md)
- [KNOT GitHub Documentation](./references/github_com_natir_knot.md)