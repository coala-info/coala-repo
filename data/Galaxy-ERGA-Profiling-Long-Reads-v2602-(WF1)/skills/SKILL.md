---
name: erga-profiling-long-reads-v2602-wf1
description: "This ERGA workflow profiles trimmed long reads using Meryl, Smudgeplot, and GenomeScope to characterize genomic properties from sequencing data. Use this skill when you need to estimate genome size, heterozygosity, and ploidy levels to determine the complexity of a target organism before de novo assembly."
homepage: https://workflowhub.eu/workflows/603
---

# ERGA Profiling Long Reads v2602 (WF1)

## Overview

This workflow is designed for the initial profiling of long-read sequencing data, specifically optimized for PacBio HiFi or Oxford Nanopore (ONT) reads. As part of the ERGA (European Reference Genome Atlas) pipeline, it utilizes k-mer based analysis to estimate fundamental genomic characteristics—such as genome size, heterozygosity, and repeat content—prior to de novo assembly.

The core analysis begins with [Meryl](https://github.com/marbl/meryl) to generate k-mer counts and frequency distributions from trimmed long reads. These distributions are then processed by [GenomeScope](https://github.com/schatzlab/genomescope) to model the genome's complexity and provide statistical estimates of its structure. Simultaneously, the workflow can run [Smudgeplot](https://github.com/KamilSJaron/smudgeplot) to visualize k-mer pair coverage, which helps in identifying the ploidy level and detecting potential sample contamination or polyploidy.

The pipeline produces a comprehensive set of diagnostic outputs, including linear and logarithmic k-mer plots, smudgeplots for ploidy visualization, and calculated parameters such as transition points and estimated genome size. These results are essential for informing downstream assembly strategies and ensuring data quality within large-scale biodiversity genomics projects.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Trimmed Long Reads collection | data_collection_input |  |
| 1 | kmer length | parameter_input | Kmer length for calculating kmer spectra |
| 2 | Run Smudgeplot? | parameter_input |  |
| 3 | Ploidy | parameter_input | Default ploidy: 2 |


Provide your trimmed long reads (HiFi or ONT) as a dataset collection of fastq files to ensure the Meryl and Smudgeplot steps process the batch correctly. Verify that the k-mer length and ploidy parameters are tailored to your specific sample for accurate genome size and heterozygosity estimation. Consult the README.md for full details on configuring these inputs and interpreting the resulting profiling plots. For automated runs, you can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 5 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 6 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 7 | Smudgeplot | toolshed.g2.bx.psu.edu/repos/galaxy-australia/smudgeplot/smudgeplot/0.2.5+galaxy3 |  |
| 8 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.1.0+galaxy0 |  |
| 9 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy2 |  |
| 10 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 11 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy2 |  |
| 12 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 13 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy2 |  |
| 14 | Cut | Cut1 |  |
| 15 | Cut | Cut1 |  |
| 16 | Convert | Convert characters1 |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | Parse parameter value | param_value_from_file |  |
| 19 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.5+galaxy2 |  |
| 20 | Parse parameter value | param_value_from_file |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | genome_summary | genome_summary |
| 7 | smudgeplot_log | smudgeplot_log |
| 7 | smudgeplot | smudgeplot |
| 7 | genome_summary_verbose | genome_summary_verbose |
| 8 | transformed_log_plot | transformed_log_plot |
| 8 | model | model |
| 8 | summary | summary |
| 8 | model_params | model_params |
| 8 | linear_plot | linear_plot |
| 8 | log_plot | log_plot |
| 8 | transformed_linear_plot | transformed_linear_plot |
| 17 | transition_parameter | integer_param |
| 18 | max_depth | integer_param |
| 20 | genome_size | integer_param |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_Profiling_Long_Reads_v2602_(WF1).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_Profiling_Long_Reads_v2602_(WF1).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_Profiling_Long_Reads_v2602_(WF1).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_Profiling_Long_Reads_v2602_(WF1).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_Profiling_Long_Reads_v2602_(WF1).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_Profiling_Long_Reads_v2602_(WF1).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
