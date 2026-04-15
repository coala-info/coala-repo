---
name: workflow-1-gucfg2galaxy-further-quality-control-16s-microbia
description: This metagenomics workflow processes 16S microbial contigs and group files using Mothur tools to perform sequence screening, dereplication, and quality reporting. Use this skill when you need to filter out sequences with ambiguous bases or undesired lengths and identify unique sequences to reduce computational redundancy in microbial diversity studies.
homepage: https://www.qcif.edu.au/
metadata:
  docker_image: "N/A"
---

# workflow-1-gucfg2galaxy-further-quality-control-16s-microbia

## Overview

This workflow performs secondary quality control for 16S rRNA gene microbial analysis using the [mothur](https://mothur.org/) toolset. It is designed to refine sequence data following initial contig assembly, focusing on filtering out low-quality reads and reducing data redundancy to streamline downstream taxonomic classification.

The pipeline begins by generating a summary of the input contigs and group files to establish a baseline for the dataset. It then utilizes the `Screen.seqs` tool to remove sequences that do not meet specific quality criteria, such as length constraints or maximum allowed homopolymers. A second summary is generated immediately after to verify the impact of the screening process on the sequence library.

In the final stages, the workflow performs dereplication using `Unique.seqs` to identify identical sequences and `Count.seqs` to track their abundance across different groups. This process significantly reduces the computational load for subsequent alignment and chimera detection steps in the metagenomics pipeline by ensuring only unique representative sequences are processed while maintaining accurate abundance counts.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Contigs | data_input |  |
| 1 | Groups | data_input |  |


Ensure your input FASTA contigs and group files are correctly formatted for mothur, as these serve as the foundation for sequence screening and dereplication. While individual datasets are standard, using collections can significantly streamline the processing of multiple samples through the summary and unique sequence steps. Refer to the `README.md` for comprehensive details on parameter thresholds and specific file specifications. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution. Verify that your group file accurately maps sequence IDs to their respective samples to maintain data integrity throughout the quality control process.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |
| 3 | Screen.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_screen_seqs/mothur_screen_seqs/1.39.5.1 |  |
| 4 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |
| 5 | Unique.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_unique_seqs/mothur_unique_seqs/1.39.5.0 |  |
| 6 | Count.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_count_seqs/mothur_count_seqs/1.39.5.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | logfile | logfile |
| 3 | groups_out | groups_out |
| 3 | bad_accnos | bad_accnos |
| 3 | fasta_out | fasta_out |
| 4 | logfile | logfile |
| 5 | out_names | out_names |
| 5 | out_fasta | out_fasta |
| 6 | seq_count | seq_count |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_1_[gucfg2galaxy]__Further_Quality_Control_[16S_Microbial_Analysis_With_Mothur]_.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_1_[gucfg2galaxy]__Further_Quality_Control_[16S_Microbial_Analysis_With_Mothur]_.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_1_[gucfg2galaxy]__Further_Quality_Control_[16S_Microbial_Analysis_With_Mothur]_.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_1_[gucfg2galaxy]__Further_Quality_Control_[16S_Microbial_Analysis_With_Mothur]_.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_1_[gucfg2galaxy]__Further_Quality_Control_[16S_Microbial_Analysis_With_Mothur]_.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_1_[gucfg2galaxy]__Further_Quality_Control_[16S_Microbial_Analysis_With_Mothur]_.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)