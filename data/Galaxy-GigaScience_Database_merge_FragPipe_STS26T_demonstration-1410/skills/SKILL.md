---
name: gigascience_database_merge_fragpipe_sts26t_demonstration
description: This peptidomics workflow merges non-normal transcript and fusion protein databases to perform discovery-based neoantigen identification from RAW mass spectrometry data using FragPipe. Use this skill when you need to identify candidate neoantigens or non-canonical peptides by searching proteomic data against customized databases containing fusion events and aberrant transcripts.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gigascience_database_merge_fragpipe_sts26t_demonstration

## Overview

This workflow is designed for discovery peptidomics, specifically focusing on neoantigen identification by merging specialized protein databases. It processes four primary inputs: a non-normal transcript database (including cRAP), a fusion protein database, mass spectrometry RAW data, and a FragPipe experimental design file.

The initial stages involve merging the non-normal and fusion FASTA files into a single, non-redundant database using [FASTA Merge Files and Filter Unique Sequences](https://toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0). This combined database is then validated to ensure compatibility with downstream search engines, providing a comprehensive reference for identifying unconventional peptide sequences.

Using the [FragPipe](https://toolshed.g2.bx.psu.edu/repos/galaxyp/fragpipe/fragpipe/20.0+galaxy2) platform, the workflow performs a proteomic search to generate detailed peptide, protein, and PSM reports. The final steps involve rigorous filtering and tabular queries to remove known human peptides and extract high-confidence peptide candidates, facilitating the discovery of potential neoantigens.

This demonstration workflow is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). It provides a standardized pipeline for researchers to integrate fusion and non-normal databases into their discovery peptidomics workflows.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Human_cRAP_Non_normal_transcripts_dB | data_input | Non-Normal databases i.e CustomProDB and StringTie |
| 1 | Fusion-database | data_input | Arriba Fusion db |
| 2 | Input-RAW-FILE | data_input | Input RAW file |
| 3 | FragPipe_Experimental_design_tabular | data_input | Design file |


Ensure all sequence inputs are in FASTA format and the experimental design is provided as a tabular file to ensure compatibility with FragPipe. When handling multiple mass spectrometry runs, organize your RAW files into a dataset collection to streamline the search process against the merged fusion and non-normal databases. For automated execution and parameter reproducibility, consider using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on database construction and specific tool configurations.

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