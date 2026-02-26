---
name: woltka
description: Woltka classifies meta-omic sequence alignment results into feature tables. Use when user asks to generate OGU tables, perform taxonomic profiling, perform functional profiling, create stratified profiles, or collapse, normalize, filter, or merge tables.
homepage: https://github.com/qiyunzhu/woltka
---


# woltka

## Overview
Woltka is a versatile meta-omic data classifier that transforms sequence alignment results into feature tables (profiles). It acts as a middle-layer processor: it does not perform the alignment itself, but rather interprets the mappings of reads against reference sequences to infer their placement within hierarchical classification systems (like NCBI taxonomy or GO/UniRef functional hierarchies). 

Use this skill when you need to:
1. Generate Operational Genomic Unit (OGU) tables from metagenomic data.
2. Perform taxonomic profiling at specific ranks (phylum, genus, species).
3. Execute "coord-match" functional profiling, which assigns reads to genes based on genomic coordinates rather than direct gene-alignment.
4. Create stratified profiles that combine taxonomic and functional information (e.g., "which genus is performing this function?").

## Core CLI Patterns

### 1. OGU Table Generation
The simplest workflow, generating a table of abundances for each reference genome.
```bash
woltka classify -i path/to/alignments -o ogu_table.biom
```

### 2. Taxonomic Profiling
To classify at specific ranks, provide NCBI taxonomy files (`nodes.dmp`, `names.dmp`) and a mapping of genome IDs to TaxIDs.
```bash
woltka classify \
  --input align_dir/ \
  --map taxonomy/taxid.map \
  --nodes taxonomy/nodes.dmp \
  --names taxonomy/names.dmp \
  --rank phylum,genus,species \
  --output output_dir/
```

### 3. Functional Profiling (Coord-match)
This unique feature matches reads to genes using their coordinates on the genome. It requires a coordinates file (`coords.txt`).
```bash
woltka classify \
  --input align_dir/ \
  --coords function/coords.txt \
  --map function/uniref.map \
  --rank uniref \
  --output uniref_table.biom
```

### 4. Stratified Profiling
To see "who is doing what," perform a two-step classification.
1. **Generate a taxonomy map:**
   ```bash
   woltka classify -i align_dir/ --map taxid.map --rank genus --outmap genus_mappings/
   ```
2. **Apply stratification:**
   ```bash
   woltka classify -i align_dir/ --stratify genus_mappings/ --coords coords.txt --rank function --output stratified_table.biom
   ```

## Table Utilities
Woltka includes a `tools` suite for post-processing BIOM tables:
- **Collapse:** `woltka tools collapse -i table.biom -m map.txt -o collapsed.biom`
- **Normalize:** `woltka tools normalize -i table.biom -o normalized.biom`
- **Filter:** `woltka tools filter -i table.biom --min-count 10 -o filtered.biom`
- **Merge:** `woltka tools merge -i table1.biom -i table2.biom -o merged.biom`

## Expert Tips & Best Practices
- **Input Flexibility:** Woltka automatically detects and handles compressed alignment files (.gz, .bz2, .xz). You can point `-i` to a single file or a directory of files.
- **Memory Efficiency:** For very large datasets, Woltka is designed to be computationally efficient. If processing speed is a concern, ensure you are using the latest version (0.1.7+) which includes Numba-accelerated components.
- **Consistency:** Use the "coord-match" algorithm to ensure that your taxonomic and functional profiles are derived from the exact same genomic context, reducing discrepancies between the two analyses.
- **QIIME 2 Integration:** Woltka outputs BIOM files by default, which are natively compatible with QIIME 2. If you need plain text, use `--output-format tsv`.
- **Naming:** Use the `--name-as-id` flag when you want the output table to feature actual taxon names (e.g., "Firmicutes") instead of numeric TaxIDs.

## Reference documentation
- [Woltka GitHub Repository](./references/github_com_qiyunzhu_woltka.md)
- [Woltka Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_woltka_overview.md)