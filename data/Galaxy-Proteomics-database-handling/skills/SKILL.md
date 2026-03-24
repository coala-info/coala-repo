---
name: proteomics-database-handling
description: "This proteomics workflow downloads protein FASTA databases, merges and filters unique sequences, and generates decoy entries using tools like dbbuilder and DecoyDatabase. Use this skill when you need to construct a comprehensive, non-redundant target-decoy search database for identifying proteins and estimating false discovery rates in mass spectrometry data analysis."
homepage: https://workflowhub.eu/workflows/1434
---

# Proteomics: database handling

## Overview

This workflow automates the preparation and management of protein sequence databases, a fundamental prerequisite for proteomics data analysis. It provides a standardized pipeline for retrieving, formatting, and refining FASTA files to ensure they are compatible with downstream search engines and identification tools.

The process begins by using the [Protein Database Downloader](https://toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1) to fetch sequences from public repositories. The workflow includes intermediate steps to manipulate sequence data by converting FASTA files into tabular format, adding custom metadata columns, and converting them back into FASTA format. This allows for precise control over protein headers and sequence information.

To finalize the database, the workflow merges multiple sequence sources into a single file while filtering out duplicate entries to maintain a non-redundant set. Finally, it utilizes the [DecoyDatabase](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_decoydatabase/DecoyDatabase/2.6+galaxy0) tool to generate and append decoy sequences, which are essential for estimating False Discovery Rates (FDR) in peptide identification.

## Inputs and data preparation

_None listed._


Ensure your input protein sequences are in FASTA format or provide valid UniProt accessions for the downloader tools to function correctly. While this workflow primarily processes individual datasets, utilizing dataset collections can significantly streamline the management of multiple proteomes or decoy versions. Refer to the `README.md` for comprehensive instructions on configuring specific database parameters and decoy generation settings. You can automate the execution setup by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 1 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.1 |  |
| 2 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 3 | Add column | addValue |  |
| 4 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 5 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 6 | DecoyDatabase | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_decoydatabase/DecoyDatabase/2.6+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output_database | output_database |
| 1 | output_database | output_database |
| 2 | output | output |
| 3 | out_file1 | out_file1 |
| 4 | output | output |
| 5 | output | output |
| 6 | out | out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf-database-handling.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf-database-handling.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf-database-handling.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf-database-handling.ga -o job.yml`
- Lint: `planemo workflow_lint wf-database-handling.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf-database-handling.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
