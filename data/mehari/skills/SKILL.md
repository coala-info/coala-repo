---
name: mehari
description: Mehari is a high-performance genomic variant annotator implemented in Rust.
homepage: https://github.com/bihealth/mehari
---

# mehari

## Overview
Mehari is a high-performance genomic variant annotator implemented in Rust. It provides functionality similar to VEP (Variant Effect Predictor) and SnpEff, focusing on projecting genomic coordinates to transcript and protein levels. It is specifically designed to generate HGVS-compliant nomenclature that mirrors VariantValidator and consequence predictions compatible with the Sequence Ontology terms used by VEP.

## Installation
Mehari is available via Bioconda:
```bash
conda install bioconda::mehari
```

## Core Usage Patterns

### Annotating Sequence Variants (seqvars)
The primary command for processing VCF files is `annotate seqvars`. This command maps variants to transcripts and can optionally integrate population frequencies and clinical data.

```bash
mehari annotate seqvars \
  --transcripts path/to/transcript_db \
  --frequencies path/to/gnomad_db \
  --clinvar path/to/clinvar_db \
  --path-input-vcf input.vcf \
  --path-output-vcf output.vcf
```

### Key CLI Arguments
- `--transcripts`: Path to the transcript database (required for consequence and HGVS prediction).
- `--frequencies`: Path to population frequency databases (e.g., gnomAD).
- `--clinvar`: Path to the ClinVar database for clinical significance mapping.
- `--path-input-vcf`: The source VCF file.
- `--path-output-vcf`: The destination for the annotated VCF.

## Expert Tips and Best Practices

- **Database Sourcing**: Mehari requires specific database formats. Obtain pre-built transcript databases from `varfish-org/mehari-data-tx` and ClinVar databases from `varfish-org/annonars-data-clinvar`.
- **HGVS Fidelity**: Because Mehari uses the `hgvs-rs` library, it is highly reliable for generating HGVS descriptions. Use it when clinical-grade nomenclature is required for reporting.
- **Performance Optimization**: As a Rust-based tool, Mehari is significantly faster than Perl-based VEP for large datasets. It is preferred for high-throughput pipelines where execution time is a bottleneck.
- **Integration**: While primarily used as a CLI tool, Mehari can be imported as a library in other Rust projects for developers building custom bioinformatics software.

## Reference documentation
- [Mehari GitHub Repository](./references/github_com_varfish-org_mehari.md)
- [Mehari Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mehari_overview.md)