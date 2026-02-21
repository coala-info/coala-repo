---
name: feature_merge
description: `feature_merge` is a specialized utility for processing genomic annotation files (GFF or GTF).
homepage: https://github.com/brinkmanlab/feature_merge
---

# feature_merge

## Overview
`feature_merge` is a specialized utility for processing genomic annotation files (GFF or GTF). It allows for the intelligent consolidation of features based on their types (using SOFA sequence ontology terms), spatial proximity, and strand orientation. It is particularly useful for merging multiple annotation sources into a single coherent file while providing granular control over how ID collisions and overlapping coordinates are handled.

## Command Line Usage

The basic syntax for the tool is:
`feature_merge [options] <input1.gff> [<input2.gff> ...]`

### Core Options
- `-f <type1,type2>`: Specify feature types to merge. Accepts SOFA terms, accessions, "ALL", or "NONE". This flag can be used multiple times to define different merge groups.
- `-m <strategy>`: Strategy for handling ID collisions between files:
    - `append`: Assigns a unique, autoincremented primary key (Default).
    - `merge`: Merges attributes of all features sharing the same primary key.
    - `replace`: Keeps only the last duplicate encountered.
    - `skip`: Ignores duplicates and emits a warning.
    - `error`: Raises an exception on collision.
- `-t <distance>`: Set a threshold distance (in base pairs) between features to trigger a merge.
- `-x`: Strict mode; only merge features with identical coordinates.
- `-e`: Exclude the original component features from the output, leaving only the resulting merged feature.

### Handling Strands and Sequences
- `-i`: Ignore strand; features will be merged regardless of whether they are on the positive or negative strand.
- `-s`: Ignore sequence ID; features will be merged regardless of which chromosome or scaffold they belong to.

## Common Patterns and Tips

### Merging Specific Feature Types
To merge only exons and CDS features while leaving others untouched:
```bash
feature_merge -f exon,CDS input.gff > merged.gff
```

### Consolidating Overlapping Annotations
If you have multiple GFF files from different predictors and want to merge all overlapping features regardless of strand:
```bash
feature_merge -f ALL -i input1.gff input2.gff > combined.gff
```

### Cleaning Up Redundant Features
To output only the merged intervals and remove the original sub-features that were used to create them:
```bash
feature_merge -f ALL -e input.gff > simplified.gff
```

### Managing ID Collisions
When combining files where you expect overlapping IDs but want to keep the attributes from both sources:
```bash
feature_merge -m merge input1.gff input2.gff > merged_attributes.gff
```

## Reference documentation
- [GitHub Repository - brinkmanlab/feature_merge](./references/github_com_brinkmanlab_feature_merge.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_feature_merge_overview.md)