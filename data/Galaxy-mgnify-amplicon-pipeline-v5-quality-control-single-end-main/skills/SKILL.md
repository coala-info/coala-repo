---
name: mgnifys-amplicon-pipeline-v50-quality-control-se
description: "This metagenomics workflow performs quality control on single-end amplicon reads using Trimmomatic for trimming, PRINSEQ for ambiguity filtering, and FastQC and MultiQC for data visualization. Use this skill when you need to remove low-quality bases, short sequences, and excessive ambiguous reads from single-end environmental DNA samples to ensure reliable downstream taxonomic profiling."
homepage: https://workflowhub.eu/workflows/1271
---

# MGnify's amplicon pipeline v5.0 - Quality control SE

## Overview

This Galaxy workflow implements the quality control subworkflow for single-end reads as defined in [MGnify's amplicon pipeline v5.0](https://www.ebi.ac.uk/metagenomics/). It is designed to process raw single-end amplicon sequences through a series of rigorous filtering and trimming steps to ensure high-quality data for downstream taxonomic analysis.

The pipeline utilizes [Trimmomatic](https://github.com/usadellab/Trimmomatic) for adapter removal and quality trimming via a sliding window approach, followed by [Filter FASTQ](https://github.com/galaxyproject/tools-devteam/tree/master/tool_collections/fastq/fastq_filter) to enforce minimum length requirements. Additionally, [PRINSEQ](http://prinseq.sourceforge.net/) is employed for ambiguity filtering, removing sequences that exceed a specified threshold of "N" bases.

Comprehensive quality assessment is integrated throughout the process using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) at multiple stages. The workflow concludes by converting the processed reads into FASTA format and generating a consolidated [MultiQC](https://multiqc.info/) report, providing a detailed overview of the sequence statistics and the impact of the quality control measures.

This workflow is licensed under Apache-2.0 and is tagged for use in metagenomics and amplicon sequencing projects within the microgalaxy community.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Single-end reads | data_collection_input | Single-end reads collection. |
| 1 | Trimmomatic - SLIDING WINDOW - Average quality required | parameter_input | Average quality required. |
| 2 | Trimmomatic - LEADING | parameter_input | Cut bases off the start of a read, if below a threshold quality. |
| 3 | Trimmomatic - SLIDING WINDOW - Number of bases to average across | parameter_input | Number of bases to average across. |
| 4 | Trimmomatic - TRAILING | parameter_input | Cut bases off the end of a read, if below a threshold quality. |
| 5 | Trimmomatic - MINLEN | parameter_input | Minimum length of reads to be kept. |
| 6 | Length filtering - Minimum size | parameter_input | Minimum sequence length. |
| 7 | Ambiguity filtering - Maximal N percentage threshold to conserve sequences | parameter_input | Maximal N percentage threshold to conserve sequences. |


For optimal results, provide single-end reads in FASTQ format (Phred33) organized as a data collection to ensure the workflow processes all samples in parallel. Adjust the Trimmomatic and PRINSEQ parameters based on your specific library quality, particularly the minimum length and N-percentage thresholds, to avoid over-filtering. Detailed descriptions of each parameter and expected file formats are available in the README.md. For automated execution or testing, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 9 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.39+galaxy2 |  |
| 10 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 11 | Filter FASTQ | toolshed.g2.bx.psu.edu/repos/devteam/fastq_filter/fastq_filter/1.1.5+galaxy2 |  |
| 12 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 13 | PRINSEQ | toolshed.g2.bx.psu.edu/repos/iuc/prinseq/prinseq/0.20.4+galaxy2 |  |
| 14 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 15 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 16 | FASTQ to FASTA | toolshed.g2.bx.psu.edu/repos/devteam/fastqtofasta/fastq_to_fasta_python/1.1.5+galaxy2 |  |
| 17 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 18 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 19 | FASTA Width | toolshed.g2.bx.psu.edu/repos/devteam/fasta_formatter/cshl_fasta_formatter/1.0.1+galaxy2 |  |
| 20 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 21 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 19 | Single-end post quality control FASTA files | output |
| 21 | Single-end MultiQC statistics | stats |
| 21 | Single-end MultiQC report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mgnify-amplicon-pipeline-v5-quality-control-single-end.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mgnify-amplicon-pipeline-v5-quality-control-single-end.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mgnify-amplicon-pipeline-v5-quality-control-single-end.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mgnify-amplicon-pipeline-v5-quality-control-single-end.ga -o job.yml`
- Lint: `planemo workflow_lint mgnify-amplicon-pipeline-v5-quality-control-single-end.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mgnify-amplicon-pipeline-v5-quality-control-single-end.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
