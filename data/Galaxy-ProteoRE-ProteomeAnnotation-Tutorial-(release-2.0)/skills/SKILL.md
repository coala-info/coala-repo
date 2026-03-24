---
name: proteore-proteomeannotation-tutorial-release-20
description: "This proteomics workflow processes protein lists from LC-MS/MS experiments using ID conversion, tissue-specific expression mapping from the Human Protein Atlas, and functional enrichment via Reactome and clusterProfiler. Use this skill when you need to annotate identified proteins with biological context, compare multiple proteomic datasets via Venn diagrams, or identify enriched pathways and gene ontology terms within a specific tissue profile."
homepage: https://workflowhub.eu/workflows/1411
---

# ProteoRE ProteomeAnnotation Tutorial (release 2.0)

## Overview

This Galaxy workflow is designed for the functional annotation of protein lists identified through LC-MS/MS proteomics experiments. It processes multiple input datasets—specifically the Lacombe, Bredberg, and Mucilli datasets—to standardize protein identifiers and facilitate comparative analysis across different experimental conditions.

The pipeline integrates tissue-specific expression data retrieved from the [Human Protein Atlas (HPA)](https://www.proteinatlas.org/) and applies filtering criteria based on keywords or numerical values. By utilizing dedicated ID conversion tools, the workflow ensures data consistency before generating comparative visualizations, such as Venn diagrams, to identify overlapping proteins between samples.

For biological interpretation, the workflow performs comprehensive functional characterization. It maps protein lists to the [Reactome pathway database](https://reactome.org/) and conducts Gene Ontology (GO) classification and enrichment analysis using [ClusterProfiler](https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html). This allows researchers to pinpoint significant biological processes and pathways associated with their proteomic profiles.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this tutorial workflow provides a standardized approach to proteomics data interpretation, moving from raw protein lists to high-level biological insights.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Lacombe_et_al_2017.txt | data_input |  |
| 1 | Bredberg.txt | data_input |  |
| 2 | Mucilli.txt | data_input |  |


Ensure your input protein lists are uploaded as tabular or text files containing valid identifiers, such as UniProt accessions or Gene Symbols, to facilitate seamless ID conversion and downstream enrichment. While these inputs are handled as individual datasets, you may consider grouping them into a collection for more efficient batch processing across the ProteoRE toolset. For automated execution and parameter mapping, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Always refer to the accompanying README.md for comprehensive details on specific column requirements and filtering criteria.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Build tissue-specific expression dataset | toolshed.g2.bx.psu.edu/repos/proteore/proteore_tissue_specific_expression_data/retrieve_from_hpa/2019.02.27 |  |
| 4 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2019.03.11 |  |
| 5 | ID Converter | toolshed.g2.bx.psu.edu/repos/proteore/proteore_id_converter/IDconverter/2019.03.07 |  |
| 6 | ID Converter | toolshed.g2.bx.psu.edu/repos/proteore/proteore_id_converter/IDconverter/2019.03.07 |  |
| 7 | Venn diagram | toolshed.g2.bx.psu.edu/repos/proteore/proteore_venn_diagram/Jvenn/2019.02.21 |  |
| 8 | Add expression data | toolshed.g2.bx.psu.edu/repos/proteore/proteore_expression_rnaseq_abbased/rna_abbased_data/2019.03.07 |  |
| 9 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2019.03.11 |  |
| 10 | Query Reactome pathway database | toolshed.g2.bx.psu.edu/repos/proteore/proteore_reactome/reactome_analysis/2018.12.12 |  |
| 11 | GO terms classification and enrichment analysis | toolshed.g2.bx.psu.edu/repos/proteore/proteore_clusterprofiler/cluter_profiler/2019.02.18 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
