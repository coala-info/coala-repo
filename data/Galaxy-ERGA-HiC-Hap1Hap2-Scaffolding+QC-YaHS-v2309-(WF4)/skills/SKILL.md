---
name: erga-hic-hap1hap2-scaffoldingqc-yahs-v2309-wf4
description: This Galaxy workflow performs Hi-C scaffolding and quality control for dual-haplotype genome assemblies using Hap1 and Hap2 GFA files and Hi-C reads processed through BWA-MEM2, YAHS, and Bellerophon. Use this skill when you need to scaffold haplotype-resolved assemblies into chromosome-level sequences and evaluate their completeness, continuity, and phasing accuracy using BUSCO, Merqury, and Pretext visualizations.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-hic-hap1hap2-scaffoldingqc-yahs-v2309-wf4

## Overview

This Galaxy workflow is designed for the European Reference Genome Atlas (ERGA) initiative to perform Hi-C scaffolding and quality control on dual-haploid genome assemblies. It processes two separate haplotypes (Hap1 and Hap2) in parallel, utilizing trimmed Hi-C reads to orient and anchor contigs into chromosome-level scaffolds.

The pipeline begins by converting GFA inputs to FASTA format via [gfa_to_fa](https://toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2) and aligning Hi-C data using [BWA-MEM2](https://toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1). Following alignment filtering and merging with [Bellerophon](https://toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy1), the workflow employs [YAHS](https://toolshed.g2.bx.psu.edu/repos/iuc/yahs/yahs/1.2a.2+galaxy1) (Yet Another Hi-C Scaffolder) to generate the final scaffolded assemblies and AGP files for both haplotypes.

Comprehensive quality control and visualization are integrated into the workflow. It generates Hi-C contact maps using [PretextMap](https://toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0) and [Pretext Snapshot](https://toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1) for structural validation. Biological completeness and assembly integrity are further assessed through [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0) scores, [gfastats](https://toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0) metrics, and [Merqury](https://toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy3) k-mer evaluations.

This workflow is tagged under **ERGA**, **ASSEMBLY+QC**, and **HiC**, providing a standardized approach for high-quality reference genome production.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Hap1 GFA | data_input | gfa assembly file to scaffold |
| 1 | HiC F trimmed | data_input | HiC forward reads (already trimmed) |
| 2 | HiC R trimmed | data_input | HiC reverse reads (already trimmed) |
| 3 | Estimated genome size | data_input |  |
| 4 | Hap2 GFA | data_input | gfa assembly file to scaffold |
| 5 | lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10, aves_odb10, tetrapoda_odb10 ... |
| 6 | Meryl database | data_input |  |


Ensure your assembly inputs are in GFA format and HiC reads are provided as trimmed FASTQ files. You must also provide a pre-computed Meryl database for Merqury QC and an accurate estimated genome size to ensure proper scaling during the scaffolding process. While HiC reads can be uploaded as individual datasets, organizing them into a paired collection can streamline the BWA-MEM2 mapping steps. Refer to the accompanying README.md for comprehensive instructions on parameter tuning and lineage selection for BUSCO. For automated execution, you can generate a template configuration using `planemo workflow_job_init` to create your `job.yml`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 8 | Parse parameter value | param_value_from_file |  |
| 9 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 10 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 11 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 12 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 13 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 14 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy1 |  |
| 15 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy1 |  |
| 16 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0 |  |
| 17 | YAHS | toolshed.g2.bx.psu.edu/repos/iuc/yahs/yahs/1.2a.2+galaxy1 |  |
| 18 | YAHS | toolshed.g2.bx.psu.edu/repos/iuc/yahs/yahs/1.2a.2+galaxy1 |  |
| 19 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0 |  |
| 20 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1 |  |
| 21 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 22 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 23 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 24 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 25 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 26 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 27 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 28 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 29 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy3 |  |
| 30 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1 |  |
| 31 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy1 |  |
| 32 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy1 |  |
| 33 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0 |  |
| 34 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0 |  |
| 35 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1 |  |
| 36 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 14 | outfile | outfile |
| 15 | outfile | outfile |
| 17 | final_agp_out | final_agp_out |
| 17 | final_fasta_out | final_fasta_out |
| 18 | final_agp_out | final_agp_out |
| 18 | final_fasta_out | final_fasta_out |
| 21 | stats | stats |
| 27 | stats | stats |
| 28 | busco_sum | busco_sum |
| 29 | png_files | png_files |
| 29 | qv_files | qv_files |
| 29 | stats_files | stats_files |
| 32 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_HiC_Hap1Hap2_Scaffolding_QC_YaHS_v2309_(WF4).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_HiC_Hap1Hap2_Scaffolding_QC_YaHS_v2309_(WF4).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_HiC_Hap1Hap2_Scaffolding_QC_YaHS_v2309_(WF4).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_HiC_Hap1Hap2_Scaffolding_QC_YaHS_v2309_(WF4).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_HiC_Hap1Hap2_Scaffolding_QC_YaHS_v2309_(WF4).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_HiC_Hap1Hap2_Scaffolding_QC_YaHS_v2309_(WF4).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)