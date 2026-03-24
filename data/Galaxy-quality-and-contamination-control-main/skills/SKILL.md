---
name: quality-and-contamination-control-for-genome-assembly
description: "This genomics workflow processes paired-end Illumina FASTQ reads to perform quality control, trimming, and taxonomic classification using fastp, Kraken2, Bracken, and Recentrifuge. Use this skill when you need to evaluate the purity of bacterial sequencing data, remove low-quality sequences, and identify potential contaminants before proceeding with genome assembly."
homepage: https://workflowhub.eu/workflows/1052
---

# Quality and Contamination Control For Genome Assembly

## Overview

This workflow provides a comprehensive pipeline for the quality control and taxonomic assessment of short paired-end sequence reads, specifically optimized for bacterial genomics. It begins by utilizing [fastp](https://github.com/OpenGene/fastp) to perform automated read trimming and quality filtering, ensuring that only high-quality data proceeds to downstream analysis.

Following read cleaning, the workflow identifies the taxonomic composition of the sample to detect potential contamination. It employs [Kraken2](https://github.com/DerrickWood/kraken2) for initial classification, followed by [Bracken](https://github.com/jenniferlu717/Bracken) to re-estimate abundances at the species level. The results are visualized using [Recentrifuge](https://github.com/khyox/recentrifuge), which generates interactive Krona charts to illustrate the species diversity within the sample.

To streamline data management, the workflow uses [ToolDistillator](https://github.com/iuc-knime-galaxy/tooldistillator) to extract and aggregate metrics from all tools into a single, machine-readable JSON file. This facilitates easy integration with larger bioinformatics pipelines or reporting systems. Detailed information on input requirements and file preparation can be found in the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input sequence reads (forward) | data_input | Should be the forward strand of the paired end reads. |
| 1 | Input sequence reads (reverse) | data_input | Should be the reverse strand of the paired end reads. |
| 2 | Select a taxonomy database | parameter_input | Select the database to use for assigning taxonomies for Kraken2 and Bracken. |
| 3 | Select a NCBI taxonomy database | parameter_input | Select the ncbi taxonomy database for Recentrifuge. |


Ensure your input sequence reads are provided in fastq or fastq.gz format, specifically as paired-end Illumina data. While individual datasets are supported, organizing your reads into a paired dataset collection is highly recommended to facilitate the internal zipping and unzipping steps. You must also ensure that the selected Kraken2 and NCBI taxonomy databases are correctly matched to your study's taxonomic scope. Please refer to the README.md for exhaustive details on input preparation and specific tool configurations. For automated execution, you may use `planemo workflow_job_init` to generate a `job.yml` file for your input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Zip collections | __ZIP_COLLECTION__ |  |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.26.0+galaxy0 | fastp_triming, quality analaysis and read cleaning |
| 6 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 7 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy1 | kraken_taxonomy_assignation |
| 8 | Bracken | toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0 | bracken_abundance_estimation |
| 9 | Recentrifuge | toolshed.g2.bx.psu.edu/repos/iuc/recentrifuge/recentrifuge/1.16.1+galaxy0 | recentrifuge_taxonomy_visualization |
| 10 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/0.9.3+galaxy0 | ToolDistillator extracts results from tools and creates a JSON file for each tool |
| 11 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/0.9.3+galaxy0 | ToolDistillator summarize groups all JSON file into a unique JSON file |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | paired_coll | output |
| 5 | fastp_report_html | report_html |
| 5 | fastp_trim_coll | output_paired_coll |
| 5 | fastp_report_json | report_json |
| 6 | fastp_trimmed_R2 | reverse |
| 6 | fastp_trimmed_R1 | forward |
| 7 | kraken_report_reads | output |
| 7 | kraken_report_tabular | report_output |
| 8 | bracken_kraken_report | kraken_report |
| 8 | bracken_report_tsv | report |
| 9 | recentrifuge_logfile | logfile |
| 9 | recentrifuge_data_tabular | data_tsv |
| 9 | recentrifuge_report_html | html_report |
| 9 | recentrifuge_stats_tabular | stat_tsv |
| 10 | tooldistillator_results_control | output_json |
| 11 | tooldistillator_summarize_control | summary_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run quality_and_contamination_control.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run quality_and_contamination_control.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run quality_and_contamination_control.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init quality_and_contamination_control.ga -o job.yml`
- Lint: `planemo workflow_lint quality_and_contamination_control.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `quality_and_contamination_control.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
