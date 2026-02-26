---
name: flams
description: FLAMS identifies conserved post-translational modification sites by aligning query proteins against a compendium of known modification data. Use when user asks to search for specific protein modifications at a given residue, identify conserved lysine acylations across species, or batch process protein sequences to verify known modification sites.
homepage: https://github.com/hannelorelongin/FLAMS
---


# flams

## Overview

FLAMS (Find Lysine Acylations & other Modification Sites) is a bioinformatics utility that performs position-based searches to identify conserved post-translational modifications. By aligning a query protein against a compendium of known modification sites, it helps researchers determine if a specific residue is a known target for acylation or other PTMs in related sequences. It is particularly useful for translating findings between species and verifying experimental results against established databases like CPLM v.4, dbPTM, and SCOP3P.

## CLI Usage and Patterns

The primary command for the tool is `FLAMS`. It requires an input source (ID, file, or batch) and a residue position.

### Basic Queries
Search for a specific modification using a UniProt ID:
```bash
FLAMS --id A0QQ22 -p 537 -m acetylation -o results.tsv
```

Search using a local FASTA file (must contain exactly one protein):
```bash
FLAMS --in sequence.fa -p 66 -m acetylation
```

### Batch Processing
For multiple queries, use a tab-separated file where the first column is the UniProt ID and the second is the position:
```bash
FLAMS --batch queries.tsv -o batch_results
```
*Note: This generates individual files named `batch_results_$ID_$POS.tsv`.*

### Modification Filtering
FLAMS supports specific PTM types or aggregate categories:
- **Specific**: `acetylation`, `malonylation`, `succinylation`
- **Aggregates**: `K-All` (all Lysine modifications), `CPLM-Acylations`, `CPLM-All`
- **Multiple**: Pass a space-separated list: `-m acetylation malonylation`

## Expert Tips and Best Practices

- **Error Ranges**: If the exact position of a modification is uncertain or might shift in homologous proteins, use the `--range` argument (e.g., `--range 2`) to search for modifications in the immediate vicinity of the target residue.
- **BLAST Optimization**: 
    - Use `-t <threads>` to enable multithreading for faster database searches.
    - Adjust `-e <evalue>` (default 0.01) to control the stringency of the homology search. Lower values (e.g., `1e-5`) ensure higher confidence in the conservation of the site.
- **Naming Conventions**: PTM names must be provided in lowercase. Replace any spaces in a PTM name with underscores (e.g., `o_glcnac`).
- **Data Management**: Use the `-d` flag to specify a custom directory for intermediate UniProt sequence files if you want to avoid cluttering your working directory or to reuse cached data.
- **Output Interpretation**: The resulting `.tsv` includes a `$AA window` column showing five amino acids before and after the site, which is critical for manually verifying the local sequence motif conservation.

## Reference documentation
- [FLAMS GitHub Repository](./references/github_com_hannelorelongin_FLAMS.md)
- [Bioconda FLAMS Overview](./references/anaconda_org_channels_bioconda_packages_flams_overview.md)