---
name: varlinker
description: varlinker maps genomic coordinates from VCF files to biological features including genes, exons, transcripts, and clinical evidence. Use when user asks to link variants to genomic features, annotate VCFs with ClinVar records, perform allele-specific extraction, or map genes to phenotypes and OMIM evidence.
homepage: https://github.com/IBCHgenomic/varlinker
metadata:
  docker_image: "quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0"
---

# varlinker

## Overview

varlinker is a high-performance, parallel-threaded tool written in Rust designed for human genomics research. It serves as a specialized annotator that maps genomic coordinates to biological features. Its primary function is to "link" variants found in VCF files to specific genes, exons, and transcripts, while also providing subcommands for clinical and phenotypic evidence mapping. It is particularly useful for researchers needing to process large datasets quickly or filter annotations based on specific reference or alternate alleles.

## Command Line Usage and Patterns

### Core Variant Annotation
To perform a comprehensive annotation of all variants within a VCF file:
```bash
varlinker variant-linker ./path/to/sample.vcf
```
This command generates three distinct output files in the working directory:
- `annotationfile-gene.txt`: Links variants to Ensembl Gene IDs and symbols.
- `annotationfile-exon.txt`: Provides exon-level mapping.
- `annotationfile-transcript.txt`: Provides transcript-level mapping.

### Allele-Specific Extraction
Use these commands when you only care about specific nucleotide changes:

**Annotate by Reference Allele:**
```bash
varlinker variant-trefanno ./sample.vcf [ALLELE]
# Example: varlinker variant-trefanno ./sample.vcf A
```

**Annotate by Alternate Allele:**
```bash
varlinker variant-taltanno ./sample.vcf [ALLELE]
# Example: varlinker variant-taltanno ./sample.vcf T
```

### Clinical and Phenotypic Linking
varlinker supports complex workflows for clinical genomics:

- **ClinVar VCF Annotation**: Link VCF variants directly to ClinVar records.
  ```bash
  varlinker vcf-clinvar-annotate --vcffile <VCF> --clinvar <CLINVAR_FILE>
  ```
- **Phenotype Linking**: Connect genes to diseases and HPO (Human Phenotype Ontology) terms.
  ```bash
  varlinker phenotype-linker --genesdisease <FILE> --genesphenotype <FILE> --phenotypehpoa <FILE> --phenotypesgenes <FILE>
  ```
- **OMIM Evidence**: Extract links for specific OMIM evidence numbers.
  ```bash
  varlinker omim --omimfile <FILE> --evidencenumber <INT> --hpomapping <FILE> --hpomedgen <FILE>
  ```

### Database Management
Before running complex annotations, ensure you have the required reference files. The tool provides a built-in downloader:
```bash
varlinker databases --databaseoption [OPTION_INDEX]
```

## Expert Tips

- **Parallel Execution**: varlinker uses the Rayon library for data parallelism. When running on high-core count machines, it will automatically scale to utilize available threads for VCF parsing and annotation.
- **Output Format**: The output files use a tab-delimited format compatible with standard Unix tools like `awk`, `grep`, and `sed` for downstream filtering.
- **Memory Efficiency**: Because it is written in Rust, the tool handles large VCF files with a lower memory footprint compared to Python-based alternatives, making it suitable for memory-constrained environments.
- **Windows Support**: While primarily used on Linux/macOS, it can be compiled for Windows using `cargo xwin` if the MSVC target is added to the Rust environment.



## Subcommands

| Command | Description |
|---------|-------------|
| varlinker variant-linker | Links variants across different datasets. |
| varlinker_variant-taltanno | extract the annotation of the specific alt allele |
| varlinker_variant-trefanno | extract the annotation of the specific ref allele |

## Reference documentation
- [varlinker README](./references/github_com_sablokrep_varlinker_blob_main_README.md)
- [varlinker Main Source](./references/github_com_sablokrep_varlinker_blob_main_main.rs.md)