---
name: proteomics-database-handling-including-mycoplasma
description: This proteomics workflow downloads multiple protein FASTA databases, merges them into a filtered unique sequence set, and generates a decoy database using the Protein Database Downloader and DecoyDatabase tools. Use this skill when you need to construct a comprehensive search database that includes mycoplasma contaminants and decoy sequences for false discovery rate estimation in mass spectrometry data analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# proteomics-database-handling-including-mycoplasma

## Overview

This workflow automates the construction of customized protein FASTA databases for proteomics research. It is specifically designed to aggregate protein sequences from multiple sources, including host organisms and potential contaminants such as mycoplasma. By integrating these diverse sequences, the workflow ensures a comprehensive search space for mass spectrometry data analysis.

The pipeline utilizes several instances of the [Protein Database Downloader](https://toolshed.g2.bx.psu.edu/view/galaxyp/dbbuilder) to fetch sequences from public repositories. These sequences are then processed through format conversions (FASTA-to-Tabular and back) to allow for the addition of specific metadata or tags. The workflow merges these files while filtering for unique sequences to maintain a non-redundant database.

In the final stages, the workflow employs the [DecoyDatabase](https://toolshed.g2.bx.psu.edu/view/galaxyp/openms_decoydatabase) tool to generate and append decoy sequences to the merged FASTA file. This final output is essential for estimating the False Discovery Rate (FDR) during protein identification, providing a robust foundation for downstream [Proteomics](https://training.galaxyproject.org/training-material/topics/proteomics/) bioinformatics tasks.

## Inputs and data preparation

_None listed._


Ensure all input sequences are in FASTA format or provided via specific Taxon IDs for the automated downloader tools to ensure compatibility. While individual FASTA datasets are used here to build the composite database, organizing multiple proteomes into a dataset collection can streamline the merging and filtering process. Verify that your tabular conversions maintain consistent header formatting to prevent errors during the final decoy database generation. Refer to the README.md for comprehensive instructions on configuring specific mycoplasma strains and decoy parameters. You can automate the configuration of these input parameters by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 1 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 2 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 3 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 4 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 5 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 6 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 7 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 8 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 9 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 10 | Add column | addValue |  |
| 11 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 12 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 13 | Add column | addValue |  |
| 14 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 15 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 16 | DecoyDatabase | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_decoydatabase/DecoyDatabase/2.6+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output_database | output_database |
| 1 | output_database | output_database |
| 2 | output_database | output_database |
| 3 | output_database | output_database |
| 4 | output_database | output_database |
| 5 | output_database | output_database |
| 6 | output_database | output_database |
| 7 | output_database | output_database |
| 8 | output | output |
| 9 | output | output |
| 10 | out_file1 | out_file1 |
| 11 | output | output |
| 12 | output | output |
| 13 | out_file1 | out_file1 |
| 14 | output | output |
| 15 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf-database-handling-mycoplasma.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf-database-handling-mycoplasma.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf-database-handling-mycoplasma.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf-database-handling-mycoplasma.ga -o job.yml`
- Lint: `planemo workflow_lint wf-database-handling-mycoplasma.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf-database-handling-mycoplasma.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)