---
name: vgp-purge-assembly-with-purge_dups-pipeline
description: "This VGP workflow utilizes PacBio reads and Hifiasm assemblies to identify and remove haplotypic duplications and overlaps using minimap2 and the purge_dups pipeline. Use this skill when you need to refine a phased genome assembly by purging redundant contigs and artifacts to ensure a highly contiguous and accurate primary representation."
homepage: https://workflowhub.eu/workflows/321
---

# VGP purge assembly with purge_dups pipeline

## Overview

This Galaxy workflow implements the [Vertebrate Genomes Project (VGP)](https://vertebrategenomesproject.org/) pipeline for refining phased genome assemblies. It specifically utilizes the [purge_dups](https://github.com/dfguan/purge_dups) toolset to identify and remove haplotypic duplications and overlaps, which often occur when heterozygous regions are incorrectly assembled as separate contigs rather than alleles.

The process begins by mapping trimmed PacBio reads to the initial Hifiasm primary and alternate assemblies using [minimap2](https://github.com/lh3/minimap2). By incorporating [GenomeScope](http://qb.cshl.edu/genomescope/) model parameters, the workflow calculates precise read coverage and depth cutoffs. These metrics allow the pipeline to distinguish between collapsed sequences and redundant duplications that need to be purged or reassigned.

The final outputs include a cleaned "Purged Primary Assembly" and a "Purged Alternate Assembly." To assist with quality control, the workflow also generates diagnostic visualizations, such as read coverage histograms and BED files, which provide a detailed log of the regions removed or moved during the purging process. This pipeline is tagged for **VGP** and **purge_assembly** and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pacbio Reads Collection - Trimmed | data_collection_input | Collection of trimmed reads (from cutadapt in the Hifiasm workflow) in fastq format. |
| 1 | Hifiasm Primary assembly | data_input | From the Hifiasm workflow. In fasta format. |
| 2 | Hifiasm Alternate assembly | data_input | From the Hifiasm workflow. In fasta format. |
| 3 | Genomescope model parameters | data_input |  |


Ensure your PacBio reads are provided as a fastq.gz data collection, while the primary and alternate assemblies should be uploaded as individual FASTA datasets. The GenomeScope model parameters file is required to extract coverage cutoffs, so verify that this input matches the specific assembly version being processed. For automated execution, you can use `planemo workflow_job_init` to generate a `job.yml` file for configuring these inputs. Refer to the README.md for comprehensive details on parameter tuning and specific tool versions used in this VGP pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 5 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 6 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.6 |  |
| 7 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 8 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.6 |  |
| 9 | Cut | Cut1 |  |
| 10 | Cut | Cut1 |  |
| 11 | Parse parameter value | param_value_from_file |  |
| 12 | Parse parameter value | param_value_from_file |  |
| 13 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 14 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 15 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 16 | Concatenate datasets | cat1 |  |
| 17 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 18 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 19 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 20 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 21 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 22 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | alignment_output | alignment_output |
| 9 | out_file1 | out_file1 |
| 10 | out_file1 | out_file1 |
| 13 | stat_file | stat_file |
| 13 | Read Coverage and cutoffs calculation on primary assembly : Histogram plot | hist |
| 13 | pbcstat_cov | pbcstat_cov |
| 13 | calcuts_cutoff | calcuts_cutoff |
| 13 | calcuts_log | calcuts_log |
| 13 | pbcstat_wig | pbcstat_wig |
| 14 | purge_dups_bed | purge_dups_bed |
| 14 | purge_dups_log | purge_dups_log |
| 15 | Purged Primary Assembly | get_seqs_purged |
| 15 | get_seqs_hap | get_seqs_hap |
| 17 | alignment_output | alignment_output |
| 19 | pbcstat_cov | pbcstat_cov |
| 19 | pbcstat_wig | pbcstat_wig |
| 19 | Read Coverage and cutoffs calculation on alternate assembly : Histogram Plot | hist |
| 19 | stat_file | stat_file |
| 19 | calcuts_log | calcuts_log |
| 19 | calcuts_cutoff | calcuts_cutoff |
| 20 | alignment_output | alignment_output |
| 21 | purge_dups_log | purge_dups_log |
| 21 | purge_dups_bed | purge_dups_bed |
| 22 | get_seqs_hap | get_seqs_hap |
| 22 | Purged Alternate assembly | get_seqs_purged |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run purge_dups.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run purge_dups.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run purge_dups.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init purge_dups.ga -o job.yml`
- Lint: `planemo workflow_lint purge_dups.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `purge_dups.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
