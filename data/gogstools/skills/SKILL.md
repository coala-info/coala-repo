---
name: gogstools
description: gogstools is a suite of utilities designed to manage genome annotation lifecycles by merging curated gene models and preparing database submissions. Use when user asks to merge gene sets into an official gene set, update gene models from Apollo, manage gene ID versioning, or convert GFF3 files to EMBL format for ENA submission.
homepage: https://github.com/genouest/ogs-tools
metadata:
  docker_image: "quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0"
---

# gogstools

## Overview

gogstools is a specialized suite of utilities designed to manage the lifecycle of genome annotations. It facilitates the transition from automated gene prediction (e.g., Maker) to manual curation (e.g., Apollo) and final database submission. The primary workflow involves merging curated gene models into a base annotation while maintaining consistent ID versioning and generating the necessary formats for ENA/EBI submission.

## Merging Gene Sets with ogs_merge

The `ogs_merge` script is the core tool for updating an Official Gene Set. It replaces base annotation features with overlapping curated features from Apollo.

### Basic Command Structure
```bash
ogs_merge [options] <genome.fasta> <ogs_name> <id_regex> <id_syntax> <base_gff> <apollo_gff>
```

### ID Configuration Patterns
The tool relies on regex and syntax strings to manage gene identifiers:
- **id_regex**: Use a regex with capturing groups. Group 1 should be the incremental part of the ID, and Group 2 should be the version suffix.
  - Example: `'FOOBAR([0-9]{6})(\.[0-9]+)?'`
- **id_syntax**: Define how the new ID should be constructed using the `{id}` placeholder.
  - Example: `'FOOBAR{id}'`

### Handling Different ID Systems
- **Default (Letters for isoforms)**: Uses `-RA`, `-RB` suffixes.
- **Numeric Isoforms**: Use `--use_numbers_for_isoform` and `--isoform_prefix "-"`.
- **No Padding**: Use `--no_id_padding` if your IDs do not require leading zeros to reach a fixed length.

### Advanced Merging Options
- **Deletion**: Provide a text file of mRNA IDs to remove using `-d <deleted_list.txt>`.
- **Previous Version**: If the current base GFF differs from the previous OGS version, specify the previous version with `-p <previous.gff>` to ensure correct version incrementing.

## Preparing Submissions with gff2embl

Use `gff2embl` to convert your GFF3 annotations and genome fasta into the EMBL format required by ENA.

### Required Parameters
- `-g`: Genome fasta file.
- `-p`: Protein fasta file.
- `-s`: Species name (e.g., "Drosophila melanogaster").
- `-d`: Project description.
- `-e`: Submitter email.
- `-j`: Project ID.

## Best Practices and Troubleshooting

- **Dependency Management**: Ensure `bedops` is pinned to version `2.4.39`. Version `2.4.40` is known to break `gff2bed` output compatibility required by gogstools.
- **GFF Compatibility**: The tools are sensitive to GFF3 formatting. Ensure your Apollo export is valid GFF3.
- **Output Files**: `ogs_merge` produces several files. Always check the tabular correspondence file to verify that gene IDs were mapped and versioned as expected.
- **Regex Testing**: Always validate your `id_regex` against your GFF IDs before running a full merge to prevent malformed identifiers in the output.



## Subcommands

| Command | Description |
|---------|-------------|
| gff2embl | Convert GFF3 to EMBL format for ENA submission. |
| ogs_merge | Merges two GFF files to create a new OGS annotation. |

## Reference documentation
- [OGS Tools README](./references/github_com_genouest_ogs-tools_blob_master_README.md)
- [Gogstools Overview](./references/anaconda_org_channels_bioconda_packages_gogstools_overview.md)