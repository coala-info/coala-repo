---
name: rna-seq-differential-expression-analysis-with-visualization
description: This transcriptomics workflow identifies differentially expressed genes between two experimental conditions using DESeq2, processing count tables and gene annotations to generate filtered results and publication-quality visualizations like volcano plots and heatmaps. Use this skill when you need to statistically compare gene expression levels between a treatment and control group to discover significant biological changes and visualize the distribution of up- and down-regulated genes.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# rna-seq-differential-expression-analysis-with-visualization

## Overview

This Galaxy workflow identifies differentially expressed genes between two experimental conditions (e.g., treatment vs. control) using count tables. It utilizes [DESeq2](https://toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy2) to perform statistical testing and generate normalized counts, making it ideal for transcriptomics studies with at least two replicates per condition.

The pipeline automates the annotation of results using GTF metadata and applies user-defined filters for adjusted p-value and log2 fold change thresholds. Beyond generating filtered gene lists, the workflow produces several publication-quality visualizations, including volcano plots highlighting top significant genes and heatmaps representing log-transformed normalized counts and Z-scores.

Inputs include two collections of count tables, a gene annotation file, and specific threshold parameters. The workflow is released under an [MIT](https://opensource.org/licenses/MIT) license and is tagged for transcriptomics and RNA-seq analysis. For detailed instructions on input preparation and parameter settings, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Counts from changed condition | data_collection_input | Counts from experimental condition or changed condition. For eg. counts from treatment or knockdown samples. |
| 1 | Counts from reference condition | data_collection_input | Counts from reference condition or base condition. For eg. counts from untreated or wildtype samples. |
| 2 | Count files have header | parameter_input | Usually, count files generated from featureCounts tool have a header line whereas count files from RNA-STAR do not have. |
| 3 | Gene Annotaton | data_input | The same annotation GTF used for mapping and counting |
| 4 | Adjusted p-value threshold | parameter_input | Adjusted p-value threshold to call genes as differentially expressed in diagnostic plots. If not set, default 0.05 is used. |
| 6 | log2 fold change threshold | parameter_input | log2 fold change threshold to filter for highly regulated genes. If not set, default 1.0 is used. |


Ensure your input count files are organized into two distinct list collections representing the experimental and reference conditions, typically using tabular or TSV formats. Provide the same GTF annotation file used during quantification to ensure gene attributes like symbols and biotypes are correctly mapped in the final annotated tables. Verify whether your count files contain headers, as this setting must match your data source (e.g., featureCounts vs. RNA-STAR) for successful DESeq2 processing. For comprehensive guidance on setting p-value and log2 fold change thresholds, refer to the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy3 |  |
| 7 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy2 |  |
| 8 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 9 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.5+galaxy3 |  |
| 10 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 11 | Annotate DESeq2/DEXSeq output tables | toolshed.g2.bx.psu.edu/repos/iuc/deg_annotate/deg_annotate/1.1.0+galaxy1 |  |
| 12 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 13 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.5+galaxy3 |  |
| 14 | Parse parameter value | param_value_from_file |  |
| 15 | Filter | Filter1 |  |
| 16 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/4.0.2+galaxy0 |  |
| 17 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 18 | Filter | Filter1 |  |
| 19 | Join two Datasets | join1 |  |
| 20 | Cut | Cut1 |  |
| 21 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.3.0+galaxy0 |  |
| 22 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.3.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | DESeq2 Plots | plots |
| 7 | DESeq2 Normalized Counts | counts_out |
| 13 | Annotated DESeq2 results table | out_file1 |
| 16 | Volcano Plot of DE genes | plot |
| 18 | Significantly differentially expressed genes | out_file1 |
| 21 | Heatmap of log transformed normalized counts | output1 |
| 22 | Heatmap of Z-scores | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rnaseq-de-filtering-plotting.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rnaseq-de-filtering-plotting.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rnaseq-de-filtering-plotting.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rnaseq-de-filtering-plotting.ga -o job.yml`
- Lint: `planemo workflow_lint rnaseq-de-filtering-plotting.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rnaseq-de-filtering-plotting.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)