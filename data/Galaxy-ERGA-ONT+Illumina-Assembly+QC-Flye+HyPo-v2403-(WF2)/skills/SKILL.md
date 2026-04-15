---
name: erga-ontillumina-assemblyqc-flyehypo-v2403-wf2
description: This Galaxy workflow performs hybrid de novo genome assembly and quality control using ONT and Illumina reads, integrating Flye for assembly, HyPo for polishing, and tools like BUSCO and Merqury for validation. Use this skill when you need to produce high-quality eukaryotic reference genomes that require both long-read structural resolution and short-read sequence accuracy to ensure high completeness and low error rates.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-ontillumina-assemblyqc-flyehypo-v2403-wf2

## Overview

This Galaxy workflow provides an end-to-end solution for hybrid genome assembly and quality control, specifically tailored for the ERGA (European Reference Genome Atlas) initiative. It begins by generating a long-read de novo assembly from ONT reads using [Flye](https://github.com/fenderglass/Flye). The workflow requires several initial inputs, including trimmed Illumina reads, ONT reads, an estimated genome size, and a pre-computed meryl database for k-mer analysis.

The initial assembly undergoes a hybrid polishing step using [HyPo](https://github.com/kensung-lab/hypo) to improve base-level accuracy. This process integrates both short-read Illumina data mapped via [BWA-MEM2](https://github.com/bwa-mem2/bwa-mem2) and long-read ONT data mapped via [minimap2](https://github.com/lh3/minimap2). By leveraging the high consensus accuracy of short reads and the structural reliability of long reads, the workflow produces a refined final consensus sequence.

Comprehensive quality control is performed both before and after the polishing stage to track improvements in assembly quality. The pipeline utilizes [BUSCO](https://busco.ezlab.org/) to evaluate gene content completeness and [Merqury](https://github.com/marbl/merqury) for k-mer based evaluation of QV scores and completeness. Additionally, [gfastats](https://github.com/sanger-pathogens/gfastats) provides scaffold metrics, while [Bandage](https://github.com/rrwick/Bandage) generates visualizations of the assembly graph to assess connectivity.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Illumina trimmed reads | data_collection_input |  |
| 1 | ONT reads | data_input | fastq file with ONT reads |
| 2 | Estimated genome size | data_input |  |
| 3 | Max depth | data_input |  |
| 4 | meryl db | data_input | import meryldb to run merqury on the assemblies obtained |
| 5 | lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10... |


Ensure your ONT reads are in fastq.gz format and provide Illumina trimmed reads as a paired-end data collection to maintain sample integrity during the BWA-MEM2 mapping stage. The meryl database must be pre-computed to match the k-mer size used for Merqury evaluation, while the genome size and max depth should be provided as text files or parameters to guide the Flye assembly and HyPo polishing steps. For automated job configuration and testing, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on lineage selection and specific tool parameterizations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Flatten collection | __FLATTEN__ |  |
| 7 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.1+galaxy0 |  |
| 8 | Parse parameter value | param_value_from_file |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 12 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 13 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 14 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 15 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 |  |
| 16 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 17 | Merge BAM Files | toolshed.g2.bx.psu.edu/repos/devteam/sam_merge/sam_merge2/1.2.0 |  |
| 18 | HyPo | toolshed.g2.bx.psu.edu/repos/iuc/hypo/hypo/1.0.3+galaxy0 |  |
| 19 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 | merqury on flye assembly polished with 1 round of hypo |
| 20 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 21 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | consensus | consensus |
| 7 | assembly_gfa | assembly_gfa |
| 11 | bam_output | bam_output |
| 12 | Map with minimap2 on input dataset(s) (mapped reads in BAM format) | alignment_output |
| 13 | outfile | outfile |
| 14 | Busco on input dataset(s): short summary | busco_sum |
| 14 | busco_missing | busco_missing |
| 14 | summary_image | summary_image |
| 14 | busco_table | busco_table |
| 15 | Merqury on input dataset(s): plots | png_files |
| 15 | QV stats | qv_files |
| 15 | Merqury on input dataset(s): stats | stats_files |
| 16 | stats | stats |
| 17 | output1 | output1 |
| 18 | HyPo on input dataset(s): polished assembly | out_fasta |
| 19 | png_files | png_files |
| 19 | stats_files | stats_files |
| 19 | qv_files | qv_files |
| 20 | stats | stats |
| 21 | summary_image | summary_image |
| 21 | busco_missing | busco_missing |
| 21 | busco_sum | busco_sum |
| 21 | busco_table | busco_table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_Flye_HyPo_v2403_(WF2).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_Flye_HyPo_v2403_(WF2).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_Flye_HyPo_v2403_(WF2).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_Flye_HyPo_v2403_(WF2).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_Flye_HyPo_v2403_(WF2).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_Flye_HyPo_v2403_(WF2).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)