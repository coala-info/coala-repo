---
name: ccne
description: The Carbapenemase-encoding gene Copy Number Estimator (ccne) quantifies the abundance of antimicrobial resistance genes by comparing their coverage depth to a single-copy reference. Use when user asks to estimate AMR gene copy numbers, perform fast species-specific gene quantification, or calculate gene abundance using assembly-based depth.
homepage: https://github.com/biojiang/ccne
---

# ccne

## Overview

The Carbapenemase-encoding gene Copy Number Estimator (ccne) is a specialized bioinformatics tool designed to quantify the abundance of AMR genes within a sample. By comparing the depth of coverage of a target AMR gene to a known single-copy reference (either a housekeeping gene or the average genome depth), ccne provides a numerical estimate of how many copies of the resistance gene are present. This is critical for understanding the genetic basis of high-level resistance in clinical pathogens like *Klebsiella pneumoniae* or *Escherichia coli*.

## Core Workflows

### 1. Fast Estimation (ccne-fast)
Use this mode when you know the species of the isolate. it relies on pre-configured housekeeping genes (e.g., `rpoB`, `polB`).

**Required Parameters:**
- `--amr`: The target gene name (e.g., KPC-2, NDM-1).
- `--sp`: The species code (e.g., `Kpn` for *K. pneumoniae*, `Eco` for *E. coli*).
- `--in`: A tab-delimited file listing samples.
- `--out`: Path for the results file.

**Example Command:**
```bash
ccne-fast --amr KPC-2 --sp Kpn --in samples.list --out results.txt --cpus 4
```

### 2. Assembly-Based Estimation (ccne-acc)
Use this mode for higher accuracy or when a draft genome assembly is available. It calculates the average depth across the entire assembly to use as the baseline.

**Example Command:**
```bash
ccne-acc --amr NDM-1 --in samples_with_assembly.list --out results.txt --cpus 8
```

## Input File Preparation

The `--in` file must be a tab-delimited list without headers. The structure varies by tool:

**For ccne-fast:**
`[SampleID]    [Path_to_Read_1]    [Path_to_Read_2]`

**For ccne-acc:**
`[SampleID]    [Path_to_Read_1]    [Path_to_Read_2]    [Path_to_Assembly_Fasta]`

## Expert Tips and Best Practices

- **Database Discovery**: Before running an analysis, always verify the exact nomenclature of the AMR genes and species codes supported by your local installation:
  - `ccne-fast --listdb` (Lists all 2400+ supported AMR genes)
  - `ccne-fast --listsp` (Lists supported species and their default housekeeping genes)
- **Reference Overrides**: In `ccne-fast`, you can manually specify a reference gene using `--ref` if the default housekeeping gene is unsuitable for your specific strain.
- **Handling Plasmids**: When analyzing replicons or specific plasmid types, set `--sp Pls` and use the `--ref` parameter to specify the replicon type.
- **Noise Reduction**: Use the `--flank [N]` parameter to exclude a specific number of bases from the ends of sequences, which can help reduce errors caused by poor mapping at the edges of gene fragments.
- **Performance**: Always utilize the `--cpus` flag to enable multi-threading, as mapping reads to the database is computationally intensive.



## Subcommands

| Command | Description |
|---------|-------------|
| ccne-acc | Carbapenemase-encoding gene copy number estimator (accurate estimator) |
| ccne-fast | Carbapenemase-encoding gene copy number estimator (fast screener) |

## Reference documentation
- [ccne GitHub Repository](./references/github_com_biojiang_ccne.md)
- [ccne README and Usage Guide](./references/github_com_biojiang_ccne_blob_main_README.md)