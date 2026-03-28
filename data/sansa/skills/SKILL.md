---
name: sansa
description: "Sansa is a high-performance tool for the functional and population-based annotation of structural variants. Use when user asks to annotate structural variants against reference databases, map variants to genomic features like genes or exons, identify gene fusion candidates, or mark duplicate variants in multi-sample files."
homepage: https://github.com/dellytools/sansa
---


# sansa

## Overview

Sansa is a high-performance tool designed for the functional and population-based annotation of structural variants. It facilitates the identification of known SVs by comparing query calls against reference databases using flexible breakpoint and size-ratio matching. Additionally, it enables functional prioritization by mapping SVs to genomic features like genes or exons and can be used to identify potential gene fusion candidates based on breakpoint orientation.

## SV Annotation Workflow

To annotate SVs against a population database, use the `annotate` subcommand. This process typically requires a post-processing step to merge the results.

### 1. Run Annotation
Execute the annotation against a VCF database (e.g., gnomAD-SV).
```bash
sansa annotate -d database.vcf.gz input.vcf.gz
```
This generates:
- `anno.bcf`: The annotation database SVs augmented with a unique `INFO/ANNOID`.
- `query.tsv.gz`: The query SVs matched to these `ANNOID` values.

### 2. Extract Database Fields
Use `bcftools` to extract the specific metadata (e.g., ID and Allele Frequency) from the generated BCF, ensuring `INFO/ANNOID` is the first column.
```bash
bcftools query -H -f "%INFO/ANNOID\t%ID\t%INFO/EUR_AF\n" anno.bcf | sed -e 's/^# //' > anno.tsv
```

### 3. Join Results
Sort the query matches and join them with the extracted database metadata.
```bash
join anno.tsv <(zcat query.tsv.gz | sort -k 1b,1) > results.tsv
```

## Feature and Gene Annotation

Sansa can map SVs to nearby genes or specific features using GTF or GFF files.

- **Basic Gene Annotation**:
  `sansa annotate -g features.gtf.gz input.vcf.gz`
- **Specify ID Attribute**: Use `-i` to select the attribute for the output (e.g., `Name`, `gene_id`).
  `sansa annotate -i Name -g features.gff3.gz input.vcf.gz`
- **Exon-level Annotation**: Use `-f` to restrict matching to specific feature types.
  `sansa annotate -f exon -i exon_id -g features.gtf.gz input.vcf.gz`

The output provides two columns (start and end breakpoints) containing the feature name, distance (0 if within the feature), and strand.

## Advanced Matching Parameters

Fine-tune how SVs are matched between the query and the database:

- **Breakpoint Sensitivity**: Adjust `-b` (default 50bp) to change the allowed absolute difference in breakpoint locations.
- **Size Similarity**: Adjust `-r` (default 0.8) to set the minimum size ratio between the smaller and larger SV.
- **Matching Strategy**: Use `-s all` to report all matches instead of just the best one.
- **Unmatched Records**: Use `-m` to include query SVs that did not find a match in the output.
- **Type Agnostic Matching**: Use `-n` to compare SVs regardless of their type (e.g., comparing a DEL to a BND).

## Multi-Sample Operations

- **Mark Duplicates**: Identify and mark duplicate SV sites across multi-sample VCF files.
  `sansa markdup input_multi.vcf.gz`
- **Compare VCFs**: Compare different multi-sample VCF files to identify shared or unique variants.
  `sansa compvcf file1.vcf.gz file2.vcf.gz`

## Expert Tips

- **Gene Fusion Discovery**: When using Delly-called SVs, pay attention to the `INFO/CT` (Connection Type) values. Sansa's gene annotation combined with `CT` orientation (e.g., 3to5 for deletions, 3to3 for inversions) allows for the identification of specific gene fusion candidates.
- **Distance Logic**: In gene annotation output, negative distance values indicate the feature is before the breakpoint, while positive values indicate it is after. A value of 0 indicates the breakpoint falls within the feature.
- **Performance**: For large-scale annotations, ensure your input VCFs are indexed (`.tbi` or `.csi`) to allow for efficient random access.



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Annotate structural variants |
| compvcf | Compare two VCF/BCF files and report differences. |
| markdup | Filter sites for PASS |

## Reference documentation
- [Sansa README](./references/github_com_dellytools_sansa_blob_main_README.md)
- [Sansa Repository Overview](./references/github_com_dellytools_sansa.md)