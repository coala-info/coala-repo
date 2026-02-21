---
name: compleasm
description: `compleasm` is a specialized bioinformatics tool designed to assess the quality of genomic data by identifying the presence of Universal Single-Copy Orthologs (BUSCOs).
homepage: https://github.com/huangnengCSU/compleasm
---

# compleasm

## Overview
`compleasm` is a specialized bioinformatics tool designed to assess the quality of genomic data by identifying the presence of Universal Single-Copy Orthologs (BUSCOs). By replacing traditional alignment tools with `miniprot`, it achieves significantly higher speeds and improved accuracy compared to the original BUSCO pipeline. This skill provides the necessary command-line patterns to manage lineages, execute completeness pipelines, and interpret results for both genome assemblies and protein sequences.

## Installation and Setup
The most reliable way to install `compleasm` and its dependencies (miniprot, hmmer, sepp, pandas) is via Bioconda:

```bash
conda create -n compleasm -c conda-forge -c bioconda compleasm
conda activate compleasm
```

## Core Workflows

### 1. Lineage Management
Before running an assessment, you must identify and download the appropriate BUSCO lineage.

*   **List available lineages:**
    ```bash
    compleasm list remote  # Show all available lineages on OrthoDB
    compleasm list local   # Show already downloaded lineages
    ```

*   **Download a specific lineage:**
    ```bash
    compleasm download primates  # Downloads to mb_download/ by default
    ```

### 2. Evaluating Genome Completeness
The `run` submodule is the primary entry point for genome assemblies.

*   **Standard run with known lineage:**
    ```bash
    compleasm run -a assembly.fa -o output_dir -l primates -t 16
    ```

*   **Automatic lineage detection:**
    Requires `sepp` to be installed. This is useful when the specific taxonomic group is unknown.
    ```bash
    compleasm run -a assembly.fa -o output_dir --autolineage -t 16
    ```

*   **Handling Retrocopies:**
    Use the `--retrocopy` flag (v0.2.7+) to distinguish between true duplicated genes and retrocopies.
    ```bash
    compleasm run -a assembly.fa -o output_dir -l primates --retrocopy
    ```

### 3. Evaluating Protein Sets
To assess the completeness of a predicted protein set rather than a genome assembly:
```bash
compleasm protein -p proteins.faa -l eukaryota -o protein_out -t 8
```

### 4. Analyzing Existing Alignments
If you have already generated a miniprot alignment, you can skip the alignment step:
```bash
compleasm analyze -l primates -m alignment.out -o analysis_out
```

## Expert Tips and Best Practices

*   **Library Path Persistence:** Use the `-L` or `--library_path` flag to point to a permanent directory for BUSCO lineages. This prevents `compleasm` from re-downloading datasets for every run.
    ```bash
    compleasm run -a genome.fa -o out -l primates -L /path/to/shared/busco_db/
    ```
*   **Thread Scaling:** `compleasm` scales well with threads (`-t`). For large mammalian genomes, using 16-32 threads is recommended to minimize runtime.
*   **Contig Filtering:** If you only want to evaluate specific chromosomes or scaffolds, use the `--specified_contigs` flag followed by a list of contig names.
*   **Version Compatibility:** Note that `compleasm` v0.2.7 supports BUSCO odb12 but is not backward compatible with odb10. Use v0.2.6 if you specifically require odb12 datasets.
*   **Output Interpretation:** The primary output is `summary.txt` in the output directory, providing the standard S (Single), D (Duplicated), F (Fragmented), and M (Missing) metrics.

## Reference documentation
- [compleasm GitHub Repository](./references/github_com_huangnengCSU_compleasm.md)
- [Bioconda compleasm Overview](./references/anaconda_org_channels_bioconda_packages_compleasm_overview.md)