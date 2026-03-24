---
name: tsi-scaffolding-with-hic
description: "This workflow performs genome scaffolding by integrating assembly FASTA files with Hi-C sequencing data using BWA-MEM2, YAHS, and PretextMap to generate chromosome-level assemblies and contact maps. Use this skill when you need to improve the continuity of a draft genome assembly by orienting and joining contigs into larger scaffolds using chromatin conformation capture data."
homepage: https://workflowhub.eu/workflows/1054
---

# TSI-Scaffolding-with-HiC

## Overview

This workflow performs genome scaffolding using Hi-C data, specifically utilizing the YAHS tool. It is adapted from the [Vertebrate Genomes Project (VGP)](https://galaxyproject.org/projects/vgp/) curated scaffolding pipeline, with modifications tailored for the TSI project. Key changes from the [original VGP workflow](https://dockstore.org/workflows/github.com/iwc-workflows/Scaffolding-HiC-VGP8/main:main?tab=info) include transitioning the primary input format to FASTA and requiring manual entry for estimated genome size to streamline compatibility with TSI data.

The pipeline begins by mapping Hi-C forward and reverse reads to the assembly using BWA-MEM2, followed by filtering and merging with Bellerophon. YAHS then leverages these interactions to orient and join contigs into scaffolds. The workflow integrates comprehensive quality control and assessment steps, including assembly statistics via gfastats and lineage-specific completeness checks through BUSCO.

The primary outputs include the scaffolded assembly in both FASTA and GFA formats, along with detailed assembly statistics. To evaluate the scaffolding quality, the workflow generates contact maps using PretextMap and Pretext Snapshot, allowing for a direct visual comparison of the assembly's continuity before and after the Hi-C integration. Additional visualization outputs include Nx and size plots to track improvements in assembly metrics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | assembly.fasta | data_input |  |
| 1 | Restriction enzymes | parameter_input | Restriction enzymes used in preparation of Hi-C libraries. |
| 2 | HiC reverse reads | data_input | Reverse reads as a single dataset in fastq format |
| 3 | HiC Forward reads | data_input | Forward reads as a single dataset in fastq format |
| 4 | Estimated genome size in bp | parameter_input |  |
| 5 | Lineage | parameter_input | Taxonomic lineage for the organism being assembled for Busco analysis |


Ensure the assembly is provided in FASTA format representing a single haplotype, while HiC reads should be uploaded as separate forward and reverse datasets in `fastqsanger.gz` format. Because the workflow expects individual files for the HiC data, use single datasets rather than paired-end collections to avoid configuration errors. You must also provide the specific restriction enzyme sequence and the estimated genome size as an integer to ensure YAHS performs the scaffolding correctly. Please refer to the `README.md` for comprehensive details on parameter selection and specific tool configurations. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 7 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 8 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy1 |  |
| 9 | YAHS | toolshed.g2.bx.psu.edu/repos/iuc/yahs/yahs/1.2a.2+galaxy1 |  |
| 10 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy1 |  |
| 11 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 12 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy2 |  |
| 13 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 14 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 15 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 16 | Extract dataset | __EXTRACT_DATASET__ |  |
| 17 | gfastats_data_prep | (subworkflow) |  |
| 18 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.5.0+galaxy0 |  |
| 19 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 20 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 21 | Cut | Cut1 |  |
| 22 | Cut | Cut1 |  |
| 23 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy1 |  |
| 24 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 |  |
| 25 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 |  |
| 26 | bedtools BAM to BED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtobed/2.30.0+galaxy2 |  |
| 27 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy1 |  |
| 28 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.3+galaxy1 |  |
| 29 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy2 |  |
| 30 | Extract dataset | __EXTRACT_DATASET__ |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | YAHS on input dataset(s): Final scaffolds agp output | final_agp_out |
| 11 | Reconciliated Scaffolds: gfa | output |
| 13 | Scaffold sizes for s2 | stats |
| 14 | Reconciliated Scaffolds: fasta | output |
| 15 | Assembly Statistics for s2 | stats |
| 16 | Pretext Map Before HiC scaffolding | output |
| 18 | Busco Summary | busco_sum |
| 18 | Busco Summary image | summary_image |
| 24 | Nx Plot | output1 |
| 25 | Size Plot | output1 |
| 30 | Pretext Map After HiC scaffolding | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run TSI-Scaffolding-with-HiC.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run TSI-Scaffolding-with-HiC.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run TSI-Scaffolding-with-HiC.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init TSI-Scaffolding-with-HiC.ga -o job.yml`
- Lint: `planemo workflow_lint TSI-Scaffolding-with-HiC.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `TSI-Scaffolding-with-HiC.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
