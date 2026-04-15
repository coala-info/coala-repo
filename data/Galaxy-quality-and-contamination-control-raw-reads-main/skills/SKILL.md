---
name: raw-read-quality-and-contamination-control-for-genome-assemb
description: This genomics workflow processes short paired-end Illumina reads through quality control, trimming, and taxonomic classification using fastp, Kraken2, and Bracken. Use this skill when you need to assess raw read quality, remove adapters, and identify potential microbial contamination or verify species composition before proceeding with genome assembly.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# raw-read-quality-and-contamination-control-for-genome-assemb

## Overview

This Galaxy workflow provides a comprehensive pipeline for the initial processing of short paired-end reads, focusing on quality control, read cleaning, and taxonomic profiling. It is designed to prepare raw genomic data for downstream applications like genome assembly by ensuring the input is free of adapters, low-quality bases, and unexpected biological contamination.

The process begins with [fastp](https://github.com/OpenGene/fastp) to perform automated trimming and quality filtering, generating both cleaned sequence files and detailed HTML/JSON reports. Following read cleaning, the workflow utilizes [Kraken2](https://github.com/DerrickWood/kraken2) and [Bracken](https://github.com/jenniferlu717/Bracken) to assign taxonomic labels and re-estimate species-level abundance, allowing users to verify the purity of their bacterial samples.

To streamline data management, the workflow incorporates [ToolDistillator](https://github.com/galaxyproject/tools-iuc/tree/master/tools/tooldistillator) to aggregate results from various steps into a single, machine-readable JSON format. This facilitates easier integration with larger bioinformatics pipelines and simplifies the review of quality metrics and taxonomic distributions. Detailed instructions on data preparation and input requirements can be found in the [README.md](./README.md).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input sequence reads (forward) | data_input | Should be the forward strand of the paired end reads. |
| 1 | Input sequence reads (reverse) | data_input | Should be the reverse strand of the paired end reads. |
| 2 | Taxonomy database for Kraken and Bracken | parameter_input | Select the database to use for assigning taxonomies for Kraken2 and Bracken. |


Ensure your input sequence reads are in fastq or fastq.gz format, ideally organized as paired-end collections to streamline processing through the fastp and Kraken2 steps. You must provide a compatible Kraken2/Bracken taxonomy database as a parameter input to ensure accurate species-level abundance estimation. For large-scale automation, consider using `planemo workflow_job_init` to generate a `job.yml` file for managing these inputs. Refer to the README.md for comprehensive details on parameter settings and data preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Zip collections | __ZIP_COLLECTION__ |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy3 | fastp_triming, quality analaysis and read cleaning |
| 5 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 6 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0 | ToolDistillator extracts results from tools and creates a JSON file for each tool |
| 7 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy1 | kraken_taxonomy_assignation |
| 8 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.4+galaxy0 | ToolDistillator summarize groups all JSON file into a unique JSON file |
| 9 | Bracken | toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0 | bracken_abundance_estimation |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | paired_coll | output |
| 4 | fastp_trim_coll | output_paired_coll |
| 4 | fastp_report_json | report_json |
| 4 | fastp_report_html | report_html |
| 5 | fastp_trimmed_R2 | reverse |
| 5 | fastp_trimmed_R1 | forward |
| 6 | tooldistillator_results_control | output_json |
| 7 | kraken_report_tabular | report_output |
| 7 | kraken_report | output |
| 8 | tooldistillator_summarize_control | summary_json |
| 9 | bracken_kraken_report | kraken_report |
| 9 | bracken_report_tsv | report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run quality_and_contamination_control_raw_reads.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run quality_and_contamination_control_raw_reads.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run quality_and_contamination_control_raw_reads.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init quality_and_contamination_control_raw_reads.ga -o job.yml`
- Lint: `planemo workflow_lint quality_and_contamination_control_raw_reads.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `quality_and_contamination_control_raw_reads.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)