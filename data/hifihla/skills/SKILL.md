---
name: hifihla
description: HiFiHLA performs high-resolution HLA star-calling by mapping PacBio HiFi reads, assembly contigs, or consensus sequences to the IPD-IMGT/HLA database. Use when user asks to call HLA alleles from HiFi reads, extract HLA loci from assembly contigs, or perform HLA typing from consensus sequences.
homepage: https://github.com/PacificBiosciences/hifihla
metadata:
  docker_image: "quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0"
---

# hifihla

## Overview
HiFiHLA is a specialized bioinformatics tool designed to perform "star-calling" for Human Leukocyte Antigen (HLA) genes using the high accuracy of PacBio HiFi reads. It automates the process of mapping sequences to the MHC region, extracting relevant targets, and comparing them against the IPD-IMGT/HLA database to provide high-resolution typing. It is particularly useful for researchers working with immunology, transplantation, or pharmacogenomics data where precise HLA typing is required. Note that this tool is currently deprecated in favor of `pb-StarPhase`, but remains relevant for legacy workflows or specific HiFiHLA-based analyses.

## Core Commands and Workflows

### 1. Calling from HiFi Reads
Use `call-reads` for raw or aligned HiFi data. This is currently optimized for Class I HLA genes (A, B, C).
```bash
hifihla call-reads --reads input.bam --out-prefix sample_name
```

### 2. Calling from Assembly Contigs
Use `call-contigs` when you have a de novo assembly. This tool extracts MHC-aligning contigs and types them.
```bash
hifihla call-contigs --asm input.fasta --out-prefix sample_name
```

### 3. Calling from Amplicon Consensus
Use `call-consensus` for targeted HLA sequencing data.
```bash
hifihla call-consensus --consensus input.fasta --out-prefix sample_name
```

## Best Practices and Tips
- **Output Prefixing**: Always use the `--out-prefix` option. If you provide a path like `results/sample1`, the tool will create `results/sample1_hifihla_report.tsv`.
- **Gene Coverage**: HiFiHLA can call a wide range of genes including Class I, Class II, and non-classical HLA genes (e.g., HLA-E, F, G, MICA/B). Refer to the gene list in the documentation for specific locus support.
- **Database Versioning**: The tool uses specific versions of the IPD-IMGT/HLA database (e.g., v3.55). If results seem inconsistent with newer nomenclature, check the database version used in the `hifihla_report.json`.
- **Exon 2 Requirement**: For more robust typing, especially in clinical research contexts, use the option to require exon 2 coverage to make a call, as this exon contains critical polymorphism information.
- **Interpreting Results**:
    - **4-field calls**: These are only provided if there is an exact match and it is the unique best match.
    - **nMatches**: If `nMatches` > 1 in the summary TSV, multiple alleles are equally likely based on the input sequence.
- **Transitioning**: Since the tool is deprecated, for new projects, consider evaluating if the data is compatible with `pb-StarPhase` for improved phasing and calling.



## Subcommands

| Command | Description |
|---------|-------------|
| hifihla | Call HLA loci from an aligned BAM of HiFi reads |
| hifihla align-imgt | Align queries to IMGT/HLA genomic accession sequences |
| hifihla call-consensus | Call HLA Star (*) alleles from consensus sequences |
| hifihla call-contigs | Extract HLA loci from assembled MHC contigs & call star alleles on extracted sequences |
| hifihla call-reads | Call HLA loci from an aligned BAM of HiFi reads |

## Reference documentation
- [HiFiHLA Usage Guide](./references/github_com_PacificBiosciences_hifihla_blob_main_docs_usage.md)
- [Output File Definitions](./references/github_com_PacificBiosciences_hifihla_blob_main_docs_output.md)
- [Supported HLA Genes](./references/github_com_PacificBiosciences_hifihla_blob_main_docs_genes.md)
- [Installation and Bioconda](./references/github_com_PacificBiosciences_hifihla_blob_main_docs_install.md)