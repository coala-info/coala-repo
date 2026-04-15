---
name: ngs_tutorial
description: This workflow downloads sequencing accessions and maps them to a reference genome using BWA-MEM, followed by variant calling with LoFreq and functional annotation via SnpEff. Use this skill when you need to identify and annotate genetic variants from raw SRA data to understand the biological impact of mutations in a genomic study.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ngs_tutorial

## Overview

This workflow provides an introductory pipeline for Next-Generation Sequencing (NGS) data analysis, specifically focused on variant calling and data logistics. It begins by retrieving raw sequencing data from the SRA using [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.1.1+galaxy1) based on provided accessions and performing initial quality control and adapter trimming with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.24.0+galaxy4).

Following preprocessing, reads are aligned to a reference genome using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19). The pipeline then executes several refinement steps, including duplicate marking with [Picard](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0) and local realignment and quality adjustment using the [LoFreq](https://toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0) suite to ensure high-quality mapping for downstream analysis.

The final stages involve calling variants with [LoFreq](https://toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy3), followed by functional annotation using [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff_sars_cov_2/snpeff_sars_cov_2/4.5covid19) and [SnpSift](https://toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0). Comprehensive quality reports are generated via [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3), and results are aggregated into a final tabular summary. This [GTN](https://training.galaxyproject.org/) tutorial workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Accessions | data_input | Short Read Archive (SRA) accession to be downloaded using the fasterq-dump utility of the SRA Toolkit from the National Center for Biotechnology Information (NCBI). |
| 1 | Genome | data_input | The genome that reads will be mapped to it. |


Ensure the genome input is in FASTA format and the accessions are provided as a text file or list to facilitate the automated download of sequencing reads. Utilizing dataset collections for paired-end FASTQ files is recommended to maintain data organization throughout the trimming and mapping stages. For comprehensive details on data formatting and tool parameters, please consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.1.1+galaxy1 |  |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.24.0+galaxy4 |  |
| 4 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 5 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.20+galaxy3 |  |
| 6 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0 |  |
| 7 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0 |  |
| 8 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.5 |  |
| 9 | Insert indel qualities | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_indelqual/lofreq_indelqual/2.1.5+galaxy1 |  |
| 10 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 11 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy3 |  |
| 12 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff_sars_cov_2/snpeff_sars_cov_2/4.5covid19 |  |
| 13 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 14 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Log file | log |
| 2 | Unpaired datasets | output_collection_other |
| 2 | Paired-end datasets | list_paired |
| 2 | Single-end datasets | output_collection |
| 3 | Paired-end Collection | output_paired_coll |
| 3 | Report in HTML format | report_html |
| 3 | Report in JSON format | report_json |
| 4 | Mapping BAM output | bam_output |
| 5 | Mapping SAM output | outputsam |
| 6 | MarkDuplicates BAM | outFile |
| 6 | MarkDuplicates Metrics | metrics_file |
| 7 | Realigned reads BAM file | realigned |
| 8 | Statistics for BAM dataset | output |
| 9 | Realigned BAM dataset with indel qualities | output |
| 10 | MultiQC Stat table | stats |
| 10 | MultiQC HTML report | html_report |
| 11 | All called variants | variants |
| 12 | HTML summary of results  | statsFile |
| 12 | Variant dataset with added variant effects | snpeff_output |
| 13 | Variant dataset with added variant effects in tabular format | output |
| 14 | Summarized variant analysis result dataset | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ngs-tutorial.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ngs-tutorial.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ngs-tutorial.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ngs-tutorial.ga -o job.yml`
- Lint: `planemo workflow_lint ngs-tutorial.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ngs-tutorial.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)