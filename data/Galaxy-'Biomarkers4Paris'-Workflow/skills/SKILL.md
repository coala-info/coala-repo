---
name: biomarkers4paris-workflow
description: This proteomics workflow identifies biomarker candidates by integrating tissue-specific expression data from HPA and MS/MS observations from PeptideAtlas using ProteoRE tools and Venn diagrams. Use this skill when you need to prioritize potential protein biomarkers by cross-referencing experimental data with tissue-specific expression profiles and functional protein features.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# biomarkers4paris-workflow

## Overview

The 'Biomarkers4Paris' workflow is a specialized [Proteomics](https://training.galaxyproject.org/training-material/topics/proteomics/) pipeline designed for the identification of potential biomarker candidates. It utilizes the [ProteoRE](https://toolshed.g2.bx.psu.edu/view/proteore/) toolset within Galaxy to integrate multi-omic data and refine protein lists based on tissue specificity and experimental evidence.

The process begins by retrieving and building tissue-specific expression datasets from the Human Protein Atlas (HPA). It employs iterative filtering steps—using both keywords and numerical values—to narrow down candidates. The workflow also incorporates RNA-seq and antibody-based expression data to validate the presence of proteins across different biological contexts, using Venn diagrams to visualize overlaps between datasets.

To further characterize the candidates, the workflow performs ID conversion and adds detailed protein features. It cross-references these findings with MS/MS observations from [PeptideAtlas](http://www.peptideatlas.org/) to confirm the detectability of proteins in specific tissues or fluids. This structured approach allows researchers to transition from broad expression data to a highly curated list of biomarkers.

This workflow is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and provides a reproducible framework for biomarker discovery in clinical proteomics.

## Inputs and data preparation

_None listed._


To run this proteomics workflow effectively, ensure your input lists are in tabular or text format, typically containing UniProt accessions or gene symbols for the ID conversion and filtering steps. Since the workflow relies on ProteoRE tools to retrieve tissue-specific expression and protein features, verify that your input datasets are correctly typed as 'tabular' to allow seamless column selection. For large-scale analyses, organizing your inputs into Galaxy collections can streamline the execution of filtering and Venn diagram steps. Detailed parameter settings and specific column requirements are documented in the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Build tissue-specific expression dataset | toolshed.g2.bx.psu.edu/repos/proteore/proteore_tissue_specific_expression_data/retrieve_from_hpa/2019.02.27 |  |
| 1 | Build tissue-specific expression dataset | toolshed.g2.bx.psu.edu/repos/proteore/proteore_tissue_specific_expression_data/retrieve_from_hpa/2019.02.27 |  |
| 2 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2019.03.05 |  |
| 3 | Venn diagram | toolshed.g2.bx.psu.edu/repos/proteore/proteore_venn_diagram/Jvenn/2018.12.18 |  |
| 4 | Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.0.0 |  |
| 5 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2019.03.05 |  |
| 6 | Add expression data | toolshed.g2.bx.psu.edu/repos/proteore/proteore_expression_rnaseq_abbased/rna_abbased_data/2019.03.07 |  |
| 7 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2019.03.05 |  |
| 8 | ID Converter | toolshed.g2.bx.psu.edu/repos/proteore/proteore_id_converter/IDconverter/2019.01.28 |  |
| 9 | Add protein features | toolshed.g2.bx.psu.edu/repos/proteore/proteore_prot_features/prot_features/2019.01.18 |  |
| 10 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2019.03.05 |  |
| 11 | Get MS/MS observations in tissue/fluid | toolshed.g2.bx.psu.edu/repos/proteore/proteore_ms_observation_pepatlas/retr_pepatlas1/2019.02.01.1 |  |
| 12 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2019.03.05 |  |


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