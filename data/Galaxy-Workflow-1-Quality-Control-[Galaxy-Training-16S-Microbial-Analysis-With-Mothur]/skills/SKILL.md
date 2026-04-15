---
name: workflow-1-quality-control-galaxy-training-16s-microbial-ana
description: This 16S microbial analysis workflow processes contigs and group files using mothur tools to perform initial quality control, sequence screening, and dereplication. Use this skill when you need to filter out ambiguous bases or long homopolymers from 16S rRNA gene sequences and generate a count table of unique sequences for microbiome profiling.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-1-quality-control-galaxy-training-16s-microbial-ana

## Overview

This workflow represents the initial quality control and preprocessing stage of a 16S rRNA gene sequencing analysis pipeline using the mothur toolset. Based on the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/mothur-16s-short/tutorial.html) curriculum, it is designed to refine raw contigs and group assignments into a high-quality dataset ready for downstream taxonomic analysis.

The process begins with an initial assessment of sequence characteristics using `Summary.seqs`, followed by a rigorous filtering step via `Screen.seqs`. This step removes sequences that contain ambiguous bases or fall outside of the expected length range. A secondary summary is then generated to verify that the filtering parameters successfully improved the dataset's overall quality.

In the final stages, the workflow performs dereplication using `Unique.seqs` to collapse identical sequences, significantly reducing the computational load for subsequent steps. It concludes by generating a count table with `Count.seqs`, which tracks the abundance of each unique sequence across the experimental groups. This MIT-licensed workflow is a critical component for microbiome researchers following the mothur SOP within Galaxy.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Contigs | data_input |  |
| 1 | Groups | data_input |  |


Ensure your input contigs and groups files are in FASTA and tabular formats respectively, as mothur requires specific formatting for sequence screening and group assignment. While this workflow uses individual datasets, consider using dataset collections for larger cohorts to streamline the quality control process across multiple samples. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter settings and expected output logs. Always verify that your group file names match the sequence identifiers in your contigs to avoid errors during the `Screen.seqs` step.

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
| 3 | fasta_out | fasta_out |
| 3 | bad_accnos | bad_accnos |
| 4 | logfile | logfile |
| 5 | out_fasta | out_fasta |
| 5 | out_names | out_names |
| 6 | seq_count | seq_count |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow1-quality-control.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow1-quality-control.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow1-quality-control.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow1-quality-control.ga -o job.yml`
- Lint: `planemo workflow_lint workflow1-quality-control.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow1-quality-control.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)