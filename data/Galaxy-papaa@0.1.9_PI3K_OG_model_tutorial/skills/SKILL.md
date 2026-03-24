---
name: papaa019_pi3k_og_model_tutorial
description: "This cancer genomics workflow utilizes the PAPAA tool suite to analyze multi-omic data, including RNA-seq, mutation, and copy number profiles, to classify aberrant pathway activity such as PI3K signaling. Use this skill when you need to identify oncogenic pathway signatures across different cancer types or predict therapeutic responses based on integrated genomic and transcriptomic alterations."
homepage: https://workflowhub.eu/workflows/1605
---

# papaa@0.1.9_PI3K_OG_model_tutorial

## Overview

This workflow implements the PanCancer Aberrant Pathway Activity Analysis (PAPAA) framework, specifically tailored for modeling the PI3K oncogenic pathway. It leverages large-scale multi-omic datasets—including TCGA RNA-seq, mutation, and copy number data—to train machine learning classifiers that predict pathway activation status across various cancer types.

The pipeline utilizes a comprehensive suite of PAPAA tools to perform [classification](https://toolshed.g2.bx.psu.edu/repos/vijay/pancancer_classifier/pancancer_classifier/0.1.9) and within-disease analysis. By processing inputs such as mutation burden and sample freezes, the workflow generates model weights that are applied to external datasets for status prediction. It also includes specialized steps for visualizing decision functions and mapping mutation classes to better understand the genomic drivers of pathway activity.

Beyond primary classification, the workflow integrates cell line data from CCLE and GDSC to perform pharmacological assessments. By predicting pathway activity in cell lines and correlating it with drug sensitivity data, the workflow generates target gene summaries and pathway count heatmaps. This enables researchers to bridge the gap between genomic signatures and therapeutic responses, facilitating the discovery of potential biomarkers in cancer research.

This tutorial is tagged for use in **Statistics**, **Classification**, **Ml**, and **Cancer** research, following the standards of the Galaxy Training Network (GTN).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | pancan_rnaseq_freeze.tsv | data_input |  |
| 1 | pancan_mutation_freeze.tsv | data_input |  |
| 2 | copy_number_loss_status.tsv | data_input |  |
| 3 | copy_number_gain_status.tsv | data_input |  |
| 4 | mutation_burden_freeze.tsv | data_input |  |
| 5 | sample_freeze.tsv | data_input |  |
| 6 | mc3.v0.2.8.PUBLIC.maf | data_input |  |
| 7 | CCLE_DepMap_18Q1_maf_20180207.txt | data_input |  |
| 8 | gdsc1_ccle_pharm_fitted_dose_data.txt | data_input |  |
| 9 | gdsc2_ccle_pharm_fitted_dose_data.txt | data_input |  |
| 10 | GSE69822_pi3k_sign.txt | data_input |  |
| 11 | GSE69822_pi3k_trans.csv | data_input |  |
| 12 | GDSC_CCLE_common_mut_cnv_binary.tsv.gz | data_input |  |
| 13 | ccle_rnaseq_genes_rpkm_20180929_mod.tsv.gz | data_input |  |
| 14 | GDSC_EXP_CCLE_converted_name.tsv.gz | data_input |  |
| 15 | CCLE_MUT_CNA_AMP_DEL_binary_Revealer.tsv | data_input |  |
| 16 | compounds_of_interest.txt | data_input |  |
| 17 | cosmic_cancer_classification.tsv | data_input |  |
| 18 | path_rtk_ras_pi3k_genes.txt | data_input |  |


Ensure all input files are correctly formatted as TSV, CSV, or MAF, paying close attention to compressed `.gz` files which Galaxy handles natively. Since this workflow requires a large volume of distinct datasets ranging from RNA-seq freezes to mutation status files, organizing them into a dedicated history or using specific naming conventions is recommended over generic collections. For automated execution and parameter mapping, you can utilize `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on specific gene lists and compound files required for the PI3K model. Always verify that the sample identifiers are consistent across the expression, mutation, and copy number datasets to ensure accurate classifier performance.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 19 | PAPAA: PanCancer classifier | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_classifier/pancancer_classifier/0.1.9 |  |
| 20 | PAPAA: PanCancer within disease analysis | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_within_disease_analysis/pancancer_within_disease_analysis/0.1.9 |  |
| 21 | PAPAA: PanCancer apply weights | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_apply_weights/pancancer_apply_weights/0.1.9 |  |
| 22 | PAPAA: PanCancer external sample status prediction | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_external_sample_status_prediction/pancancer_external_sample_status_prediction/0.1.9 |  |
| 23 | PAPAA: PanCancer compare within models | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_compare_within_models/pancancer_compare_within_models/0.1.9 |  |
| 24 | PAPAA: PanCancer visualize decisions | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_visualize_decisions/pancancer_visualize_decisions/0.1.9 |  |
| 25 | PAPAA: PanCancer alternative genes pathwaymapper | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_alternative_genes_pathwaymapper/pancancer_alternative_genes_pathwaymapper/0.1.9 |  |
| 26 | PAPAA: PanCancer map mutation class | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_map_mutation_class/pancancer_map_mutation_class/0.1.9 |  |
| 27 | PAPAA: PanCancer pathway count heatmaps | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_pathway_count_heatmaps/pancancer_pathway_count_heatmaps/0.1.9 |  |
| 28 | PAPAA: PanCancer targene summary figures | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_targene_summary_figures/pancancer_targene_summary_figures/0.1.9 |  |
| 29 | PAPAA: PanCancer targene cell line predictions | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_targene_cell_line_predictions/pancancer_targene_cell_line_predictions/0.1.9 |  |
| 30 | PAPAA: PanCancer targene pharmacology | toolshed.g2.bx.psu.edu/repos/vijay/pancancer_targene_pharmacology/pancancer_targene_pharmacology/0.1.9 |  |


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
