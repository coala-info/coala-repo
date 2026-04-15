---
name: taxonomic-analysis-of-edna
description: This workflow processes paired-end eDNA FASTQ files through quality control with fastp and sequence alignment using NCBI BLAST+ to generate a taxonomic count table. Use this skill when you need to identify and quantify the biodiversity of environmental samples by mapping genetic sequences to known taxonomic groups.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# taxonomic-analysis-of-edna

## Overview

This workflow performs taxonomic classification on environmental DNA (eDNA) samples to identify biological diversity within an ecosystem. It processes paired-end sequencing data, starting with quality control and preprocessing via [fastp](https://github.com/OpenGene/fastp). The cleaned sequences are then converted from FASTQ to FASTA format to prepare them for alignment.

The core analysis utilizes [NCBI BLAST+ blastn](https://blast.ncbi.nlm.nih.gov/Blast.cgi) to compare the eDNA sequences against reference databases. By aligning the sample reads to known sequences, the workflow identifies the various taxa present in the environmental sample.

The final output is a summarized table listing the identified taxa and the count of sequences aligned to each. This structured data is ideal for ecological visualization, such as creating pie charts to represent the taxonomic composition of the sample. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and aligns with [GTN](https://training.galaxyproject.org/) standards for ecology and metagenomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HP3_S9_L001_R1_001.fastq.gz | data_input |  |
| 1 | HP3_S9_L001_R2_001.fastq.gz | data_input |  |


Ensure your input files are in compressed FASTQ format (`.fastq.gz`), as the workflow is optimized for paired-end sequencing data. While individual datasets are supported, organizing your paired reads into a dataset collection will streamline the execution of the `fastp` and `blastn` steps. Refer to the `README.md` for comprehensive details on specific parameter configurations and the required reference databases for taxonomic assignment. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.24.1+galaxy0 |  |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.24.1+galaxy0 |  |
| 4 | FASTQ to FASTA | toolshed.g2.bx.psu.edu/repos/devteam/fastq_to_fasta/cshl_fastq_to_fasta/1.0.2+galaxy2 |  |
| 5 | FASTQ to FASTA | toolshed.g2.bx.psu.edu/repos/devteam/fastq_to_fasta/cshl_fastq_to_fasta/1.0.2+galaxy2 |  |
| 6 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.16.0+galaxy0 |  |
| 7 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.16.0+galaxy0 |  |
| 8 | Count | Count1 |  |
| 9 | Count | Count1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)