---
name: vcfx
description: VCFX is a high-performance suite of modular C++ tools designed for genomic variant analysis.
homepage: https://github.com/ieeta-pt/VCFX
---

# vcfx

## Overview

VCFX is a high-performance suite of modular C++ tools designed for genomic variant analysis. Unlike monolithic bioinformatics software, VCFX follows the Unix philosophy where each tool performs a single task efficiently, reading from standard input and writing to standard output. This makes it exceptionally well-suited for complex bioinformatics pipelines where tools are chained together. It is optimized for large datasets using memory mapping (mmap) and SIMD instructions, often outperforming standard tools like bcftools or vcftools for specific operations.

## Core CLI Patterns

### Pipeline Integration
The primary way to use VCFX is by chaining tools using standard streams. This avoids intermediate file creation and reduces I/O overhead.

```bash
cat input.vcf | VCFX_variant_classifier --append-info | grep 'VCF_CLASS=SNP' | VCFX_allele_freq_calc > snp_frequencies.tsv
```

### Python Programmatic Access
If working within a Python environment, use the `vcfx` package to execute tools without manual shell management.

```python
import vcfx
vcfx.run_tool("alignment_checker", "--help")
```

## Tool-Specific Best Practices

### Validation and Quality Control
Use the `VCFX_validator` for GATK-compatible checks. It is significantly faster than traditional validators.
- **Strict Mode**: Use for production-grade pipelines to catch AN/AC consistency issues.
- **Reference Validation**: Use `-R <ref.fasta>` to validate REF alleles against a reference genome.
- **dbSNP Validation**: Use `-D <dbsnp.vcf>` to validate variant IDs.
- **GVCF Support**: Use the `-g` flag when working with Genomic VCFs.

### Performance Optimization
- **Memory Mapping**: For tools that support it (v1.1.4+), use the `-i` or `--input` flag instead of piping via `cat` to leverage mmap-based zero-copy parsing.
- **Sorting**: Many analysis tools require sorted VCFs. Use `VCFX_sorter` which uses pre-computed chromosome IDs for high-speed ordering.
- **Parallelism**: Tools like `VCFX_ld_calculator` and `VCFX_allele_counter` support multi-threading. Check `--help` for thread configuration options.

### Common Tool Categories
- **Filtering**: `VCFX_nonref_filter`, `VCFX_gl_filter`, `VCFX_duplicate_remover`.
- **Analysis**: `VCFX_allele_freq_calc`, `VCFX_ld_calculator`, `VCFX_hwe_tester`, `VCFX_inbreeding_calculator`.
- **Transformation**: `VCFX_indel_normalizer`, `VCFX_fasta_converter`, `VCFX_variant_classifier`.
- **Comparison**: `VCFX_diff_tool`, `VCFX_concordance_checker`.

## Expert Tips
- **Empty VCFs**: By default, some tools may error on empty VCFs. Use the `--allow-empty` override in the validator if your pipeline expects potentially empty outputs.
- **Header Integrity**: When chaining, ensure the first tool in the pipe handles the header correctly. Most VCFX tools preserve headers, but using `VCFX_variant_classifier --append-info` is a good way to ensure INFO field definitions are properly added.
- **SIMD Acceleration**: VCFX tools automatically use SIMD instructions where available. If running in a containerized environment (Docker), ensure the host CPU features are exposed for maximum performance.

## Reference documentation
- [VCFX: Comprehensive VCF Manipulation Toolkit](./references/github_com_ieeta-pt_VCFX.md)
- [VCFX Tags and Release Notes](./references/github_com_ieeta-pt_VCFX_tags.md)