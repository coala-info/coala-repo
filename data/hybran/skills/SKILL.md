---
name: hybran
description: Hybran automates prokaryotic genome annotation by combining synteny-based transfer from references with de novo prediction to ensure naming consistency across samples. Use when user asks to annotate genomes, maintain consistent gene naming across multiple isolates, identify gene fusions or pseudogenes, or standardize and compare existing annotations.
homepage: https://lpcdrp.gitlab.io/hybran
metadata:
  docker_image: "quay.io/biocontainers/hybran:1.10--pyhdfd78af_0"
---

# hybran

## Overview

The `hybran` skill enables the automated annotation of prokaryotic genomes by combining the strengths of synteny-based transfer and de novo prediction. It is particularly effective for maintaining consistency across multiple related samples. By using this skill, you can ensure that homologous genes across different isolates receive unified naming conventions, while also benefiting from advanced post-processing that identifies gene fusions, fissions, and pseudogenes.

## Core Command Patterns

### Basic Annotation
To annotate one or more genomes using one or more reference GenBank files:

```bash
hybran --genomes <input.fasta> --references <ref.gbk> --output ./results --organism "Genus species strain" --nproc 8
```

### Annotating Multiple Genomes
For consistency across a dataset, annotate all genomes simultaneously. This ensures that "HYBRA" generic names for unknown genes are assigned consistently across the entire cohort.

```bash
# Using a directory of FASTAs
hybran --genomes /path/to/fastas/ --references reference.gbk --output ./cohort_results
```

### Incremental Annotation
If you have already run a hybran pipeline and want to add a new sample while maintaining the existing naming scheme:

```bash
# Create a list of previous results to use as additional references
ls $PWD/old_results/*.gbk $PWD/primary_ref.gbk > refs.fofn
hybran --genomes new_sample.fasta --references refs.fofn --output ./new_results
```

## Auxiliary Utilities

### Standardizing Names
Hybran uses generic placeholders (e.g., `HYBRA0001`) for unnamed or duplicated genes to facilitate matching. Before submitting to public databases, use `standardize` to revert these to original reference names or ab initio predictions.

```bash
# Run within a hybran output directory
hybran standardize -o ./standardized_annotations
```

### Comparing Annotations
To evaluate the differences between two different annotation versions of the same genome (e.g., Hybran vs. a standard Prokka run):

```bash
hybran compare annotation1.gbk annotation2.gbk
```

### Synergizing (Experimental)
To correct missing annotations or inconsistent naming based on synteny discordance across a set of genomes:

```bash
hybran synergize --input_dir ./hybran_output_folder
```

## Expert Tips & Best Practices

- **Reference Selection**: The accuracy of the transfer depends heavily on the reference. Using multiple references reduces ambiguity and improves the "lift-over" rate.
- **Locus Tag Consistency**: If re-annotating a reference genome to find novel ORFs while keeping original tags, name your FASTA file with the desired prefix and use `--ratt-transfer-type Assembly`.
- **Memory Management**: When using a very large number of reference annotations, if you encounter `mummer` errors, it may indicate a need for a 64-bit recompile of the underlying MUMmer dependency.
- **Output Interpretation**: 
    - `fusion_report.tsv`: Check this for chimeric genes caused by frameshifts or non-stop mutations.
    - `pseudoscan_report.tsv`: Review this to understand why specific genes were flagged as pseudogenes (e.g., internal stops, invalid reading frames).
    - `unifications.tsv`: Use this to see how duplicated reference genes were grouped under a single name.

## Reference documentation

- [Hybran Execution and Output](./references/lpcdrp_gitlab_io_hybran.md)
- [Commands and Subcommands](./references/lpcdrp_gitlab_io_hybran_cmds.md)
- [Pseudoscan Criteria](./references/lpcdrp_gitlab_io_hybran_pseudoscan.md)
- [Special Considerations for Large Datasets](./references/lpcdrp_gitlab_io_hybran_faq.md)