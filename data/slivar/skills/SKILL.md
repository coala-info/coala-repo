---
name: slivar
description: slivar is a high-performance command-line tool designed for rapid querying and filtering of genomic variants.
homepage: https://github.com/brentp/slivar
---

# slivar

## Overview
slivar is a high-performance command-line tool designed for rapid querying and filtering of genomic variants. It uses a JavaScript-based expression engine to allow complex logic on INFO fields, sample genotypes, and family structures. Unlike traditional filters, slivar understands pedigrees, allowing you to write intuitive expressions like `kid.het && mom.hom_ref && dad.hom_ref` to identify candidate de novo mutations across an entire cohort simultaneously.

## Core CLI Patterns

### Basic Filtering and Annotation
The `expr` command is the primary interface for filtering. Use `--info` for site-level filters and `--pass-only` to reduce output size.

```bash
slivar expr \
    --vcf input.vcf.gz \
    --pass-only \
    --info "variant.FILTER == 'PASS' && variant.call_rate > 0.9 && INFO.gnomad_af < 0.01" \
    --out-vcf filtered.vcf.gz
```

### Trio Analysis
When a pedigree (`.ped`) file is provided, slivar automatically identifies trios and maps them to `kid`, `mom`, and `dad` labels.

```bash
slivar expr \
    --vcf input.vcf.gz \
    --ped cohort.ped \
    --js slivar-functions.js \
    --trio "denovo:kid.het && mom.hom_ref && dad.hom_ref && kid.GQ > 20 && (mom.AD[1] + dad.AD[1]) == 0" \
    --trio "recessive:trio_autosomal_recessive(kid, mom, dad)" \
    --out-vcf trios.vcf.gz
```

### Population Annotation (gnotate)
slivar can annotate variants with population frequencies using highly compressed `.zip` gnotate files without requiring a heavy database.

```bash
slivar expr \
    --vcf input.vcf.gz \
    --gnotate gnomad.hg38.genomes.v3.fix.zip \
    --info "INFO.gnomad_popmax_af < 0.001" \
    --out-vcf annotated.vcf.gz
```

### Compound Heterozygotes
After initial filtering, use the `compound-hets` command to identify pairs of variants in the same gene that may cause disease.

```bash
slivar compound-hets \
    --vcf filtered.vcf.gz \
    --ped cohort.ped \
    --sample-field denovo \
    --sample-field recessive \
    --out-vcf comp_hets.vcf.gz
```

### Exporting to TSV
To create a readable spreadsheet from a filtered VCF, use the `tsv` command.

```bash
slivar tsv \
    --vcf filtered.vcf.gz \
    --ped cohort.ped \
    --info "gnomad_af" \
    --sample-field denovo \
    --sample-field recessive \
    > variants.tsv
```

## Expert Tips & Best Practices

- **Decompose VCFs**: Always run `bcftools norm -m -any` or a similar decomposition tool before using slivar. slivar performs best when multiallelic variants are split into individual records.
- **JavaScript Functions**: Use the standard `slivar-functions.js` library provided in the repository. It contains optimized implementations for common inheritance patterns like `trio_autosomal_recessive` and `trio_denovo`.
- **Attribute Access**:
    - `alts`: 0 (hom_ref), 1 (het), 2 (hom_alt), -1 (unknown).
    - `AB`: Allelic balance (calculated automatically if AD is present).
    - `DP` / `GQ`: Standard depth and quality metrics.
- **Performance**: For very large cohorts, use `pslivar` (parallel slivar) to distribute the workload across multiple CPU cores.
- **Order of Operations**: Use `--info` filters to remove common or low-quality variants before evaluating complex `--trio` or `--family-expr` logic to save computation time.

## Reference documentation
- [slivar GitHub README](./references/github_com_brentp_slivar.md)
- [slivar Wiki](./references/github_com_brentp_slivar_wiki.md)
- [Bioconda slivar Overview](./references/anaconda_org_channels_bioconda_packages_slivar_overview.md)