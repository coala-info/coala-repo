---
name: varlinker
description: `varlinker` is a high-performance, Rust-based tool designed for exact point variant annotation in human genomics.
homepage: https://github.com/IBCHgenomic/varlinker
---

# varlinker

## Overview
`varlinker` is a high-performance, Rust-based tool designed for exact point variant annotation in human genomics. It excels at mapping VCF coordinates to biological features (genes, exons, and transcripts) using parallel processing. This skill provides the necessary command patterns to perform comprehensive annotations or filter for specific alleles within large datasets.

## Command Usage

### Full Variant Annotation
To perform a complete annotation of a VCF file, use the `variant-linker` command. This process is multi-threaded and generates three distinct output files categorized by genomic feature.

```bash
varlinker variant-linker <INPUT_VCF>
```

**Outputs generated:**
- `annotationfile-gene.txt`: Maps variants to Ensembl Gene IDs and symbols.
- `annotationfile-exon.txt`: Maps variants to specific exon boundaries.
- `annotationfile-transcript.txt`: Maps variants to transcript-level data.

### Specific Allele Extraction
If you only need to annotate or extract variants matching a specific nucleotide, use the targeted annotation commands.

**Annotate only specific Reference (REF) alleles:**
```bash
varlinker variant-trefanno <INPUT_VCF> <NUCLEOTIDE>
# Example: Extract all 'A' reference variants
varlinker variant-trefanno sample.vcf A
```

**Annotate only specific Alternate (ALT) alleles:**
```bash
varlinker variant-taltanno <INPUT_VCF> <NUCLEOTIDE>
# Example: Extract all 'T' alternate variants
varlinker variant-taltanno sample.vcf T
```

## Best Practices
- **Input Format**: Ensure your input is a standard VCF file. The tool is optimized for human genomics coordinates.
- **Parallelism**: The tool utilizes Rust's threading capabilities; ensure the execution environment has sufficient CPU cores for large VCF files to maximize throughput.
- **Output Management**: Since `variant-linker` produces three separate files in the working directory, ensure you have write permissions and sufficient disk space before starting a large run.

## Reference documentation
- [varlinker GitHub Repository](./references/github_com_sablokrep_varlinker.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_varlinker_overview.md)