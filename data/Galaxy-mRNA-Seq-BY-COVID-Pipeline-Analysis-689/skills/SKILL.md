---
name: mrna-seq-by-covid-pipeline-analysis
description: "This bulk RNA-Seq analysis workflow processes featureCounts data and experimental factors using limma, annotateMyIDs, and goseq to perform differential expression and functional enrichment. Use this skill when you need to identify differentially expressed genes and enriched biological pathways from transcriptomic count data to prepare results for downstream visualization in MINERVA."
homepage: https://workflowhub.eu/workflows/689
---

# mRNA-Seq BY-COVID Pipeline: Analysis

## Overview

This workflow is designed for the analysis of bulk RNA-Seq data as part of the [BY-COVID](https://by-covid.org/) project. It processes gene count data to perform differential expression analysis and prepares the results for downstream pathway visualization and functional interpretation.

The pipeline takes featureCounts outputs (counts and lengths) and experimental factor data as primary inputs. It utilizes [limma-voom](https://toolshed.g2.bx.psu.edu/repos/iuc/limma_voom) to identify differentially expressed genes. To ensure biological relevance, the workflow integrates [annotateMyIDs](https://toolshed.g2.bx.psu.edu/repos/iuc/annotatemyids) for gene symbol mapping and [goseq](https://toolshed.g2.bx.psu.edu/repos/iuc/goseq) for Gene Ontology enrichment analysis.

Key outputs include a comprehensive limma report and a formatted count data table. Notably, the workflow generates a specialized `minerva_table` designed specifically for integration with the [MINERVA Platform](https://minerva.pages.uni.lu/), facilitating advanced pathway analysis and disease map exploration. This workflow is licensed under GPL-3.0-or-later.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | featureCounts: Counts | data_collection_input | count data collection with two column datasets (gene_id, count) |
| 1 | factordata | data_input | A two column factor table with (Sample Identifier, Condition)  This workflow assumes a 1 factor, 2 level analysis, and was specifically designed around SARS-CoV-2 analysis with two levels, e.g. ``` SampleName 	Group SRR16683284 	COVID SRR16683283 	COVID  SRR16683271 	healthy SRR16683270 	healthy  ``` |
| 2 | featureCounts: Lengths | data_collection_input | featureCounts Lengths collection |


Ensure your input count and length data are provided as paired list collections (tabular format) to maintain sample consistency, while the factor data should be a single tabular file defining your experimental design. Verify that gene identifiers across all inputs match the expected format for `annotateMyIDs` to ensure successful mapping for downstream pathway analysis. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a template `job.yml` file. Detailed specifications for column headers and factor levels are available in the accompanying README.md.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 4 | Extract dataset | __EXTRACT_DATASET__ |  |
| 5 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 6 | annotateMyIDs | toolshed.g2.bx.psu.edu/repos/iuc/annotatemyids/annotatemyids/3.16.0+galaxy1 |  |
| 7 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 8 | limma | toolshed.g2.bx.psu.edu/repos/iuc/limma_voom/limma_voom/3.50.1+galaxy0 |  |
| 9 | Extract dataset | __EXTRACT_DATASET__ |  |
| 10 | Cut | Cut1 |  |
| 11 | Join two Datasets | join1 |  |
| 12 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.4 |  |
| 13 | Cut | Cut1 |  |
| 14 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.1.0 |  |
| 15 | Cut | Cut1 |  |
| 16 | Cut | Cut1 |  |
| 17 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | count_data | outfile |
| 8 | limma_report | outReport |
| 10 | minerva_table | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Analysis.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
