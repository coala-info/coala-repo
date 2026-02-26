---
name: dms
description: Dynamic Meta-Storms quantifies differences between metagenomic communities by incorporating phylogenetic relationships into species-level abundance comparisons. Use when user asks to calculate distance matrices for metagenomic samples, compare species-level profiles, or generate phylogenetic-based community distances.
homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms
---


# dms

## Overview
Dynamic Meta-Storms (DMS) is a bioinformatics tool used to quantify the differences between metagenomic communities. Unlike simple abundance comparisons, DMS incorporates phylogenetic relationships, allowing for a more biologically meaningful analysis of species-level shotgun metagenomics data. It is particularly useful when you have species-level profiles (typically from MetaPhlAn) and need to generate a distance matrix for downstream clustering or ordination (like PCoA).

## Core Workflow

### 1. Prepare Input Profiles
DMS requires species-level relative abundance profiles. If starting from raw sequences or BowTie2 outputs, use MetaPhlAn to generate the `.txt` profiles:

```bash
# Example MetaPhlAn2 command for DMS compatibility
metaphlan2.py sample.fasta --input_type fasta --tax_lev s --ignore_viruses --ignore_eukaryotes --ignore_archaea > sample_profile.txt
```

### 2. Create a Sample List
To process multiple samples, create a tab-delimited list file (e.g., `samples.list.txt`) where the first column is the Sample ID and the second is the file path:
```text
Sample_A    /path/to/sample_A_profile.txt
Sample_B    /path/to/sample_B_profile.txt
```

### 3. Generate Abundance Table
Merge the individual profiles into a single table:
```bash
MS-single-to-table -l samples.list.txt -o samples.sp.table
```

### 4. Calculate Distance Matrix
Compute the pairwise distance matrix. By default, DMS uses the MetaPhlAn2 reference tree.

**For MetaPhlAn2 data:**
```bash
MS-comp-taxa-dynamic -T samples.sp.table -o samples.sp.dist
```

**For MetaPhlAn3 data:**
```bash
MS-comp-taxa-dynamic -D M -T samples.sp.table -o samples.sp.dist
```

## Advanced Usage: Customized References
If working with non-standard organisms or custom databases, you can provide your own phylogeny and taxonomy:

1.  **Prepare Reference Files**: You need a Newick format tree (`tree.newick`) and a tabular taxonomy file (`tree.taxonomy`).
2.  **Build DMS Reference**:
    ```bash
    MS-make-ref -i tree.newick -r tree.taxonomy -o custom_tree.dms
    ```
3.  **Run Comparison**:
    ```bash
    MS-comp-taxa-dynamic -D custom_tree.dms -T samples.sp.table -o samples.sp.dist
    ```

## Best Practices
- **Taxonomic Level**: Ensure all input profiles are strictly at the species level (`--tax_lev s` in MetaPhlAn).
- **Memory Management**: While DMS is efficient (requiring ~2GB RAM for typical runs), use the `-p` parameter (if available in your version) or environment variables to manage OpenMP threads for large-scale comparisons.
- **Distance Types**: Use `MS-comp-taxa-dynamic` for the "Dynamic Meta-Storms" algorithm, which better handles unclassified species by placing them at virtual internal nodes. Use `MS-comp-taxa` only if you require the standard, non-dynamic Meta-Storms calculation.

## Reference documentation
- [Dynamic Meta-Storms Overview](./references/github_com_qibebt-bioinfo_dynamic-meta-storms.md)
- [Bioconda dms Package](./references/anaconda_org_channels_bioconda_packages_dms_overview.md)