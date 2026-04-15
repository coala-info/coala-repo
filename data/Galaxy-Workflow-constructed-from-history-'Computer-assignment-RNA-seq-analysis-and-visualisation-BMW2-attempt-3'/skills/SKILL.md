---
name: workflow-constructed-from-history-computer-assignment-rna-se
description: This RNA-seq workflow processes transcriptomic count data and metadata using DESeq2, goseq, and various visualization tools to identify differentially expressed genes and enriched biological pathways. Use this skill when you need to compare gene expression profiles between experimental conditions, such as irradiated versus mock-treated samples, to uncover significant transcriptional changes and their functional implications.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-computer-assignment-rna-se

## Overview

This Galaxy workflow performs a comprehensive RNA-seq analysis and visualization, specifically designed for differential gene expression studies involving p53 and ionizing radiation (IR) treatments. Utilizing the [DESeq2](https://toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy0) tool, the pipeline processes multiple count datasets (mock vs. IR) across different genotypes to identify statistically significant changes in gene expression.

The workflow integrates extensive downstream functional analysis and data transformation steps. It calculates gene length and GC content, annotates differential expression results, and performs Gene Ontology (GO) enrichment analysis using [goseq](https://toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0). Data manipulation tools like Table Compute, Join, and Sort are used to refine the datasets for high-quality reporting.

For visualization and interpretation, the pipeline generates several graphical outputs, including [Volcano Plots](https://toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/3.3.3+galaxy0) to highlight significant genes and multiple [heatmaps](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1) for expression pattern clustering. It also includes multivariate analysis steps to explore the variance and relationships between samples, providing a robust framework for biological discovery in transcriptomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | p53_mock_1.csv | data_input |  |
| 1 | p53_mock_2.csv | data_input |  |
| 2 | p53_mock_3.csv | data_input |  |
| 3 | p53_mock_4.csv | data_input |  |
| 4 | p53_IR_1.csv | data_input |  |
| 5 | p53_IR_2.csv | data_input |  |
| 6 | p53_IR_3.csv | data_input |  |
| 7 | p53_IR_4.csv | data_input |  |
| 8 | null_mock_1.csv | data_input |  |
| 9 | null_mock_2.csv | data_input |  |
| 10 | null_IR_1.csv | data_input |  |
| 11 | null_IR_2.csv | data_input |  |
| 12 | null_IR_1.csv | data_input |  |
| 13 | null_IR_1.csv | data_input |  |
| 14 | p53_mock_1.csv | data_input |  |
| 15 | p53_mock_2.csv | data_input |  |
| 16 | p53_mock_3.csv | data_input |  |
| 17 | p53_mock_4.csv | data_input |  |
| 18 | p53_IR_1.csv | data_input |  |
| 19 | p53_IR_2.csv | data_input |  |
| 20 | p53_IR_3.csv | data_input |  |
| 21 | p53_IR_4.csv | data_input |  |
| 22 | null_mock_1.csv | data_input |  |
| 23 | null_mock_2.csv | data_input |  |
| 24 | null_IR_1.csv | data_input |  |
| 25 | null_IR_2.csv | data_input |  |
| 26 | Annotation file | data_input |  |
| 27 | header | data_input |  |
| 28 | GSE71176_sample_metadata.txt | data_input |  |
| 29 | GSE71176_variable_metadata.txt | data_input |  |
| 30 | GSE71176_sample_metadata.txt | data_input |  |
| 31 | GSE71176_variable_metadata.txt | data_input |  |
| 32 | GSE71176_sample_metadata.txt | data_input |  |
| 33 | GSE71176_variable_metadata.txt | data_input |  |
| 34 | GSE71176_sample_metadata.txt | data_input |  |
| 35 | GSE71176_sample_metadata.txt | data_input |  |


Ensure all count files are uploaded as CSV or tabular formats, and verify that the annotation and metadata files match the expected column structures for DESeq2 and goseq. While this workflow uses individual dataset inputs for each sample, grouping them into collections can significantly streamline the execution of downstream tools like Table Compute and heatmap2. Refer to the README.md for comprehensive details on sample naming conventions and specific parameter requirements for the multivariate analysis steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and easier management of the numerous input files.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 36 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy0 |  |
| 37 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy0 |  |
| 38 | Gene length and GC content | toolshed.g2.bx.psu.edu/repos/iuc/length_and_gc_content/length_and_gc_content/0.1.2 |  |
| 39 | Filter | Filter1 |  |
| 40 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy1 |  |
| 41 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy1 |  |
| 42 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/3.3.3+galaxy0 |  |
| 43 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/9.5+galaxy0 |  |
| 44 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy0 |  |
| 45 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/9.5+galaxy0 |  |
| 46 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 47 | Annotate DESeq2/DEXSeq output tables | toolshed.g2.bx.psu.edu/repos/iuc/deg_annotate/deg_annotate/1.1.0 |  |
| 48 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/9.5+galaxy0 |  |
| 49 | Cut | Cut1 |  |
| 50 | Cut | Cut1 |  |
| 51 | Concatenate datasets | cat1 |  |
| 52 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 53 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 |  |
| 54 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 |  |
| 55 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/3.3.3+galaxy0 |  |
| 56 | Cut | Cut1 |  |
| 57 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy0 |  |
| 58 | Select first | Show beginning1 |  |
| 59 | Cut | Cut1 |  |
| 60 | Cut | Cut1 |  |
| 61 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 62 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 63 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 64 | Multivariate | toolshed.g2.bx.psu.edu/repos/ethevenot/multivariate/Multivariate/2.3.10 |  |
| 65 | Multivariate | toolshed.g2.bx.psu.edu/repos/ethevenot/multivariate/Multivariate/2.3.10 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rna-seq-analysis-and-visualisation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rna-seq-analysis-and-visualisation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rna-seq-analysis-and-visualisation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rna-seq-analysis-and-visualisation.ga -o job.yml`
- Lint: `planemo workflow_lint rna-seq-analysis-and-visualisation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rna-seq-analysis-and-visualisation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)