---
name: workflow-2-gucfg2galaxy-data-cleaning-and-chimera-removal-16
description: "This metagenomics workflow processes aligned 16S rRNA sequences and count tables using the Mothur toolset to perform sequence screening, filtering, pre-clustering, and chimera detection via VSEARCH. Use this skill when you need to refine 16S microbial datasets by removing sequencing artifacts, redundant sequences, and chimeric reads to improve the accuracy of downstream diversity and taxonomic analyses."
homepage: https://workflowhub.eu/workflows/649
---

# Workflow 2 [gucfg2galaxy]: Data Cleaning And Chimera Removal [16S Microbial Analysis With Mothur]

## Overview

This Galaxy workflow is designed for the rigorous data cleaning and chimera removal stages of 16S microbial analysis using the [mothur](https://mothur.org/) toolset. It takes aligned sequences and a count table as primary inputs, focusing on refining the dataset by removing poor-quality reads, filtering uninformative vertical gaps, and collapsing redundant sequences to improve computational efficiency.

The pipeline employs a multi-step approach to ensure sequence integrity. It utilizes `Screen.seqs` to eliminate sequences that do not meet specific alignment criteria, followed by `Filter.seqs` and `Pre.cluster` to reduce noise and group similar sequences. A critical component of this workflow is the integration of `Chimera.vsearch`, which identifies and removes chimeric sequences that can lead to false taxonomic assignments.

Throughout the process, `Summary.seqs` is executed at multiple checkpoints to provide detailed logs and statistics on the sequence characteristics. This allows researchers to monitor how the dataset evolves after each cleaning step. The final outputs include high-quality, de-replicated FASTA files and updated count tables ready for downstream taxonomic classification and OTU clustering.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Aligned Sequences | data_input |  |
| 1 | Count Table | data_input |  |


Ensure your input Aligned Sequences are in FASTA format and paired with a corresponding Mothur Count Table to maintain sample abundance metadata throughout the cleaning process. While these inputs are typically handled as individual datasets, ensure they are correctly synchronized to avoid errors during the screening and filtering stages. For automated execution and parameter testing, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the accompanying README.md for specific threshold values and detailed configuration of the chimera removal parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |
| 3 | Screen.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_screen_seqs/mothur_screen_seqs/1.39.5.1 |  |
| 4 | Filter.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_filter_seqs/mothur_filter_seqs/1.39.5.0 |  |
| 5 | Unique.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_unique_seqs/mothur_unique_seqs/1.39.5.0 |  |
| 6 | Pre.cluster | toolshed.g2.bx.psu.edu/repos/iuc/mothur_pre_cluster/mothur_pre_cluster/1.39.5.0 |  |
| 7 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |
| 8 | Chimera.vsearch | toolshed.g2.bx.psu.edu/repos/iuc/mothur_chimera_vsearch/mothur_chimera_vsearch/1.39.5.1 |  |
| 9 | Remove.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_remove_seqs/mothur_remove_seqs/1.39.5.0 |  |
| 10 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | logfile | logfile |
| 3 | fasta_out | fasta_out |
| 3 | bad_accnos | bad_accnos |
| 3 | count_out | count_out |
| 4 | filteredfasta | filteredfasta |
| 5 | out_fasta | out_fasta |
| 5 | out_count | out_count |
| 6 | count_out | count_out |
| 6 | fasta_out | fasta_out |
| 7 | Summary.seqs on input dataset(s): summary | out_summary |
| 8 | vsearch.chimeras | vsearch.chimeras |
| 8 | out_accnos | out_accnos |
| 8 | out_count | out_count |
| 9 | fasta_out | fasta_out |
| 9 | count_out | count_out |
| 10 | out_summary | out_summary |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_2_[gucfg2galaxy]__Data_Cleaning_And_Chimera_Removal_[16S_Microbial_Analysis_With_Mothur].ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_2_[gucfg2galaxy]__Data_Cleaning_And_Chimera_Removal_[16S_Microbial_Analysis_With_Mothur].ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_2_[gucfg2galaxy]__Data_Cleaning_And_Chimera_Removal_[16S_Microbial_Analysis_With_Mothur].ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_2_[gucfg2galaxy]__Data_Cleaning_And_Chimera_Removal_[16S_Microbial_Analysis_With_Mothur].ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_2_[gucfg2galaxy]__Data_Cleaning_And_Chimera_Removal_[16S_Microbial_Analysis_With_Mothur].ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_2_[gucfg2galaxy]__Data_Cleaning_And_Chimera_Removal_[16S_Microbial_Analysis_With_Mothur].ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
