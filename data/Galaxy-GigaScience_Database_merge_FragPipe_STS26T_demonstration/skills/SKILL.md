---
name: gigascience_database_merge_fragpipe_sts26t_demonstration
description: This workflow merges fusion and non-normal transcript databases to perform discovery peptidomics on RAW mass spectrometry data using FragPipe. Use this skill when you need to identify neoantigen candidates by searching proteomic data against customized databases containing fusion proteins and non-standard transcripts.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gigascience_database_merge_fragpipe_sts26t_demonstration

## Overview

This Galaxy workflow facilitates discovery peptidomics by integrating fusion and non-normal protein databases to identify novel peptide candidates. It begins by merging human cRAP and non-normal transcript databases with fusion-specific databases using [FASTA Merge Files and Filter Unique Sequences](https://toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0). The resulting database is validated to ensure compatibility with downstream proteomic search engines.

The core analysis is performed by [FragPipe](https://toolshed.g2.bx.psu.edu/repos/galaxyp/fragpipe/fragpipe/20.0+galaxy2), which processes raw mass spectrometry data against the custom-built database. This step generates comprehensive reports for peptides, proteins, and peptide-spectrum matches (PSMs). The workflow is particularly suited for neoantigen discovery and [GTN](https://training.galaxyproject.org/) training applications.

Following the search, the workflow filters the results to isolate high-interest candidates. It collapses data collections and utilizes [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) and grep-based filtering to remove known human peptides. The final output is a refined list of peptide candidates, providing a streamlined pipeline for identifying non-canonical sequences in complex proteomic datasets. This workflow is shared under a CC-BY-4.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Human_cRAP_Non_normal_transcripts_dB | data_input | Non-Normal databases i.e CustomProDB and StringTie |
| 1 | Fusion-database | data_input | Arriba Fusion db |
| 2 | Input-RAW-FILE | data_input | Input RAW file |
| 3 | FragPipe_Experimental_design_tabular | data_input | Design file |


Ensure your input files are correctly formatted, specifically using FASTA for the protein databases and Thermo RAW or mzML for the mass spectrometry data. The experimental design must be a tabular file that accurately maps your RAW files to their respective groups for FragPipe processing. For large-scale analyses, organizing your RAW files into a dataset collection simplifies the workflow execution and downstream data management. Refer to the accompanying README.md for comprehensive parameter settings and database construction details. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 | combine Fusion and Non Normal databases |
| 5 | Validate FASTA Database | toolshed.g2.bx.psu.edu/repos/galaxyp/validate_fasta_database/validate_fasta_database/0.1.5 | Take the Passed fasta file |
| 6 | FragPipe -  Academic Research and Education User License (Non-Commercial) | toolshed.g2.bx.psu.edu/repos/galaxyp/fragpipe/fragpipe/20.0+galaxy2 | Non tryptic fragpipe |
| 7 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 | collapse peptide report |
| 8 | Select | Grep1 | removing anything that matches _HUMAN |
| 9 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 10 | Remove beginning | Remove beginning1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Non_normal_and_Fusion_dB | output |
| 5 | Validated-fasta | goodFastaOut |
| 6 | Fragpipe_output_peptide | output_peptide |
| 6 | Fragpipe_output_protein | output_protein |
| 6 | Fragpipe_output_psm | output_psm |
| 7 | Fragpipe-Peptide-Report | output |
| 8 | Removing_known_human_peptides | out_file1 |
| 9 | Extracting_Peptide-Candidates | output |


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