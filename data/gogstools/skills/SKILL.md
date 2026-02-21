---
name: gogstools
description: gogstools is a specialized suite of bioinformatics utilities designed to manage and refine Official Gene Sets.
homepage: https://github.com/genouest/ogs-tools
---

# gogstools

## Overview
gogstools is a specialized suite of bioinformatics utilities designed to manage and refine Official Gene Sets. It is primarily used to synchronize base automated annotations (e.g., from Maker) with manual curation results (e.g., from Apollo). The tool ensures that gene identifiers are preserved and versioned correctly during merges and provides a pathway for submitting finalized annotations to the European Nucleotide Archive (ENA).

## Installation and Environment
The tool can be installed via Bioconda or pip. Note that `ogs_merge` has specific external dependencies.

```bash
# Recommended: Conda installation
conda install bioconda::gogstools

# Manual setup for ogs_merge (requires specific bedops version)
conda create --name ogsmerger bedops=2.4.39 bedtools cufflinks bcbiogff
pip install gogstools
```

## Merging Annotations with ogs_merge
The `ogs_merge` script replaces base annotations with overlapping manual curation (Apollo) genes while preserving original IDs with version suffixes.

### Basic Command Structure
```bash
ogs_merge [options] <genome.fasta> <ogs_name> <id_regex> <id_syntax> <base.gff> <apollo.gff>
```

### Key Arguments
- **id_regex**: A regex with two capturing groups: (1) the incremental part of the ID, and (2) the version suffix.
  - *Example*: `'GSSPF[GPT]([0-9]{8})[0-9]{3}(\.[0-9]+)?'`
- **id_syntax**: A template string for the gene ID using `{id}` as a placeholder for the incremental part.
  - *Example*: `'GSSPFG{id}001'`

### Common CLI Patterns
- **Standard Versioning**: To merge and increment version suffixes (e.g., `ID.1` to `ID.2`):
  ```bash
  ogs_merge genome.fa OGS_v2.1 "FOO([0-9]{6})(\.[0-9]+)?" "FOO{id}" base.gff apollo.gff
  ```
- **Handling Isoforms**: By default, isoforms use letters (-RA, -RB). Use `--use_numbers_for_isoform` to switch to numeric suffixes (-1, -2).
- **Removing Genes**: Use the `-d` flag with a text file containing mRNA IDs to explicitly delete specific models during the merge.

## ENA Submission with gff2embl
Use `gff2embl` to convert GFF3 annotations into EMBL format for EBI/ENA submission.

```bash
gff2embl -g genome.fasta -p proteins.fasta -s "Species Name" -d "Description" -e email@domain.com -j PROJECT_ID
```

## Expert Tips
- **ID Padding**: By default, numeric IDs are zero-padded. If your naming convention does not use fixed-length padding, use the `--no_id_padding` flag.
- **Regex Validation**: Always test your `id_regex` against your GFF attributes before running a full merge, as "creative" GFF formatting is a common cause of failure.
- **Output Files**: The merge process generates GFF, transcript/CDS/protein FASTA files, and a tabular correspondence file. Check the correspondence file to verify that IDs were mapped as expected.

## Reference documentation
- [GitHub Repository - ogs-tools](./references/github_com_genouest_ogs-tools.md)
- [Bioconda - gogstools Overview](./references/anaconda_org_channels_bioconda_packages_gogstools_overview.md)