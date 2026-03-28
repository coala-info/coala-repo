---
name: varpubs
description: varpubs is a command-line utility that queries PubMed and uses large language models to generate clinical literature summaries for genomic variants. Use when user asks to deploy a variant database, summarize PubMed articles for specific mutations, or manage a local literature cache.
homepage: https://github.com/koesterlab/varpubs
---


# varpubs

## Overview

varpubs is a command-line utility that bridges the gap between genomic variant data (VCF) and clinical literature. It streamlines the variant interpretation process by automatically querying PubMed/PubGator, caching results in a DuckDB database, and using Large Language Models (LLMs) to generate concise, three-sentence summaries. It is particularly useful for Molecular Tumor Boards or clinical dashboards where rapid, evidence-based decision-making is required for rare or poorly characterized mutations.

## Core Workflow

### 1. Database Initialization
Before summarizing, you must create a local database populated with variant information from your VCF files.

```bash
varpubs deploy-db \
  --db-path pubmed.duckdb \
  --vcf-paths variants.vcf.gz
```

### 2. Literature Summarization
This is the primary command for generating evidence. It requires an OpenAI-compatible API endpoint.

```bash
varpubs summarize-variants \
  --db-path pubmed.duckdb \
  --vcf-path variants_annotated.vcf.gz \
  --llm-url https://your-llm-endpoint \
  --api-key $YOUR_API_KEY \
  --model medgemma-27b-it \
  --role physician \
  --output summaries.tsv
```

### 3. Cache Management
To save time and API costs in repetitive analyses, always utilize the caching system.

*   **Use a cache during summarization**: Include `--cache existing_cache.duckdb` and `--output-cache new_results.duckdb`.
*   **Merge caches**: Use the `update-cache` command to consolidate findings.

```bash
varpubs update-cache \
  --cache tmp_cache.duckdb \
  --output main_cache.duckdb
```

## Expert Tips and Best Practices

*   **Role-Based Summaries**: Use the `--role` parameter (e.g., `physician`, `researcher`) to adjust the tone and focus of the generated three-sentence summaries.
*   **Relevance Judging**: Enable the optional LLM "judge" to score articles on a scale of 1-4. This helps prioritize papers discussing therapy relevance or clinical outcomes over purely functional studies.
*   **Environment Variables**: Store your API keys in environment variables (e.g., `export HF_TOKEN=your_key`) rather than passing them as plain text in the command line.
*   **Input Preparation**: Ensure your VCF is properly annotated (e.g., with HGVS.p notation), as varpubs relies on these annotations to build effective PubMed search queries.
*   **Database Choice**: varpubs uses DuckDB for its backend, which allows for high-performance local querying. You can inspect the `pubmed.duckdb` file using standard SQL tools if you need to verify the retrieved abstracts.



## Subcommands

| Command | Description |
|---------|-------------|
| update-cache | UpdateCacheArgs ['args']: Arguments for updating the cache. |
| var pubs deploy-db | DeployDBArgs ['args']: Command-line arguments for deploying the PubMed variant database. |
| var pubs summarize-variants | SummarizeArgs ['args']: Command-line arguments for summarizing PubMed articles related to variants. |

## Reference documentation
- [varpubs README](./references/github_com_koesterlab_varpubs_blob_main_README.md)
- [Project Metadata and Dependencies](./references/github_com_koesterlab_varpubs_blob_main_pyproject.toml.md)
- [Changelog and Feature History](./references/github_com_koesterlab_varpubs_blob_main_CHANGELOG.md)