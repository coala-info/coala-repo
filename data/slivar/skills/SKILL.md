---
name: slivar
description: slivar is a high-performance command-line tool for filtering and analyzing genetic variants in VCF files using complex logic and inheritance patterns. Use when user asks to filter variants by inheritance patterns like de novo or compound heterozygotes, apply population frequency thresholds, or perform fast annotation using gnotate files.
homepage: https://github.com/brentp/slivar
metadata:
  docker_image: "quay.io/biocontainers/slivar:0.3.3--h5f107b1_0"
---

# slivar

## Overview
slivar is a high-performance command-line tool designed for the clinical and research analysis of genetic variants. It excels at applying complex logic to VCF files by leveraging a built-in JavaScript engine, allowing for intuitive expressions that reference sample relationships (kid, mom, dad), variant quality metrics, and external population frequencies. It is particularly effective for rare disease research where filtering for specific inheritance patterns (de novo, recessive, compound het) is required.

## Core CLI Patterns

### Basic Filtering with `expr`
The `expr` command is the primary interface for filtering. Use `--info` for variant-level filters and `--trio` or `--family-expr` for sample-specific logic.

```bash
slivar expr \
    --vcf input.vcf.gz \
    --ped family.ped \
    --pass-only \
    --info "variant.FILTER == 'PASS' && INFO.gnomad_af < 0.01" \
    --trio "denovo:kid.het && mom.hom_ref && dad.hom_ref && kid.GQ > 20" \
    --out-vcf filtered.bcf
```

### Annotation with Gnotate Files
slivar uses custom compressed `.zip` files (gnotate) for extremely fast population frequency lookups.
- Use `-g` or `--gnotate` to load these files.
- Access values in expressions via `INFO.<field_name>`.

### Working with Consequence (CSQ) Fields
To filter based on transcript-specific effects (VEP/BCFtools CSQ), load the helper script and use the `CSQs` function.

```bash
slivar expr \
    --js js/csq.js \
    --info "CSQs(INFO.CSQ, VCF.CSQ, ['SIFT']).some(function(csq) { return csq.CONSEQUENCE == 'missense' && csq.SIFT < 0.05 })"
```

### Compound Heterozygote Detection
Finding compound hets requires a multi-step pipe:
1. Filter for rare, impactful heterozygotes.
2. Ensure variants are annotated with gene symbols.
3. Run `compound-hets`.

```bash
slivar expr --vcf $VCF --ped $PED --info "INFO.gnomad_af < 0.01" --trio "kid.het" | \
slivar compound-hets --vcf - --ped $PED --skip NONE --out-vcf comphets.vcf
```

## Expert Tips
- **Performance**: Place the most restrictive filters (like `variant.FILTER == 'PASS'`) at the beginning of the `--info` string. JavaScript evaluation is short-circuited, saving time on complex CSQ or population checks.
- **Genotype Access**: Instead of raw GT strings, use `kid.hom_ref`, `kid.het`, `kid.hom_alt`, or `kid.unknown`. Use `kid.alts` for numeric counts (0, 1, 2, or -1 for unknown).
- **Decomposition**: Always decompose and normalize VCFs (e.g., using `bcftools norm -m -any`) before running slivar to ensure multi-allelic sites are handled correctly.
- **Custom Functions**: Define complex logic in a `.js` file and load it with `--js`. This keeps the CLI command clean and allows for reusable filtering logic across projects.



## Subcommands

| Command | Description |
|---------|-------------|
| slivar compound-hets | find compound-hets in trios from pre-filtered variants |
| slivar ddc | Calculate DDC scores for variants. |
| slivar duodel | find denovo structural deletions in parent-child duos using non-transmission of SNPs |
| slivar expr | Evaluate expressions on VCF/BCF files. |
| slivar make-gnotate | Create gnotate files from VCFs |
| slivar tsv | convert filtered VCF to tab-separated-value spreadsheet for final filtering |

## Reference documentation
- [github_com_brentp_slivar.md](./references/github_com_brentp_slivar.md)
- [github_com_brentp_slivar_wiki_CSQ.md](./references/github_com_brentp_slivar_wiki_CSQ.md)
- [github_com_brentp_slivar_wiki_compound-heterozygotes.md](./references/github_com_brentp_slivar_wiki_compound-heterozygotes.md)