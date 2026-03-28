---
name: gbintk
description: GraphBin-Tk is a graph-based binning toolkit that integrates MetaCoAG, GraphBin, and GraphBin2 to perform initial metagenomic binning and bin refinement using assembly graph connectivity. Use when user asks to perform initial binning from assembly graphs, refine existing bins, recover short contigs, identify overlapped bins, or evaluate binning performance against a ground truth.
homepage: https://github.com/metagentools/gbintk
---

# gbintk

## Overview
GraphBin-Tk (gbintk) is a unified toolkit that integrates three powerful graph-based binning algorithms: MetaCoAG (for initial binning), and GraphBin/GraphBin2 (for bin refinement). Unlike traditional binning tools that rely solely on sequence composition (k-mer frequencies) and coverage, gbintk leverages the connectivity information within the assembly graph to resolve ambiguous contig assignments, recover short contigs, and identify contigs shared across multiple bins (overlapped binning).

## Core Workflows

### 1. Initial Binning with MetaCoAG
Use `metacoag` when you have an assembly and abundance data but no initial bins. It uses single-copy marker genes and the assembly graph to generate bins from scratch.

**Required Inputs:**
- `--assembler`: `spades`, `megahit`, or `flye`.
- `--graph`: Path to the assembly graph (`.gfa`).
- `--contigs`: Path to the contigs (`.fasta`).
- `--abundance`: Path to the abundance file (TSV, no headers).
- `--paths`: (Required for SPAdes/Flye) Path to `.paths` or `assembly_info.txt`.

**Example:**
```bash
gbintk metacoag --assembler spades --graph assembly_graph.gfa --contigs contigs.fasta --paths contigs.paths --abundance abundance.tsv --output metacoag_results
```

### 2. Bin Refinement with GraphBin / GraphBin2
Use these subcommands to improve results from other binners (e.g., MaxBin2, MetaBAT2).
- **GraphBin**: Best for standard refinement and recovering discarded short contigs.
- **GraphBin2**: Best when you expect contigs to belong to multiple species (overlapped binning).

**Preprocessing Step:**
Before refining, format your existing bins using the `prepare` command:
```bash
gbintk prepare --assembler spades --resfolder ./existing_bins_dir --output ./prepared_bins
```

**Refinement Example (GraphBin2):**
```bash
gbintk graphbin2 --assembler megahit --graph final.gfa --contigs final.contigs.fa --binned prepared_bins/initial_contig_bins.csv --abundance abundance.tsv --output refined_results
```

### 3. Visualization and Evaluation
- **Visualise**: Generates images comparing initial vs. refined binning mapped onto the assembly graph.
- **Evaluate**: Calculates Precision, Recall, F1-score, and Adjusted Rand Index (ARI) against a ground truth.

**Evaluation Example:**
```bash
gbintk evaluate --binned results.csv --groundtruth ground_truth.csv --output eval_dir
```

## Expert Tips and Best Practices
- **Abundance Files**: Ensure the `abundance.tsv` file (often generated via CoverM) has its header removed (`sed -i '1d' abundance.tsv`) before running `metacoag` or `graphbin2`.
- **Assembler Specifics**: 
    - For **MEGAHIT**, you must convert the native `.fastg` to `.gfa` using `fastg2gfa` before gbintk can process the graph.
    - For **SPAdes**, always use the `assembly_graph_with_scaffolds.gfa` for the best connectivity data.
- **Marker Genes**: MetaCoAG relies on HMMER and FragGeneScan. If you have a custom marker gene set, use the `--hmm` flag to point to your specific `.hmm` file.
- **Memory Management**: Graph-based operations can be memory-intensive. Use the `--nthreads` flag to balance performance, but monitor RAM usage on large metagenomes.



## Subcommands

| Command | Description |
|---------|-------------|
| gbintk evaluate | Evaluate the binning results given a ground truth |
| gbintk prepare | Format the initial binning result from an existing binning tool |
| gbintk visualise | Visualise binning and refinement results |

## Reference documentation
- [GraphBin-Tk Overview](./references/gbintk_readthedocs_io_en_latest.md)
- [MetaCoAG Usage](./references/gbintk_readthedocs_io_en_latest_metacoag_usage.md)
- [GraphBin2 Usage](./references/gbintk_readthedocs_io_en_latest_graphbin2_usage.md)
- [GraphBin Usage](./references/gbintk_readthedocs_io_en_latest_graphbin_usage.md)
- [Preprocessing and Formatting](./references/gbintk_readthedocs_io_en_latest_prepare.md)
- [Evaluation Metrics](./references/gbintk_readthedocs_io_en_latest_evaluate.md)