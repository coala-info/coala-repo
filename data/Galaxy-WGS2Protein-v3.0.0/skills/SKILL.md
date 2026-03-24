---
name: wgs2protein-v300
description: "This Galaxy workflow extracts specific protein-coding sequences from raw paired-end whole genome sequencing reads using Shovill for assembly, Prokka for annotation, and pattern-based selection tools. Use this skill when you need to transform raw genomic data into annotated protein datasets for comparative genomics, phylogenetics, or functional analysis of specific gene families."
homepage: https://workflowhub.eu/workflows/1767
---

# WGS2Protein v3.0.0

## Overview

WGS2Protein v3.0.0 is a Galaxy workflow designed to extract specific protein-coding sequences from raw whole genome sequencing (WGS) data, typically sourced from the [European Nucleotide Archive (ENA)](https://www.ebi.ac.uk/ena). The pipeline automates the transition from raw reads to annotated protein datasets, supporting downstream applications in comparative genomics, phylogenetics, and functional annotation.

The process begins with rigorous quality control and preprocessing, utilizing [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1) and [Trimmomatic](https://toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.39+galaxy2) to clean paired-end reads. These reads are then assembled into contigs using [Shovill](https://toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy2) and annotated via [Prokka](https://toolshed.g2.bx.psu.edu/repos/crs4/prokka/prokka/1.14.6+galaxy1) to identify genomic features and protein sequences.

In the final stages, the workflow converts FASTA annotations into tabular formats to facilitate precise data handling. Users can then apply pattern-based selection to isolate specific protein identifiers of interest. The primary outputs include comprehensive annotation files (GFF, GBK, FAA) and filtered datasets tailored for specialized research needs. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |
| 1 | Input dataset | data_input |  |


Ensure your primary inputs are paired-end raw sequencing reads in compressed FASTQ format (.fastq.gz), typically sourced from the ENA. While the workflow accepts individual datasets, organizing your reads into a paired dataset collection is recommended to streamline processing through Trimmomatic and Shovill. You must also prepare a specific list of protein identifiers for the final selection step, ensuring the syntax matches the Prokka output headers exactly. For automated testing or command-line execution, you can initialize a job template using `planemo workflow_job_init`. Please refer to the README.md for comprehensive details on tool parameters and the specific syntax required for protein extraction.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 3 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.39+galaxy2 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 6 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy2 |  |
| 7 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 8 | Prokka | toolshed.g2.bx.psu.edu/repos/crs4/prokka/prokka/1.14.6+galaxy1 |  |
| 9 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 10 | Select | Grep1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | out_ffn | out_ffn |
| 8 | out_faa | out_faa |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-WGS2Protein_v3.0.0.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-WGS2Protein_v3.0.0.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-WGS2Protein_v3.0.0.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-WGS2Protein_v3.0.0.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-WGS2Protein_v3.0.0.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-WGS2Protein_v3.0.0.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
