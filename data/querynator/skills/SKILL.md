---
name: querynator
description: querynator automates the clinical interpretation of cancer variants by querying the CGI and CIViC knowledgebases. Use when user asks to identify biomarkers of drug response, retrieve expert-curated evidence for genomic alterations, or generate integrated clinical reports from VCF files.
homepage: https://github.com/qbic-pipelines/querynator
metadata:
  docker_image: "quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0"
---

# querynator

## Overview
querynator is a Python-based command-line interface designed to streamline the clinical interpretation of cancer variants. It acts as a bridge to two major knowledgebases: the Cancer Genome Interpreter (CGI) and the Clinical Interpretation of Variants in Cancer (CIViC). By automating REST API queries and data retrieval, it allows researchers to quickly identify the potential impact of genomic alterations on drug sensitivity, clinical trials, and biological function.

## Core Workflows

### Querying the Cancer Genome Interpreter (CGI)
Use the CGI module to identify biomarkers of drug response and determine the oncogenic potential of variants.
- **Input**: Supports VCF (including .vcf.gz), TSV, and CSV formats.
- **Cleanup**: The tool automatically deletes jobs from the CGI server upon completion to maintain data privacy.
- **Filtering**: You can filter results by a specific cancer type to refine the clinical relevance of the output.

### Querying the CIViC Knowledgebase
Use the CIViC module to pull expert-curated evidence regarding the clinical significance of variants.
- **Evidence Filtering**: Use the `--filter_evidence` flag to narrow down results based on evidence type, direction, status, level, and significance.
- **Cancer Specificity**: Use `-c` or `--cancer` to restrict queries to a specific disease context.
- **Reference Genomes**: Supports multiple reference genomes for coordinate-based lookups.

### Generating Integrated Reports
querynator can merge results from different knowledgebases into a single, human-readable HTML report. This is the preferred output for final analysis as it provides a consolidated view of all available evidence for a given sample.

## CLI Usage Patterns

### Basic CGI Query
```bash
querynator query-api-cgi -i input.vcf -o ./results_cgi --cancer "LUAD"
```

### Basic CIViC Query with Evidence Filtering
```bash
querynator query-api-civic -i input.vcf -o ./results_civic --filter_evidence
```

### Working with Compressed Files
The tool natively supports bgzipped VCF files, allowing you to run queries without manual decompression:
```bash
querynator query-api-cgi -i variants.vcf.gz -o ./output
```

## Expert Tips
- **VEP Integration**: If your input VCF contains VEP (Variant Effect Predictor) annotations, querynator can use this metadata for advanced filtering before querying external databases.
- **Chromosome Formatting**: The tool handles both numerical (e.g., "1") and non-numerical (e.g., "chr1") chromosome naming conventions automatically.
- **CIViC Cache**: The `civicpy` cache is only updated when a CIViC query is initiated, which saves time and bandwidth during CGI-only workflows.
- **Wildtype Biomarkers**: Recent versions support CGI wildtype biomarkers, which is critical for identifying cases where the absence of a mutation is clinically actionable.



## Subcommands

| Command | Description |
|---------|-------------|
| querynator create-report | Generates reports from CGI and CIViC result folders. |
| querynator query-api-cgi | Query the CGI API |
| querynator query-api-civic | Query the Civic API for variants in a VCF file. |

## Reference documentation
- [README.rst](./references/github_com_qbic-pipelines_querynator_blob_master_README.rst.md)
- [CHANGELOG.rst](./references/github_com_qbic-pipelines_querynator_blob_master_CHANGELOG.rst.md)