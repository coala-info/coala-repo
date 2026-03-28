---
name: kaptive
description: Kaptive identifies and characterizes surface polysaccharide gene clusters from bacterial genome assemblies to predict phenotypes like K-type or O-type. Use when user asks to identify polysaccharide loci, serotype bacterial isolates, extract features from locus databases, or convert typing results into summary tables.
homepage: https://kaptive.readthedocs.io/en/latest
---

# kaptive

## Overview
Kaptive is a specialized bioinformatic tool designed to identify and characterize surface polysaccharide gene clusters (loci) from bacterial genome assemblies. It is primarily used for "typing" or serotyping isolates of *Klebsiella pneumoniae*, *Acinetobacter baumannii*, and *Vibrio parahaemolyticus*. By comparing assembly sequences against curated reference databases of known loci, Kaptive provides a high-confidence prediction of the polysaccharide phenotype (e.g., K-type or O-type) and identifies potential gene truncations or novel variations.

## CLI Usage Patterns

### Primary Typing (Assembly Mode)
The most common use case is running Kaptive against one or more genome assemblies (FASTA format) using a specific reference database (GenBank format).

```bash
# Basic typing of a Klebsiella assembly
kaptive assembly -a assembly.fasta -k Klebsiella_k_locus_primary.gbk -o output_directory

# Typing multiple assemblies at once
kaptive assembly -a *.fasta -k Klebsiella_k_locus_primary.gbk -o results/
```

### Database Feature Extraction
Use the `extract` mode to pull specific features or sequences from a Kaptive GenBank database.

```bash
# Extract all protein sequences from a database
kaptive extract -k database.gbk -f protein_fasta -o proteins.faa

# Extract locus sequences in FASTA format
kaptive extract -k database.gbk -f locus_fasta -o loci.fasta
```

### Result Conversion
Kaptive results can be converted into different formats for downstream analysis.

```bash
# Convert Kaptive JSON results to a summary table
kaptive convert -i results.json -f table -o summary.tsv
```

## Expert Tips and Best Practices

### Database Selection
*   **Locus Labels**: Kaptive identifies the locus name based on the `note` qualifier in the GenBank `source` feature. If your database uses a non-standard label, use the `--locus_label` flag to specify it (e.g., `--locus_label "K locus:"`).
*   **Phenotype Logic**: Kaptive 3 uses `.logic` files (tab-separated) to handle complex phenotype predictions, such as identifying "Capsule null" phenotypes when core genes like *wcaJ* are truncated. Ensure the `.logic` file has the same prefix as your `.gbk` database and is in the same directory.

### Interpreting Results
*   **Coverage and Identity**: Pay close attention to the "Locus coverage" and "Average protein identity" columns. High coverage (>95%) and high identity (>95%) typically indicate a strong match to a known reference.
*   **Truncations**: If Kaptive reports a "truncated" gene, it means the assembly sequence is significantly shorter than the reference. This often indicates a non-functional locus or a "null" phenotype.
*   **Extra Genes**: The presence of "extra" genes (genes in the assembly not found in the reference locus) may suggest a novel variant or an insertion sequence (IS) within the locus.

### Performance Optimization
*   **Parallelization**: For large datasets, Kaptive supports multi-threading. Use the `-t` or `--threads` flag to speed up the alignment process.
*   **Search Sensitivity**: If you are working with highly divergent sequences, you can adjust the alignment sensitivity parameters, though the default settings are optimized for the supported species.



## Subcommands

| Command | Description |
|---------|-------------|
| kaptive | In silico serotyping |
| kaptive assembly | In silico serotyping of assemblies |
| kaptive convert | Convert Kaptive results into different formats |
| kaptive extract | Extract entries from a Kaptive database |

## Reference documentation
- [Kaptive README](./references/github_com_klebgenomics_Kaptive_blob_master_README.md)
- [Database Documentation](./references/github_com_klebgenomics_Kaptive_blob_master_docs_Databases.md)
- [Kaptive Usage Guide](./references/kaptive_readthedocs_io_en_latest_Usage.html.md)