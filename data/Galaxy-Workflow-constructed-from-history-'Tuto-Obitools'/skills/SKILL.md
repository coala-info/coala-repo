---
name: workflow-constructed-from-history-tuto-obitools
description: This ecology workflow processes raw metabarcoding sequence data from compressed archives using the OBITools suite and NCBI BLAST+ to perform sequence filtering, taxonomic assignment, and data cleaning. Use this skill when you need to analyze environmental DNA samples to identify species composition and biodiversity through high-throughput sequencing data processing.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-tuto-obitools

## Overview

This workflow provides a comprehensive pipeline for metabarcoding and environmental DNA (eDNA) analysis using the [OBITools](https://metabarcoding.org/obitools) suite. Designed for ecological research and aligned with [GTN](https://training.galaxyproject.org/) training standards, it automates the transition from raw sequencing reads to taxonomically assigned sequence tables.

The process begins with data preparation, including unzipping raw inputs and performing quality control via FastQC and FASTQ Groomer. It then executes core OBITools functions: merging paired-end reads with `obi_illumina_pairend`, demultiplexing samples using `obi_ngsfilter`, and performing dereplication with `obi_uniq`. These steps ensure that only high-quality, unique sequences are retained for downstream analysis.

To refine the dataset, the workflow employs `obi_clean` to identify and remove PCR errors or chimeras, alongside various `obigrep` steps for attribute-based filtering. Taxonomic identification is handled by integrating `NCBI BLAST+ blastn`, which compares the processed sequences against reference databases to provide biological context.

In the final stages, the workflow converts complex OBITools outputs into user-friendly formats using `obitab`. It utilizes data manipulation tools like `Join`, `Cut`, and `Filter` to generate clean, tabular datasets ready for ecological interpretation and statistical analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | wolf_tutorial.zip?download=1 | data_input |  |


Ensure your primary input is a compressed ZIP archive containing the raw sequence data, which the workflow will automatically unzip and groom into the required FASTQ format. For metabarcoding success, ensure your NGSfilter sample description file is correctly formatted as a tabular dataset to allow for accurate demultiplexing of the pooled reads. While the workflow starts with a single dataset, it is designed to handle the complex outputs of eDNA pipelines efficiently. Please consult the README.md for exhaustive details on input specifications and tool parameters. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined command-line execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Illuminapairedend | toolshed.g2.bx.psu.edu/repos/iuc/obi_illumina_pairend/obi_illumina_pairend/1.2.13 |  |
| 2 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/0.2 |  |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 4 | FASTQ Groomer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_groomer/fastq_groomer/1.1.5 |  |
| 5 | obigrep | toolshed.g2.bx.psu.edu/repos/iuc/obi_grep/obi_grep/1.2.13 |  |
| 6 | Line/Word/Character count | wc_gnu |  |
| 7 | Line/Word/Character count | wc_gnu |  |
| 8 | NGSfilter | toolshed.g2.bx.psu.edu/repos/iuc/obi_ngsfilter/obi_ngsfilter/1.2.13 |  |
| 9 | obiuniq | toolshed.g2.bx.psu.edu/repos/iuc/obi_uniq/obi_uniq/1.2.13 |  |
| 10 | obiannotate | toolshed.g2.bx.psu.edu/repos/iuc/obi_annotate/obi_annotate/1.2.13 |  |
| 11 | obistat | toolshed.g2.bx.psu.edu/repos/iuc/obi_stat/obi_stat/1.2.13 |  |
| 12 | obigrep | toolshed.g2.bx.psu.edu/repos/iuc/obi_grep/obi_grep/1.2.13 |  |
| 13 | obigrep | toolshed.g2.bx.psu.edu/repos/iuc/obi_grep/obi_grep/1.2.13 |  |
| 14 | obiclean | toolshed.g2.bx.psu.edu/repos/iuc/obi_clean/obi_clean/1.2.13 |  |
| 15 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy0 |  |
| 16 | Filter sequences by ID | toolshed.g2.bx.psu.edu/repos/peterjc/seq_filter_by_id/seq_filter_by_id/0.2.7 |  |
| 17 | Filter sequences by ID | toolshed.g2.bx.psu.edu/repos/peterjc/seq_filter_by_id/seq_filter_by_id/0.2.7 |  |
| 18 | obitab | toolshed.g2.bx.psu.edu/repos/iuc/obi_tab/obi_tab/1.2.13 |  |
| 19 | obitab | toolshed.g2.bx.psu.edu/repos/iuc/obi_tab/obi_tab/1.2.13 |  |
| 20 | Join two Datasets | join1 |  |
| 21 | Join two Datasets | join1 |  |
| 22 | Cut | Cut1 |  |
| 23 | Filter | Filter1 |  |


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