---
name: workflow-2-data-cleaning-and-chimera-removal-galaxy-training
description: This Galaxy workflow processes aligned 16S rRNA sequences and count tables using mothur tools to perform data cleaning, sequence filtering, and chimera removal via VSEARCH. Use this skill when you need to improve the quality of microbiome datasets by removing sequencing artifacts, poorly aligned reads, and chimeric sequences before performing taxonomic classification.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-2-data-cleaning-and-chimera-removal-galaxy-training

## Overview

This workflow represents the second stage of the [16S Microbial Analysis with mothur](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/mothur-16s/tutorial.html) pipeline, focusing on high-level quality control and noise reduction. It takes aligned sequences and count tables as input to perform rigorous data cleaning, ensuring that only high-quality, biologically relevant sequences proceed to taxonomic classification.

The process begins with sequence screening and alignment filtering to remove sequences that do not meet specific length or positional criteria. It then utilizes dereplication and pre-clustering via `mothur_pre_cluster` to group sequences that differ by only a few nucleotides. This step is essential for mitigating the impact of sequencing errors and reducing the computational burden of downstream analysis.

A primary feature of this workflow is the identification and removal of chimeric sequences using the `vsearch` algorithm. By comparing sequences against the dataset, the workflow flags and strips artifacts created during PCR amplification. Throughout the process, the `Summary.seqs` tool provides iterative reports, allowing researchers to monitor sequence counts and data quality at every major transition.

This workflow is released under an MIT license and is tagged for Microbiome and GTN (Galaxy Training Network) applications, providing a standardized approach to 16S rRNA gene sequencing bioinformatics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Aligned Sequences | data_input |  |
| 1 | Count Table | data_input |  |


Ensure your input files are in the correct mothur-specific formats, specifically a FASTA file for aligned sequences and a corresponding count table to track sequence abundance. While these inputs are typically handled as individual datasets, ensure they remain synchronized throughout the cleaning process to avoid errors in downstream filtering. For automated execution and testing, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter settings and specific sequence filtering criteria. Always verify that your aligned sequences are properly formatted to match the reference alignment used in previous steps.

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
| 3 | count_out | count_out |
| 3 | fasta_out | fasta_out |
| 3 | bad_accnos | bad_accnos |
| 4 | filteredfasta | filteredfasta |
| 5 | out_fasta | out_fasta |
| 5 | out_count | out_count |
| 6 | fasta_out | fasta_out |
| 6 | count_out | count_out |
| 7 | Summary.seqs on input dataset(s): summary | out_summary |
| 8 | out_accnos | out_accnos |
| 8 | out_count | out_count |
| 8 | vsearch.chimeras | vsearch.chimeras |
| 9 | count_out | count_out |
| 9 | fasta_out | fasta_out |
| 10 | out_summary | out_summary |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow2-data-cleaning.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow2-data-cleaning.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow2-data-cleaning.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow2-data-cleaning.ga -o job.yml`
- Lint: `planemo workflow_lint workflow2-data-cleaning.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow2-data-cleaning.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)