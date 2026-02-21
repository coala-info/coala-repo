---
name: varpubs
description: `varpubs` is a command-line utility designed to streamline the process of finding PubMed evidence for genetic variants.
homepage: https://github.com/koesterlab/varpubs
---

# varpubs

## Overview

`varpubs` is a command-line utility designed to streamline the process of finding PubMed evidence for genetic variants. It addresses the challenge of reviewing large volumes of literature by querying variant-linked publications and generating three-sentence summaries tailored to specific professional roles (e.g., physicians). The tool supports relevance scoring through LLM-based "judges" and maintains a local database and cache to ensure efficiency and reproducibility in clinical workflows.

## Installation

Install `varpubs` using Pixi or Bioconda:

```bash
# Using Pixi
pixi global install varpubs

# Using Bioconda
conda install -c bioconda varpubs
```

## Core Workflow and CLI Patterns

### 1. Initialize the Variant Database
Before summarizing, you must deploy a local database that maps your variants of interest to the literature.

```bash
varpubs deploy-db \
  --db-path pubmed.duckdb \
  --vcf-paths variants.vcf.gz
```

### 2. Generate Variant Summaries
This is the primary command for literature synthesis. It requires an LLM endpoint (e.g., Hugging Face, OpenAI-compatible APIs) and a specific model.

```bash
varpubs summarize-variants \
  --db-path pubmed.duckdb \
  --vcf-path variants_annotated.vcf.gz \
  --llm-url https://your-llm-endpoint \
  --api-key $API_TOKEN \
  --model medgemma-27b-it \
  --role physician \
  --cache cache.duckdb \
  --output summaries.tsv
```

### 3. Manage and Update Caches
To save time and API costs, use the caching system to store previously generated summaries. You can merge temporary caches into a primary cache.

```bash
varpubs update-cache \
  --cache tmp_cache.duckdb \
  --output cache.duckdb
```

## Expert Tips and Best Practices

- **Role-Based Summarization**: Use the `--role` parameter to change the perspective of the summary. For example, use `physician` for clinical relevance or `researcher` for mechanistic details.
- **Relevance Scoring**: Utilize the LLM "judge" feature to prioritize articles based on specific terms like "therapy relevance" or "prognostic significance." This helps filter out noise in well-studied genes.
- **Database Persistence**: Always point to a persistent `--db-path`. The underlying DuckDB format allows for fast querying even with large VCF files.
- **Environment Variables**: Store your LLM API keys in environment variables (e.g., `$HF_TOKEN`) rather than hardcoding them into scripts to maintain security.
- **Output Integration**: The resulting TSV file is designed for direct import into clinical reporting tools or molecular tumor board dashboards.

## Reference documentation
- [varpubs GitHub Repository](./references/github_com_koesterlab_varpubs.md)
- [varpubs Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_varpubs_overview.md)