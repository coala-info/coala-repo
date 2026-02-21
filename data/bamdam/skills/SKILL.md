---
name: bamdam
description: `bamdam` is a specialized toolkit designed for the post-processing and authentication phase of ancient metagenomics.
homepage: https://github.com/bdesanctis/bamdam
---

# bamdam

## Overview
`bamdam` is a specialized toolkit designed for the post-processing and authentication phase of ancient metagenomics. It bridges the gap between raw mapping results and taxonomic verification. By processing read-sorted BAM files alongside LCA assignments (specifically from `ngsLCA`), it allows researchers to reduce massive datasets into manageable, informative subsets. Its primary value lies in its ability to calculate specific ancient DNA damage patterns and complexity metrics, helping to distinguish true ancient signals from modern contaminants or mapping noise.

## Core Workflow

The standard `bamdam` workflow follows a sequential path from raw mapping output to authenticated taxonomic tables.

### 1. Data Reduction with `shrink`
Use `shrink` to remove irrelevant alignments (e.g., reads assigned to high-level nodes like "Viridiplantae") and reduce file size.

```bash
bamdam shrink --in_bam input.bam --in_lca input.lca --out_bam shrunken.bam --out_lca shrunken.lca --stranded ds
```

**Expert Tips for `shrink`:**
- **Sorting Requirement**: Input BAM files must be sorted by read name (`samtools sort -n`).
- **Library Type**: You must specify `--stranded ss` (single-stranded) or `--stranded ds` (double-stranded).
- **Filtering**: Use `--upto family` (default) to keep nodes only up to the family level, or adjust to `genus` or `species` for higher specificity.
- **PMD Scores**: Adding `--annotate_pmd` will include Post-Mortem Damage scores in the `DS:Z` field of the BAM, though this significantly increases processing time.

### 2. Metric Calculation with `compute`
Generate a comprehensive TSV table containing authentication metrics for every taxonomic node.

```bash
bamdam compute --in_bam shrunken.bam --in_lca shrunken.lca --out_tsv metrics.txt --out_subs substitutions.txt --stranded ds
```

**Key Metrics Produced:**
- **Ancient DNA Damage**: 5' C-to-T frequency.
- **K-mer Duplicity**: Helps identify PCR over-amplification.
- **Mean Read Complexity**: Useful for filtering low-complexity noise.

### 3. Taxon Extraction and Visualization
Once a taxon of interest is identified in the `compute` output, use `extract` and `plotdamage` to validate it.

**Extract specific reads:**
```bash
bamdam extract --in_bam shrunken.bam --in_lca shrunken.lca --taxid 1234 --out_bam taxon_1234.bam
```

**Generate damage plots:**
```bash
bamdam plotdamage --in_subs substitutions.txt --taxid 1234 --out_plot damage_plot.pdf
```

## Common CLI Patterns

| Task | Command Pattern |
| :--- | :--- |
| **Filter by count** | `bamdam shrink ... --mincount 10` (Removes nodes with <10 reads) |
| **Filter by similarity** | `bamdam shrink ... --minsim 0.95` (Only keeps high-identity alignments) |
| **Exclude Taxa** | `bamdam shrink ... --exclude_tax 9606` (Exclude specific TaxIDs like Human) |
| **Multi-sample Matrix** | `bamdam combine --in_tsvs sample1.txt sample2.txt --out_tsv combined_matrix.txt` |
| **Krona Visualization** | `bamdam krona --in_tsv metrics.txt --out_xml krona.xml` |

## Best Practices
- **Memory Management**: `bamdam` processes files line-by-line. It typically requires <8GB of RAM even for large BAM files, making it suitable for standard laptops.
- **Pre-filtering**: For very large datasets, you can manually grep the LCA file (e.g., `grep "Eukaryota"` ) before running `shrink` to accelerate the process.
- **Authentication Thresholds**: There are no universal "correct" thresholds for aDNA. Use the `compute` output to compare damage patterns across different taxa within the same sample to establish a baseline for authenticity.

## Reference documentation
- [bamdam GitHub Repository](./references/github_com_bdesanctis_bamdam.md)
- [bamdam Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bamdam_overview.md)