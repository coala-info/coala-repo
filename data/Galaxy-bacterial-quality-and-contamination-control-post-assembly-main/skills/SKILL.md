---
name: post-assembly-quality-control-and-contamination-check-for-ba
description: "This bacterial genomics workflow processes assembled contigs and optional paired-end reads using Quast, CheckM2, Kraken2, and Bracken to evaluate assembly quality and taxonomic classification. Use this skill when you need to verify the completeness and contamination levels of a bacterial genome assembly while confirming the taxonomic identity and abundance of species within your sample."
homepage: https://workflowhub.eu/workflows/1882
---

# Post-Assembly Quality Control and Contamination Check for Bacterial Genomes

## Overview

This Galaxy workflow provides a comprehensive assessment of bacterial genome quality and taxonomic purity following assembly. It integrates several industry-standard tools to evaluate the integrity of assembled contigs, ensuring that downstream analyses are based on high-quality, non-contaminated genomic data.

The pipeline executes two primary analytical tracks: genome quality control and taxonomic assignment. It utilizes [Quast](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0) to generate assembly statistics and [CheckM2](https://toolshed.g2.bx.psu.edu/repos/iuc/checkm2/checkm2/1.0.2+galaxy1) to predict genome completeness and contamination levels. Simultaneously, the workflow performs taxonomic classification using [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy1), followed by [Bracken](https://toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0) to refine abundance estimates at the species level.

In the final stage, the workflow employs **ToolDistillator** to aggregate disparate results from the quality and taxonomy tools into a single, parsable JSON file. This centralized output facilitates easier data management and integration into larger bioinformatics pipelines or reporting frameworks.

The workflow is licensed under **GPL-3.0-or-later** and is designed for use in genomics research, specifically within the ABRomics framework for bacterial characterization. Detailed information regarding input requirements and file preparation can be found in the [README.md](README.md) file in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input sequence reads (forward) | data_input | Should be the forward strand of the paired end reads. |
| 1 | Input sequence reads (reverse) | data_input | Should be the reverse strand of the paired end reads. |
| 2 | Fastq boolean | parameter_input | True if fastq metaWF False if fasta metaWF |
| 3 | Fasta boolean | parameter_input | True if fasta metaWF False if fastq metaWF |
| 4 | Input sequence contigs FASTA | data_input | Fasta as contigs from raw reads assembly. |
| 5 | Select a taxonomy database | parameter_input | Select the database to use for assigning taxonomies for Kraken2 and Bracken. |


Ensure your input FASTA files contain assembled contigs, while paired-end FASTQ files are optional but recommended for comprehensive QUAST quality metrics. You should organize multiple samples into paired dataset collections to streamline processing through the Kraken2 and Checkm2 steps. Refer to the README.md for specific details on database selection and parameter toggles for FASTA or FASTQ inputs. For automated execution, you can initialize your configuration using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 | When the fastq metaWF is used, the R1 trimmed file is selected |
| 7 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 | When the fastq metaWF is used, the R2 trimmed file is selected |
| 8 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0 | quast_quality_fasta |
| 9 | checkm2 | toolshed.g2.bx.psu.edu/repos/iuc/checkm2/checkm2/1.0.2+galaxy1 | Checkm2 to predict the completeness and contamination in an assembly |
| 10 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy1 | kraken_taxonomy_assignation |
| 11 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0 | quast_quality_fastq |
| 12 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 13 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 14 | Bracken | toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0 | bracken_abundance_estimation |
| 15 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 16 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 17 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0 | ToolDistillator extracts results from tools and creates a JSON file for each tool |
| 18 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.4+galaxy0 | ToolDistillator summarize groups all JSON file into a unique JSON file |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | Quast HTMl report for FASTA files | report_html |
| 8 | Quast tabular report for FASTA files | report_tabular |
| 9 | Checkm2 tabular report | quality |
| 9 | Checkm2 diamond files | diamond_files |
| 9 | Checkm2 protein files | protein_files |
| 10 | Kraken2 tabular report | report_output |
| 10 | Kraken2 sequence assignation | output |
| 11 | QUAST tabular report for FASTQ files | report_tabular |
| 11 | Quast HTMl report for FASTQ files | report_html |
| 14 | Bracken Kraken tabular report | kraken_report |
| 14 | Bracken tabular report | report |
| 17 | Tooldistillator results control | output_json |
| 18 | Tooldistillator summarize control | summary_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run bacterial_quality_and_contamination_control_post_assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run bacterial_quality_and_contamination_control_post_assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run bacterial_quality_and_contamination_control_post_assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init bacterial_quality_and_contamination_control_post_assembly.ga -o job.yml`
- Lint: `planemo workflow_lint bacterial_quality_and_contamination_control_post_assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `bacterial_quality_and_contamination_control_post_assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
