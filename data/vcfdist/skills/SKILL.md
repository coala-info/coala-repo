---
name: vcfdist
description: vcfdist is a benchmarking tool for evaluating the accuracy of genomic variant calls. Use when user asks to evaluate genomic variant calls, benchmark variant callers, assess variant call accuracy, or identify phasing errors.
homepage: https://github.com/TimD1/vcfdist
---


# vcfdist

## Overview

vcfdist is a specialized benchmarking tool designed to provide accurate precision-recall metrics for genomic variants. Unlike traditional comparison tools that may struggle with complex INDELs or structural variants (SVs), vcfdist uses a distance-based alignment approach to standardize variant representations. It is particularly effective for evaluating phased calls, as it can identify and report specific phasing errors such as "flip" and "switch" errors.

## Core Usage Pattern

The basic command structure requires a query VCF, a truth VCF, and the corresponding reference genome FASTA file.

```bash
vcfdist \
  query.vcf \
  truth.vcf.gz \
  reference.fa \
  -b evaluation_regions.bed \
  -p results_prefix/ \
  -v 0
```

### Positional Arguments
1. **Query VCF**: The variant calls being evaluated.
2. **Truth VCF**: The gold-standard reference calls (should be phased).
3. **Reference FASTA**: The reference genome used for calling.

### Common Options
- `-b, --bed`: Restrict evaluation to specific genomic regions (highly recommended for standard benchmarks like NIST/GIAB).
- `-p, --prefix`: Directory and filename prefix for output files.
- `-v, --verbosity`: Control output detail (0 for summary only, higher values for intermediate results).
- `--max-supercluster-size`: Limits the size of variant clusters to prevent memory exhaustion in high-density regions.
- `--max-ram`: Sets a limit on memory usage (e.g., `16G`).

## Best Practices and Expert Tips

### Phasing Requirements
vcfdist is built for phased data. Ensure your query and truth VCFs contain phasing information (typically in the `GT` field using `|` instead of `/`, or via `PS` tags). If phasing is missing, the tool may still run but will not provide accurate flip/switch error analysis.

### Handling Large Variants
While vcfdist supports SVs up to 10Kb, performance can degrade in extremely complex regions. If the tool hangs or crashes on a specific locus, use `--max-supercluster-size` to force the tool to break down large clusters into manageable pieces.

### Input Normalization
vcfdist performs internal standardization of variant representations. You generally do not need to pre-process VCFs with `bcftools norm` or `vt`, as vcfdist's distance-based alignment handles different representations of the same biological variant automatically.

### Interpreting Results
The summary output provides two main rows for each variant type:
- **NONE**: Standard precision/recall metrics.
- **BEST**: Metrics calculated after selecting the optimal alignment/representation.
For most benchmarking reports, the **BEST** row is the more accurate reflection of the caller's performance.

## Reference documentation
- [vcfdist GitHub Repository](./references/github_com_TimD1_vcfdist.md)
- [vcfdist Wiki Home](./references/github_com_TimD1_vcfdist_wiki.md)