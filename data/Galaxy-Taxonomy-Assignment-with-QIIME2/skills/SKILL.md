---
name: taxonomy-assignment-with-qiime2
description: "This Galaxy workflow performs taxonomic assignment for microbiome studies by processing biom2 feature tables and representative sequences using QIIME2 tools to train and apply a Naive Bayes classifier against reference databases. Use this skill when you need to characterize the microbial community structure of amplicon sequencing samples by identifying the specific taxa associated with detected operational taxonomic units or amplicon sequence variants."
homepage: https://workflowhub.eu/workflows/2098
---

# Taxonomy Assignment with QIIME2

## Overview

This Galaxy workflow performs taxonomic assignment for amplicon data using QIIME2. It processes an input OTU/ASV Feature Table (in `biom2` format) and a set of Representative Sequences against a reference taxonomic database such as [HOMD](https://www.homd.org), [SILVA](https://www.arb-silva.de), [PR2](https://pr2-database.org), or [UNITE](https://unite.ut.ee).

The pipeline automates the creation and training of a QIIME2 Naive Bayes classifier. It extracts reference reads based on user-defined forward and reverse primer sequences, trains the classifier, and then assigns taxonomy to the sample sequences using the `classify-sklearn` method. 

In addition to taxonomic classification, the workflow generates several visualization and summary files. These include interactive QIIME2 visualizations for the feature table and representative sequences, as well as a taxonomy bar plot. The final output is a comprehensive CSV table that combines the original ASV counts with their assigned taxonomy and classification confidence.

This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Feature Table (biom2) | data_input | Input feature table in biom2 format (e.g. as produced by "qiime2 dada2 denoise-paired"). |
| 1 | Representative Sequences (fasta) | data_input | Input representative sequences in fasta format (e.g. as produced by "qiime2 dada2 denoise-paired"). |
| 2 | Reference Taxonomy (tabular) | data_input | Input reference database reference taxonomy in tabular format. |
| 3 | Reference Sequences (fasta) | data_input | Input reference database reference sequences in fasta format. |
| 4 | Forward Primer Sequence | parameter_input | Forward primer sequence (5' -&gt; 3'). Required for "qiime2 feature-classifier extract-reads" (input parameter: f_primer).   **Default value is the primer for the 16S rRNA V3-V4 region. |
| 5 | Reverse Primer Sequence | parameter_input | Reverse primer sequence (5' -&gt; 3'). Required for "qiime2 feature-classifier extract-reads" (input parameter: r_primer).  **Default value is the primer for the 16S rRNA V3-V4 region. |


To prepare your data for this workflow, ensure your Feature Table is in `biom2` format and your Representative Sequences and reference database are in `fasta` format. You must also provide a reference taxonomy in `tabular` format and specify the correct forward and reverse primer sequences for the targeted amplicon region. While this workflow processes individual datasets, ensure all files are correctly labeled to match the expected inputs for the QIIME2 classifiers. For a comprehensive guide on parameter settings and database compatibility, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | qiime2 tools import | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2_core__tools__import/qiime2_core__tools__import/2023.5.0+dist.h193f7cc9.3 |  |
| 7 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |
| 8 | qiime2 tools import | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2_core__tools__import/qiime2_core__tools__import/2023.5.0+dist.h193f7cc9.3 |  |
| 9 | qiime2 tools import | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2_core__tools__import/qiime2_core__tools__import/2023.5.0+dist.h193f7cc9.3 |  |
| 10 | qiime2 tools import | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2_core__tools__import/qiime2_core__tools__import/2023.5.0+dist.h193f7cc9.3 |  |
| 11 | qiime2 feature-table summarize | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__feature_table__summarize/qiime2__feature_table__summarize/2023.5.0+q2galaxy.2023.5.0.2 |  |
| 12 | Remove beginning | Remove beginning1 |  |
| 13 | qiime2 feature-table tabulate-seqs | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__feature_table__tabulate_seqs/qiime2__feature_table__tabulate_seqs/2023.5.0+q2galaxy.2023.5.0.2 |  |
| 14 | qiime2 feature-classifier extract-reads | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__feature_classifier__extract_reads/qiime2__feature_classifier__extract_reads/2023.5.0+q2galaxy.2023.5.0.2 |  |
| 15 | QIIME vizualisation extractor | toolshed.g2.bx.psu.edu/repos/iuc/qiime_extract_viz/qiime_extract_viz/0.1.0+galaxy0 |  |
| 16 | QIIME vizualisation extractor | toolshed.g2.bx.psu.edu/repos/iuc/qiime_extract_viz/qiime_extract_viz/0.1.0+galaxy0 |  |
| 17 | qiime2 feature-classifier fit-classifier-naive-bayes | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__feature_classifier__fit_classifier_naive_bayes/qiime2__feature_classifier__fit_classifier_naive_bayes/2023.5.0+q2galaxy.2023.5.0.2 |  |
| 18 | qiime2 feature-classifier classify-sklearn | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__feature_classifier__classify_sklearn/qiime2__feature_classifier__classify_sklearn/2023.5.0+q2galaxy.2023.5.0.2 |  |
| 19 | qiime2 tools export | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2_core__tools__export/qiime2_core__tools__export/2023.5.0+dist.h193f7cc9.2 |  |
| 20 | qiime2 taxa barplot | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__taxa__barplot/qiime2__taxa__barplot/2023.5.0+q2galaxy.2023.5.0.2 |  |
| 21 | Convert tabular to CSV | tabular_to_csv |  |
| 22 | Convert CSV to tabular | csv_to_tabular |  |
| 23 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/9.5+galaxy2 |  |
| 24 | Convert tabular to CSV | tabular_to_csv |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 15 | Feature Table Summary | viz |
| 16 | Representative Sequences Summary | viz |
| 20 | Visualise Taxa Bar Plot | visualization |
| 24 | Combined OTU Table | csv |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Taxonomy-Assignment-with-QIIME2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Taxonomy-Assignment-with-QIIME2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Taxonomy-Assignment-with-QIIME2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Taxonomy-Assignment-with-QIIME2.ga -o job.yml`
- Lint: `planemo workflow_lint Taxonomy-Assignment-with-QIIME2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Taxonomy-Assignment-with-QIIME2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
