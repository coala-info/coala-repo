---
name: from-bams-to-drug-resistance-prediction-with-tb-profiler
description: "This Galaxy workflow processes single-end and paired-end Mycobacterium tuberculosis BAM files using Samtools and TB-Profiler to generate a comprehensive summary table of drug-resistance profiles. Use this skill when you need to identify genetic markers of antibiotic resistance and predict phenotypic susceptibility for multiple Mycobacterium tuberculosis isolates from alignment data."
homepage: https://workflowhub.eu/workflows/1564
---

# From BAMs to drug resistance prediction with TB-profiler

## Overview

This workflow is designed to predict drug resistance in *Mycobacterium tuberculosis* (MTB) starting from alignment data. It accepts both single-end and paired-end BAM files—typically those produced by tools like Snippy—and merges them into a unified collection for streamlined downstream processing.

The core analysis is performed by [TB-Profiler](https://github.com/jodyphelan/TB-Profiler), which compares genomic variants against a curated database to identify lineages and resistance-associated mutations. Before profiling, the workflow utilizes [Samtools](https://www.htslib.org/) and text transformation tools to filter and prepare the alignments, ensuring the input data meets the requirements for accurate prediction.

Following the profiling step, the workflow automates the aggregation of individual sample results. It extracts relevant data using grep, appends sample names to the records, and concatenates the findings into a single, consolidated dataset. The final output is a formatted table that summarizes the drug-resistance profiles across all input samples.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this tool is categorized under Evolution and provides a robust pipeline for transitioning from raw sequence alignments to actionable resistance summaries.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | MTB single-end BAMs | data_collection_input | BAMs obtained from single-end mappings with snippy |
| 1 | MTB paired-end BAMs | data_collection_input | BAMs obtained from paired-end mappings with snippy |


Ensure your input BAM files are organized into data collections to allow the workflow to process multiple single-end and paired-end samples simultaneously. Verify that all BAM files are properly indexed and contain valid header information, as these are essential for the downstream TB-profiler analysis. For large-scale batch processing, you can use `planemo workflow_job_init` to generate a `job.yml` file for automated parameter configuration. Refer to the accompanying README.md for comprehensive details on sample naming conventions and specific tool parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Merge collections | __MERGE_COLLECTION__ | Merge single-end and paired-end BAMs in a single collection to be analyzed alltogether |
| 3 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.13+galaxy2 | We want a text (SAM) file to substitute the string "MTB_anc" by "Chromosome" so it is compatible with TB-profiler |
| 4 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 | Change the string MTB_anc to "Chromosome" so it is compatible with TB-profiler |
| 5 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.13+galaxy2 |  |
| 6 | TB-Profiler Profile | toolshed.g2.bx.psu.edu/repos/iuc/tbprofiler/tb_profiler_profile/3.0.8+galaxy0 | Generate TB-profiler reports with drug resistance determinants |
| 7 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 | From TB profiler, search with `grep` the part of the text that describes the DR profile (e.g Drug-Resistance: MDR) |
| 8 | Add input name as column | toolshed.g2.bx.psu.edu/repos/mvdbeek/add_input_name_as_column/addName/0.2.0 | We have generated one file per sample, that contains the DR profile (e.g Drug-Resistance: MDR) We want to prepend the name of the sample so we have: (Sample_name Drug-Resistance: MDR) |
| 9 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 | The output will be: Sample_A  DR_profile_A Sample_B DR_profile_B Sample_Z DR_profile_Z |
| 10 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 | Remove unnecessary text from the table like ".txt" or "Drug-resistance:" |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | output | output |
| 3 | Samtools view on input dataset(s): filtered alignments | outputsam |
| 4 | output | output |
| 5 | outputsam | outputsam |
| 6 | output_vcf | output_vcf |
| 6 | output_txt | output_txt |
| 6 | results_json | results_json |
| 7 | output | output |
| 8 | output | output |
| 9 | out_file1 | out_file1 |
| 10 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-from-bams-to-drug-resistance-prediction-with-tb-profiler.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-from-bams-to-drug-resistance-prediction-with-tb-profiler.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-from-bams-to-drug-resistance-prediction-with-tb-profiler.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-from-bams-to-drug-resistance-prediction-with-tb-profiler.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-from-bams-to-drug-resistance-prediction-with-tb-profiler.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-from-bams-to-drug-resistance-prediction-with-tb-profiler.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
