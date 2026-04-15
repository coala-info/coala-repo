---
name: srna-seq-step-1-read-pre-processing-and-removal-of-artifacts
description: This transcriptomics workflow processes small RNA-seq dataset collections by performing quality control with FastQC, adapter trimming via Trim Galore!, and removal of rRNA and miRNA hairpin artifacts using HISAT2 and Samtools. Use this skill when you need to clean raw sRNA sequencing data by removing sequencing adapters and filtering out non-target RNA contaminants to prepare high-quality reads for downstream expression analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# srna-seq-step-1-read-pre-processing-and-removal-of-artifacts

## Overview

This workflow implements the initial stages of small RNA-seq (sRNA-seq) data analysis, focusing on quality control and the systematic removal of unwanted sequences. It is designed based on the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial for transcriptomics. The process begins with an input dataset collection and reference files for rRNA and miRNA hairpins to ensure downstream analysis focuses on high-quality, relevant small RNA reads.

The pipeline starts with [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to assess raw read quality, followed by adapter trimming using [Trim Galore!](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/). This step is critical for sRNA-seq because the small size of the target molecules often results in sequencing into the adapters. A second round of FastQC is performed immediately after to verify the effectiveness of the trimming and adapter removal.

To isolate the sRNA of interest, the workflow employs a multi-step filtering process using [HISAT2](https://daehwankimlab.github.io/hisat2/) and [SAMtools](http://www.htslib.org/). Reads are aligned against rRNA and miRNA hairpin references; unmapped reads—those that do not match these contaminants—are filtered and converted back to FASTQ format using [bedtools](https://bedtools.readthedocs.io/). This ensures that artifacts and common non-target small RNAs are removed before further biological interpretation.

The final steps involve FASTQ manipulation to refine the dataset and a concluding quality assessment. The workflow outputs include trimmed reads, alignment reports, and comprehensive QC metrics, providing a clean, filtered dataset ready for subsequent mapping and discovery analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |
| 1 | rRNA reference FASTA | data_input |  |
| 2 | miRNA hairpin reference FASTA | data_input | Be sure to use hairpin sequences, not just mature miRNA sequences. |


Ensure your sequencing reads are organized into a dataset collection of fastqsanger files, while providing the rRNA and miRNA hairpin reference sequences in FASTA format. Using collections instead of individual datasets is essential for maintaining sample associations throughout the trimming and filtering stages. For automated execution, you can generate a configuration template using `planemo workflow_job_init` to create a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific tool configurations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.65 |  |
| 4 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.4.2 |  |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.65 |  |
| 6 | HISAT | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.0.3 | Alignment of reads against rRNA sequences to filter them out. |
| 7 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.1.2 | Keep reads that did NOT align to rRNA sequences. |
| 8 | Convert from BAM to FastQ | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtofastq/2.24.0 |  |
| 9 | HISAT | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.0.3 |  |
| 10 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.1.2 | Keep reads that did NOT align to miRNA sequences. |
| 11 | Convert from BAM to FastQ | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtofastq/2.24.0 |  |
| 12 | Manipulate FASTQ | toolshed.g2.bx.psu.edu/repos/devteam/fastq_manipulation/fastq_manipulation/1.0.1 |  |
| 13 | Manipulate FASTQ | toolshed.g2.bx.psu.edu/repos/devteam/fastq_manipulation/fastq_manipulation/1.0.1 |  |
| 14 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.65 |  |
| 15 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.65 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | report_file | report_file |
| 4 | trimmed_reads_single | trimmed_reads_single |
| 5 | html_file | html_file |
| 8 | output | output |
| 11 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run srna-seq-step-1-read-preprocessing-and-removal-of-artifacts.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run srna-seq-step-1-read-preprocessing-and-removal-of-artifacts.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run srna-seq-step-1-read-preprocessing-and-removal-of-artifacts.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init srna-seq-step-1-read-preprocessing-and-removal-of-artifacts.ga -o job.yml`
- Lint: `planemo workflow_lint srna-seq-step-1-read-preprocessing-and-removal-of-artifacts.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `srna-seq-step-1-read-preprocessing-and-removal-of-artifacts.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)