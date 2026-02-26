---
name: querynator
description: querynator automates the retrieval of clinical insights and annotations for cancer variants from the CGI and CIViC knowledgebases. Use when user asks to query cancer variant databases, annotate genomic alterations with clinical evidence, or generate reports on variant actionability and treatment options.
homepage: https://github.com/qbic-pipelines/querynator
---


# querynator

## Overview

`querynator` is a specialized CLI tool designed for clinical bioinformatics. It automates the retrieval of biological and clinical insights for cancer variants from two primary knowledgebases: the Cancer Genome Interpreter (CGI) and the Clinical Interpretation of Variants in Cancer (CIViC). It is used to transform raw variant data into annotated reports that highlight the clinical significance, actionability, and evidence-based treatment options associated with specific genomic alterations.

## Core CLI Usage

The tool provides two primary entry points corresponding to the databases it queries.

### Querying the Cancer Genome Interpreter (CGI)
Use this command to query the CGI REST API for variant annotations.
- **Command**: `query-api-cgi`
- **Key Feature**: Supports filtering by cancer type to ensure evidence is relevant to the specific tumor context.
- **Best Practice**: Always specify the cancer type when known to reduce noise in the evidence reports.

### Querying CIViC
Use this command to query the CIViC knowledgebase via the CIViCpy toolkit.
- **Command**: `query-api-civic`
- **Key Feature**: Includes evidence filters (introduced in v0.6.0) to refine results based on clinical significance or evidence levels.
- **Common Pattern**: Use the `--cancer` flag to filter results by specific disease ontologies.

## Expert Tips and Best Practices

- **Evidence Filtering**: In version 0.6.0 and later, utilize the evidence filters to manage the volume of data returned. This is critical when working with well-characterized genes that may have hundreds of associated evidence items.
- **Cancer Type Specification**: Use the `--cancer` flag to align queries with specific Disease Ontology (DO) terms. This ensures that the "biomarker match" logic correctly identifies variants that are actionable for the specific cancer being studied.
- **Installation**: The tool is best managed via Conda/Mamba using the Bioconda channel:
  ```bash
  conda install bioconda::querynator
  ```
- **Data Updates**: Since `querynator` relies on external APIs and the CIViCpy cache, ensure your environment has internet access during the initial query to allow for data retrieval and caching.

## Reference documentation
- [querynator GitHub Repository](./references/github_com_qbic-pipelines_querynator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_querynator_overview.md)