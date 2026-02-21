---
name: taranys
description: Taranys is a specialized computational pipeline for high-resolution bacterial typing.
homepage: https://github.com/BU-ISCIII/taranys
---

# taranys

## Overview

Taranys is a specialized computational pipeline for high-resolution bacterial typing. It transforms raw genomic assemblies into interpretable allelic profiles by identifying matches against defined core or whole-genome MLST schemas. The tool is designed for the entire workflow of gene-by-gene analysis: from cleaning and validating a new schema to calculating the genetic distances between isolates in an outbreak. It relies on established bioinformatics tools like BLASTn, Prokka, and Mash to ensure accuracy in allele identification and clustering.

## Schema Validation and Cleaning

Before typing samples, use `analyze-schema` to ensure the loci in your schema are high quality. This step identifies duplicate alleles, partial sequences, and non-coding regions (non-CDS).

### Basic quality check
To generate statistics without modifying the schema:
```bash
taranys analyze-schema -i ./schema_dir -o ./analysis_output --output-allele-annot ./annotations
```

### Schema optimization
To create a "clean" version of a schema by removing problematic sequences:
```bash
taranys analyze-schema \
  -i ./schema_dir \
  -o ./cleaned_schema \
  --remove-subsets \
  --remove-duplicated \
  --remove-no-cds \
  --cpus 8
```

## Representative Allele Selection

Taranys uses the Leiden algorithm and Mash distances to find representative alleles for each locus. This reduces the search space and improves the efficiency of the subsequent allele calling step.

### Standard reference selection
```bash
taranys reference-alleles \
  --schema ./cleaned_schema \
  --output ./ref_alleles_out \
  --eval-cluster \
  --cpus 8
```

### Tuning clustering sensitivity
If the schema is highly diverse, adjust the Mash parameters and clustering resolution:
- Increase `--cluster-resolution` (default 0.75) for finer clusters.
- Adjust `-k` (k-mer size) or `-S` (sketch size) for Mash-based distance estimation.

## Allele Calling and Distance Estimation

The core functionality involves identifying alleles in your sample assemblies and calculating distances.

### Allele Calling
This module identifies the loci present in analyzed samples using the reference alleles as queries.
```bash
taranys allele-calling \
  --query ./ref_alleles_out/references.fasta \
  --samples ./assemblies_dir \
  --output ./typing_results \
  --cpus 8
```

### Distance Matrix Construction
Once alleles are called, generate a distance matrix to visualize relationships between isolates.
```bash
taranys distance-matrix \
  -i ./typing_results/results.tsv \
  -o ./distance_output
```

## Expert Tips

- **CDS Verification**: Always use `--remove-no-cds` when working with a new or uncurated schema to prevent pseudogenes or non-coding fragments from skewing the allelic profile.
- **Resource Management**: Taranys is computationally intensive during the BLASTn and clustering phases. Always specify `--cpus` to match your environment's capabilities.
- **Prokka Integration**: When using `analyze-schema`, providing `--genus` and `--species` allows the tool to use genus-specific BLAST databases for better functional annotation of the loci.
- **Output Interpretation**: Check the `Summary file` and `Paralogs file` in the output directory to identify samples with low coverage or loci that may be present in multiple copies, which can complicate outbreak interpretation.

## Reference documentation
- [taranys GitHub Repository](./references/github_com_BU-ISCIII_taranys.md)
- [taranys Wiki](./references/github_com_BU-ISCIII_taranys_wiki.md)