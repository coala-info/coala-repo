---
name: proteome-annotation
description: This proteomics workflow processes protein lists from LC-MS/MS experiments using ID conversion, tissue-specific expression mapping, GO enrichment, and pathway analysis tools. Use this skill when you need to functionally annotate identified proteins, compare multiple proteomic datasets via Venn diagrams, and identify enriched biological pathways or tissue-specific expression patterns in your samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# proteome-annotation

## Overview

This workflow is designed for the functional annotation of protein lists identified through LC-MS/MS proteomics experiments. It processes multiple input datasets—such as those from Bredberg, Lacombe, and Mucilli—to facilitate comparative analysis and biological interpretation within the Galaxy framework.

The pipeline begins by standardizing data through ID conversion and filtering based on specific keywords or numerical thresholds. It integrates comparative visualization using Venn diagrams and enriches the dataset with tissue-specific expression data sourced from the [Human Protein Atlas](https://www.proteinatlas.org/) and other RNA-seq/antibody-based resources. This allows researchers to contextualize their proteomic findings within specific physiological environments.

For downstream biological insights, the workflow performs Gene Ontology (GO) term classification and enrichment analysis using tools like [ClusterProfiler](https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html). It concludes by querying the [Reactome](https://reactome.org/) pathway database to identify overrepresented biological pathways, providing a comprehensive overview of the functional landscape of the identified proteome. This workflow is particularly useful for [Proteomics](https://training.galaxyproject.org/training-material/topics/proteomics/) researchers following [GTN](https://training.galaxyproject.org/) standards.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Bredberg.txt | data_input |  |
| 1 | Lacombe_et_al_2017_OK.txt | data_input |  |
| 2 | Mucilli.txt | data_input |  |


Ensure your input protein lists are uploaded as tabular or text files, typically containing UniProt accessions or gene symbols compatible with the ID Converter tool. While the workflow uses individual datasets for the Bredberg, Lacombe, and Mucilli files, you may consider using Galaxy collections to streamline the processing of multiple experimental groups. Refer to the README.md for comprehensive details on column formatting and specific tool parameters required for successful annotation. You can also use `planemo workflow_job_init` to create a `job.yml` file for automated execution.

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
| 10 | GO terms classification and enrichment analysis | toolshed.g2.bx.psu.edu/repos/proteore/proteore_clusterprofiler/cluter_profiler/2019.02.18 |  |
| 11 | Query pathway database | toolshed.g2.bx.psu.edu/repos/proteore/proteore_reactome/reactome_analysis/2019.03.05 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow--proteome-annotation-.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow--proteome-annotation-.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow--proteome-annotation-.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow--proteome-annotation-.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow--proteome-annotation-.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow--proteome-annotation-.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)