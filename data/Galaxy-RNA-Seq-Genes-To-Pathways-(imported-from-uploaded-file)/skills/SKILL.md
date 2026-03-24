---
name: rna-seq-genes-to-pathways-imported-from-uploaded-file
description: "This transcriptomics workflow processes differential expression tables and count data using EGSEA, fgsea, and goseq to perform comprehensive functional enrichment analysis. Use this skill when you need to identify overrepresented biological pathways or gene sets from ranked gene lists to understand the functional implications of differential gene expression in mouse or other model organisms."
homepage: https://workflowhub.eu/workflows/1699
---

# RNA Seq Genes To Pathways (imported from uploaded file)

## Overview

This Galaxy workflow performs downstream functional enrichment analysis on RNA-seq data, transitioning from differentially expressed (DE) genes to biological pathways. It is designed to identify over-represented gene sets and pathways using multiple established methodologies, including Gene Ontology (GO) and pathway-based enrichment.

The pipeline processes several inputs, including sequence data, factor metadata, and pre-calculated DE tables. It utilizes a series of text-processing tools—such as column manipulation, cutting, joining, and sorting—to format and prepare the gene lists for statistical testing. These steps ensure that the gene identifiers and expression metrics are correctly aligned for the subsequent enrichment tools.

The core analysis is conducted through three primary tools: **EGSEA** (Ensemble of Gene Set Enrichment Analyses), **fgsea** (Fast Gene Set Enrichment Analysis), and **goseq**. These tools provide a comprehensive view of the data by generating enrichment reports, PDF visualizations, and tabular summaries of significant pathways. This multi-method approach allows for robust validation of biological themes within the transcriptomics data.

This workflow is aligned with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials for transcriptomics. It provides a streamlined path for researchers to move from raw differential expression results to high-level biological interpretation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | seqdata | data_input |  |
| 1 | factordata | data_input |  |
| 2 | DE table | data_collection_input |  |
| 3 | mouse_hallmark_sets | data_input |  |
| 4 | limma_filtered_counts | data_input |  |


Ensure your input files are in tabular or CSV format, specifically verifying that the DE table is provided as a data collection to maintain the expected structure for downstream enrichment tools. You should prepare your sequence data, factor metadata, and gene sets (such as mouse hallmark sets) as individual datasets, ensuring gene identifiers are consistent across all inputs to facilitate successful joins and sorting. For comprehensive guidance on formatting requirements and parameter settings, refer to the accompanying README.md file. You can streamline the execution process by using `planemo workflow_job_init` to generate a `job.yml` template for your input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.6 |  |
| 6 | Cut | Cut1 |  |
| 7 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 8 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 9 | Join two Datasets | join1 |  |
| 10 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 11 | EGSEA | toolshed.g2.bx.psu.edu/repos/iuc/egsea/egsea/1.20.0 |  |
| 12 | Cut | Cut1 |  |
| 13 | Cut | Cut1 |  |
| 14 | fgsea | toolshed.g2.bx.psu.edu/repos/iuc/fgsea/fgsea/1.8.0+galaxy1 |  |
| 15 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.44.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | out_file1 | out_file1 |
| 6 | out_file1 | out_file1 |
| 7 | output | output |
| 8 | output | output |
| 9 | out_file1 | out_file1 |
| 10 | outfile | outfile |
| 11 | outTables | outTables |
| 11 | outReport | outReport |
| 12 | out_file1 | out_file1 |
| 13 | out_file1 | out_file1 |
| 14 | out_pdf | out_pdf |
| 14 | out_tab | out_tab |
| 15 | top_plot | top_plot |
| 15 | wallenius_tab | wallenius_tab |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rna-seq-genes-to-pathways.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rna-seq-genes-to-pathways.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rna-seq-genes-to-pathways.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rna-seq-genes-to-pathways.ga -o job.yml`
- Lint: `planemo workflow_lint rna-seq-genes-to-pathways.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rna-seq-genes-to-pathways.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
