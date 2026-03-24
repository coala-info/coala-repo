---
name: analyses-of-shotgun-metagenomics-data-with-metaphlan-v2
description: "This shotgun metagenomics workflow processes fastq collections to generate taxonomic and functional profiles using MetaPhlAn2, HUMAnN2, and Krona. Use this skill when you need to characterize microbial community composition and quantify metabolic pathway or gene family abundances from shotgun sequencing data."
homepage: https://workflowhub.eu/workflows/624
---

# analyses-of-shotgun-metagenomics-data-with-metaphlan-v2

## Overview

This workflow provides a comprehensive pipeline for the taxonomic and functional analysis of shotgun metagenomics data. Starting from a collection of raw FASTQ sequences, it integrates industry-standard tools to characterize the microbial composition and metabolic potential of environmental or clinical samples.

Taxonomic profiling is performed using [MetaPhlAn2](https://toolshed.g2.bx.psu.edu/repos/iuc/metaphlan2/metaphlan2/2.6.0.1), which identifies microbial clades and estimates their relative abundance. The workflow processes these results into multiple formats, including BIOM and SAM files, and generates interactive [Krona pie charts](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0) for intuitive visualization of the community structure.

Functional characterization is handled by [HUMAnN2](https://toolshed.g2.bx.psu.edu/repos/iuc/humann2/humann2/0.11.1.3), which profiles gene families and metabolic pathways. The pipeline includes several post-processing steps to regroup, join, and renormalize these functional tables, ensuring that pathway coverage and abundance metrics are comparable across the entire sample collection.

The final outputs include merged taxonomic tables and normalized functional profiles (gene families and pathways), providing a high-resolution view of "who is there" and "what they are doing." This workflow is particularly useful for researchers focused on metagenomics and shotgun sequencing applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input fastq collection | data_collection_input |  |


Ensure your shotgun metagenomics data is uploaded as a FASTQ collection, as the workflow is optimized to process multiple samples simultaneously for downstream merging and diversity analysis. Verify that your FASTQ files are correctly formatted and that sample names within the collection are unique to ensure accurate labeling in the final MetaPhlAn and HUMAnN2 abundance tables. For comprehensive instructions on database requirements and specific parameter settings, please refer to the accompanying README.md file. You can automate the configuration of these input parameters by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | MetaPhlAn2 | toolshed.g2.bx.psu.edu/repos/iuc/metaphlan2/metaphlan2/2.6.0.1 |  |
| 2 | Cut | Cut1 |  |
| 3 | Extract number of reads table from MetaPhlAn output for diversity stats | (subworkflow) |  |
| 4 | Format MetaPhlAn2 | toolshed.g2.bx.psu.edu/repos/iuc/metaphlan2krona/metaphlan2krona/2.6.0.0 |  |
| 5 | Merge | toolshed.g2.bx.psu.edu/repos/iuc/merge_metaphlan_tables/merge_metaphlan_tables/2.6.0.0 |  |
| 6 | HUMAnN2 | toolshed.g2.bx.psu.edu/repos/iuc/humann2/humann2/0.11.1.3 |  |
| 7 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 8 | Rename Metaphlan output with sampleID | (subworkflow) |  |
| 9 | Join HUMAnN2 tables from a collection | (subworkflow) |  |
| 10 | Regroup | toolshed.g2.bx.psu.edu/repos/iuc/humann2_regroup_table/humann2_regroup_table/0.11.1.1 |  |
| 11 | Join HUMAnN2 tables from a collection | (subworkflow) |  |
| 12 | Renormalize | toolshed.g2.bx.psu.edu/repos/iuc/humann2_renorm_table/humann2_renorm_table/0.11.1.1 |  |
| 13 | Renormalize | toolshed.g2.bx.psu.edu/repos/iuc/humann2_renorm_table/humann2_renorm_table/0.11.1.1 |  |
| 14 | Renormalize | toolshed.g2.bx.psu.edu/repos/iuc/humann2_renorm_table/humann2_renorm_table/0.11.1.1 |  |
| 15 | Join HUMAnN2 tables from a collection | (subworkflow) |  |
| 16 | Join HUMAnN2 tables from a collection | (subworkflow) |  |
| 17 | Join HUMAnN2 tables from a collection | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | MetaPhIAn2 biom file | biom_output_file |
| 1 | MetaPhIAn2 SAM file | sam_output_file |
| 1 | output_file | output_file |
| 2 | out_file1 | out_file1 |
| 4 | Formatted file for Krona | krona |
| 5 | output | output |
| 6 | HUMAnN2 Pathways and their coverage | pathcoverage_tsv |
| 6 | HUMAnN2 Pathways and their abundance | pathabundance_tsv |
| 6 | HUMAnN2 Gene families and their abundance | gene_families_tsv |
| 7 | Krona pie plot | output |
| 10 | HUMAnN2 regrouped gene families abundance | output_table |
| 12 | HUMAnN2 normalised gene families abundance | output_table |
| 13 | HUMAnN2 normalised pathways abundance | output_table |
| 14 | HUMAnN2 regrouped and normalised gene families abundance | output_table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-analyses-of-shotgun-metagenomics-data-with-metaphlan-v2_.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-analyses-of-shotgun-metagenomics-data-with-metaphlan-v2_.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-analyses-of-shotgun-metagenomics-data-with-metaphlan-v2_.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-analyses-of-shotgun-metagenomics-data-with-metaphlan-v2_.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-analyses-of-shotgun-metagenomics-data-with-metaphlan-v2_.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-analyses-of-shotgun-metagenomics-data-with-metaphlan-v2_.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
