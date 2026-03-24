---
name: intro-to-genome-assembly
description: "This genome assembly workflow processes paired-end FASTQ reads using FastQC and MultiQC for quality control, performs de novo assembly with the Velvet suite, and evaluates the resulting contigs against a reference using Quast. Use this skill when you need to reconstruct a microbial genome from raw sequencing data and assess the structural integrity and completeness of the assembled contigs."
homepage: https://workflowhub.eu/workflows/1622
---

# Intro to Genome Assembly

## Overview

This Galaxy workflow provides a foundational introduction to de novo genome assembly using short-read sequencing data. It begins with a quality control phase where raw paired-end reads (`mutant_R1.fastq` and `mutant_R2.fastq`) are analyzed using **FastQC** and aggregated into a comprehensive **MultiQC** report. This ensures the data quality is sufficient before proceeding to the assembly stage.

The core assembly process is performed using the **Velvet** optimizer suite. The workflow first prepares the data by interlacing the paired-end reads and then utilizes **velveth** to construct the k-mer dataset. Subsequently, **velvetg** builds the de Bruijn graph to generate contigs and assembly statistics.

To evaluate the success of the assembly, the workflow incorporates **Quast**. This tool compares the newly assembled contigs against a provided reference genome (`wildtype.fna`), generating detailed reports and metrics to assess the completeness and accuracy of the genome reconstruction. This pipeline is based on the [GTN tutorial](https://training.galaxyproject.org/training-material/topics/assembly/tutorials/general-introduction/tutorial.html) for genome assembly.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mutant_R1.fastq | data_input |  |
| 1 | mutant_R2.fastq | data_input |  |
| 2 | wildtype.fna | data_input |  |


Ensure your input files are correctly formatted as FASTQ for the mutant reads and FASTA or FNA for the wildtype reference to prevent tool execution errors. While this workflow utilizes individual datasets, organizing paired-end reads into a collection can streamline processing in more complex assembly pipelines. Refer to the `README.md` for comprehensive parameter settings and specific data preparation instructions. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 5 | FASTQ interlacer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_paired_end_interlacer/fastq_paired_end_interlacer/1.2.0.1+galaxy0 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 7 | velveth | toolshed.g2.bx.psu.edu/repos/devteam/velvet/velveth/1.2.10.1 |  |
| 8 | velvetg | toolshed.g2.bx.psu.edu/repos/devteam/velvet/velvetg/1.2.10.1 |  |
| 9 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fastqc_html | html_file |
| 3 | fastqc_txt | text_file |
| 5 | output_pairs | outfile_pairs |
| 5 | output_singles | outfile_singles |
| 6 | multiqc_stats | stats |
| 6 | multiqc_report | html_report |
| 7 | velveth_out | out_file1 |
| 8 | velvet_contigs | contigs |
| 8 | velvet_stats | stats |
| 9 | quast_report_html | report_html |
| 9 | quast_report_pdf | report_pdf |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run assembly-general-introduction.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run assembly-general-introduction.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run assembly-general-introduction.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init assembly-general-introduction.ga -o job.yml`
- Lint: `planemo workflow_lint assembly-general-introduction.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `assembly-general-introduction.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
