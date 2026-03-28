---
name: woltka
description: Woltka transforms sequence alignments into taxonomic and functional feature abundance tables. Use when user asks to generate OGU tables, perform taxonomic profiling, conduct functional profiling through coordinate matching, or normalize and collapse feature tables.
homepage: https://github.com/qiyunzhu/woltka
---


# woltka

## Overview

Woltka is a versatile bioinformatics classifier designed to transform sequence alignments into feature abundance tables. It sits between the alignment step (e.g., Bowtie2, Minimap2) and the statistical analysis step. By mapping sequencing reads to reference genomes or genes and applying hierarchical classification systems, Woltka allows researchers to determine the taxonomic structure and functional potential of microbial communities. It is particularly optimized for use with the Web of Life (WoL) reference database but supports any custom classification system.

## Core Workflows

### 1. Generating OGU Tables
The simplest workflow generates an Operational Genomic Unit (OGU) table, which provides the highest possible resolution by counting reads mapped to specific reference genomes.

```bash
woltka classify -i path/to/alignments -o table.biom
```

### 2. Taxonomic Profiling
To generate tables at specific taxonomic ranks (e.g., genus, species), provide a mapping file and a nodes file (hierarchy).

```bash
woltka classify -i align_dir -m taxonomy/nodes.dmp -m taxonomy/names.dmp --rank species -o species_table.tsv
```

### 3. Functional Profiling (Coord-Match)
When alignments are made against genomes, Woltka can "match coordinates" to functional annotations (ORFs/genes) without requiring a separate alignment against a gene database.

```bash
woltka classify -i align_dir -c genes.coords -o function_table.biom
```

## Table Utilities

### Collapsing Tables
Aggregate an existing table to a higher level (e.g., from genes to metabolic pathways).
```bash
woltka collapse -i gene_table.biom -m gene_to_pathway.map -o pathway_table.biom
```

### Normalization
Convert raw counts into relative abundances or normalize by gene length (RPK).
```bash
# Fractional normalization
woltka normalize -i table.biom -o normalized_table.biom

# Length-based normalization (RPK)
woltka normalize -i table.biom -c gene_coords.txt -o rpk_table.biom
```

### Filtering and Merging
*   **Filter**: Remove low-abundance features.
    `woltka filter -i table.biom -p 0.01 -o filtered_table.biom` (removes features < 1% per sample).
*   **Merge**: Combine multiple feature tables.
    `woltka merge -i table1.biom -i table2.biom -o merged_table.biom`

## Expert Tips and Best Practices

*   **Input Optimization**: For Bowtie2 alignments, use the "SHOGUN protocol" parameters to ensure optimal sensitivity for metagenomics:
    `-k 16 --np 1 --mp "1,1" --rdg "0,1" --rfg "0,1" --score-min "L,0,-0.05"`
*   **Disk Space**: Woltka can read compressed alignment files (e.g., `.sam.gz`, `.sam.xz`) directly. Use the `--no-head` and `--no-unal` flags in your aligner to further reduce input file size.
*   **Memory Management**: If processing extremely large datasets, use the `--chunk` parameter to control the number of sequences processed at once, which helps manage RAM usage.
*   **Output Formats**: While BIOM is the default and recommended for QIIME 2, you can output plain TSV by specifying a `.tsv` extension in the `-o` parameter.
*   **Excluding Sequences**: Use the `-x` or `--exclude` flag to filter out reads mapped to specific references, such as host genomes (human, mouse) or spike-ins.



## Subcommands

| Command | Description |
|---------|-------------|
| collapse | Collapse a profile by feature mapping and/or hierarchy. |
| woltka filter | Filter a profile by per-sample abundance. |
| woltka normalize | Normalize a profile to fractions and/or by feature sizes. |
| woltka_coverage | Calculate per-sample coverage of feature groups. |
| woltka_merge | Merge multiple profiles into one profile. |

## Reference documentation
- [Woltka Main README](./references/github_com_qiyunzhu_woltka_blob_main_README.md)
- [Sequence Alignment Guidelines](./references/github_com_qiyunzhu_woltka_blob_main_doc_align.md)
- [OGU Analysis Tutorial](./references/github_com_qiyunzhu_woltka_blob_main_doc_ogu.md)
- [Classification Methods](./references/github_com_qiyunzhu_woltka_blob_main_doc_classify.md)
- [Functional Profiling (Ordinal Mapper)](./references/github_com_qiyunzhu_woltka_blob_main_doc_ordinal.md)