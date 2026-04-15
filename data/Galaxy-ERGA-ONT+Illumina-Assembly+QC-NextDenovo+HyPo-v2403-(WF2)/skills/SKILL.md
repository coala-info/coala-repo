---
name: erga-ontillumina-assemblyqc-nextdenovohypo-v2403-wf2
description: This ERGA workflow performs hybrid de novo genome assembly using ONT long reads and Illumina short reads, utilizing NextDenovo for initial assembly and HyPo for polishing alongside comprehensive QC tools like BUSCO and Merqury. Use this skill when you need to generate a high-quality, polished eukaryotic genome assembly from a combination of long-read and short-read sequencing data while rigorously assessing assembly completeness and base-level accuracy.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-ontillumina-assemblyqc-nextdenovohypo-v2403-wf2

## Overview

This workflow provides a comprehensive pipeline for high-quality genome assembly using a combination of Oxford Nanopore Technologies (ONT) long reads and Illumina short reads, adhering to [ERGA](https://www.erga-biodiversity.eu/) standards. It begins by generating a de novo assembly from ONT data using [NextDenovo](https://github.com/Nextomics/NextDenovo), utilizing user-provided genome size estimates and depth parameters to optimize the assembly process.

To ensure high consensus accuracy, the workflow performs hybrid polishing using [HyPo](https://github.com/kensung-lab/hypo). This step integrates both long-read signal (mapped via [minimap2](https://github.com/lh3/minimap2)) and short-read accuracy (mapped via [BWA-MEM2](https://github.com/bwa-mem2/bwa-mem2)) to correct errors in the initial draft. The pipeline is designed to handle complex datasets by automating the mapping and merging of multiple read sets before the polishing phase.

Quality control is integrated throughout the process, with evaluations performed both on the raw assembly and the final polished product. The workflow generates assembly statistics via [gfastats](https://github.com/GFA-spec/gfastats), visualizes assembly graphs with [Bandage](https://github.com/rrwick/Bandage), and assesses biological completeness and k-mer consistency using [BUSCO](https://busco.ezlab.org/) and [Merqury](https://github.com/marbl/merqury). These comparative outputs allow researchers to rigorously track improvements in assembly quality and continuity.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ONT raw stats table | data_input |  |
| 1 | ONT reads | data_input | fastq file with ONT reads |
| 2 | Estimated genome size | data_input |  |
| 3 | Illumina trimmed reads | data_collection_input |  |
| 4 | Max depth | data_input |  |
| 5 | lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10... |
| 6 | meryl db | data_input | import meryldb to run merqury on the assemblies obtained |


Ensure ONT reads are provided in FASTQ format and provide Illumina trimmed reads as a paired-end data collection to facilitate efficient mapping and polishing. You must also supply a pre-computed Meryl database and an accurate genome size estimate to ensure the success of the Merqury and NextDenovo steps. For automated configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file for your input parameters. Please refer to the README.md for comprehensive details on selecting the correct BUSCO lineage and configuring depth parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.8+galaxy0 |  |
| 8 | Parse parameter value | param_value_from_file |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | Flatten collection | __FLATTEN__ |  |
| 11 | Parse parameter value | param_value_from_file |  |
| 12 | Arithmetic Operations | toolshed.g2.bx.psu.edu/repos/devteam/tables_arithmetic_operations/tables_arithmetic_operations/1.0.0 |  |
| 13 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 14 | Parse parameter value | param_value_from_file |  |
| 15 | NextDenovo | toolshed.g2.bx.psu.edu/repos/bgruening/nextdenovo/nextdenovo/2.5.0+galaxy0 |  |
| 16 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 17 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 18 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 19 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 20 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 21 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 22 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 |  |
| 23 | Merge BAM Files | toolshed.g2.bx.psu.edu/repos/devteam/sam_merge/sam_merge2/1.2.0 |  |
| 24 | HyPo | toolshed.g2.bx.psu.edu/repos/iuc/hypo/hypo/1.0.3+galaxy0 |  |
| 25 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 | merqury on flye assembly polished with 1 round of hypo |
| 26 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 27 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 16 | outfile | outfile |
| 18 | stats | stats |
| 19 | bam_output | bam_output |
| 20 | Map with minimap2 on input dataset(s) (mapped reads in BAM format) | alignment_output |
| 21 | busco_missing | busco_missing |
| 21 | busco_table | busco_table |
| 21 | summary_image | summary_image |
| 21 | Busco on input dataset(s): short summary | busco_sum |
| 22 | Merqury on input dataset(s): stats | stats_files |
| 22 | QV stats | qv_files |
| 22 | Merqury on input dataset(s): plots | png_files |
| 24 | HyPo on input dataset(s): polished assembly | out_fasta |
| 25 | png_files | png_files |
| 25 | stats_files | stats_files |
| 25 | qv_files | qv_files |
| 26 | busco_table | busco_table |
| 26 | busco_missing | busco_missing |
| 26 | busco_sum | busco_sum |
| 26 | summary_image | summary_image |
| 27 | stats | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_NextDenovo_HyPo_v2403_(WF2).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_NextDenovo_HyPo_v2403_(WF2).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_NextDenovo_HyPo_v2403_(WF2).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_NextDenovo_HyPo_v2403_(WF2).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_NextDenovo_HyPo_v2403_(WF2).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_NextDenovo_HyPo_v2403_(WF2).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)