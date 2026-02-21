---
name: core-snp-filter
description: `core-snp-filter` is a high-performance utility for refining DNA pseudo-alignments.
homepage: https://github.com/rrwick/Core-SNP-filter
---

# core-snp-filter

## Overview
`core-snp-filter` is a high-performance utility for refining DNA pseudo-alignments. It allows for the flexible creation of core SNP alignments by filtering out sites (columns) that are either invariant or contain too many gaps/ambiguous bases. While tools like `snippy-core` often provide a binary choice between "all sites" and "100% conserved sites," `core-snp-filter` allows for a sliding scale of conservation (e.g., 95% core), making it ideal for datasets with varying quality or missing data.

## Command Line Usage

The primary executable is `coresnpfilter`. It requires a literal file path as input and outputs the filtered FASTA to `stdout`.

### Common Patterns

**1. Extract all variant sites (Standard SNP alignment)**
Removes any site where there is only one type of unambiguous base (A, C, G, T).
```bash
coresnpfilter --exclude_invariant input.aln > filtered.aln
```

**2. Create a strict core SNP alignment**
Removes invariant sites AND any site containing a gap or ambiguous base (N).
```bash
coresnpfilter -e -c 1.0 input.aln > filtered.aln
```

**3. Create a relaxed core alignment (95% threshold)**
Includes sites where at least 95% of the sequences have an unambiguous base.
```bash
coresnpfilter -e -c 0.95 input.aln > filtered.aln
```

**4. Generate constant site counts for IQ-TREE**
Use this to calculate the number of invariant A, C, G, and T sites for the `-fconst` parameter in IQ-TREE.
```bash
coresnpfilter --invariant_counts input.aln
```

### Key Options
- `-e, --exclude_invariant`: Removes sites where the number of unique unambiguous bases is ≤ 1.
- `-c, --core <0.0-1.0>`: Sets the minimum fraction of sequences that must contain an unambiguous base for the site to be kept.
- `-t, --table <FILE>`: Saves a TSV file containing detailed information for every site in the alignment.

## Expert Tips and Constraints

- **Input Requirements**: The tool **cannot** accept input via `stdin` or process substitution (e.g., `<(cmd)`). You must provide a path to an actual file on disk because the tool reads the input multiple times to remain memory-efficient.
- **DNA Only**: This tool is strictly for DNA alignments. Do not use it for protein sequences.
- **Memory Efficiency**: It is highly optimized for large datasets. Even with 5000+ sequences and 25GB+ files, it typically uses less than 100MB of RAM.
- **Ambiguity Handling**: Characters like `N`, `X`, and `-` (gaps) are all treated as ambiguous/non-bases. They do not count toward the "unambiguous base" count used for the core fraction or invariance checks.
- **Gzip Support**: The tool natively handles gzipped input (`.gz`). To save space on output, pipe the result to gzip:
  ```bash
  coresnpfilter -e -c 0.95 input.aln.gz | gzip > output.aln.gz
  ```

## Reference documentation
- [GitHub Repository: rrwick/Core-SNP-filter](./references/github_com_rrwick_Core-SNP-filter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_core-snp-filter_overview.md)