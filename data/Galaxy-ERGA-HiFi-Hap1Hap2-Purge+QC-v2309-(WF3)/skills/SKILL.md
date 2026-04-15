---
name: erga-hifi-hap1hap2-purgeqc-v2309-wf3
description: This ERGA workflow processes dual-haplotype HiFi GFA contigs using purge_dups and minimap2 to remove haplotypic duplications while performing quality assessment with BUSCO, Merqury, and gfastats. Use this skill when you need to refine a diploid genome assembly by purging false duplications from primary and alternate haplotypes and validating the resulting assembly's completeness and k-mer consistency.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-hifi-hap1hap2-purgeqc-v2309-wf3

## Overview

This Galaxy workflow is designed for the European Reference Genome Atlas (ERGA) assembly pipeline to perform purging and quality control on dual-haploid (Hap1 and Hap2) HiFi assemblies. It accepts GFA contigs, trimmed HiFi reads, and a Meryl database as primary inputs, alongside parameters for genome size and lineage.

The core processing involves converting GFA files to FASTA format and executing iterative rounds of [purge_dups](https://github.com/dfguan/purge_dups) to identify and remove haplotypic duplications. This refinement process is supported by [minimap2](https://github.com/lh3/minimap2) alignments, which map the HiFi reads back to the assemblies to provide coverage information necessary for accurate purging.

The final stage of the workflow focuses on comprehensive validation and quality assessment. It utilizes [gfastats](https://github.com/GFA-spec/gfastats) for assembly metrics, [BUSCO](https://busco.ezlab.org/) for gene completeness analysis, and [Merqury](https://github.com/marbl/merqury) for k-mer based evaluation of assembly consensus quality and completeness. These tools ensure the resulting haploid representations are highly contiguous and biologically accurate.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Hap1 GFA contigs | data_input |  |
| 1 | Transition parameter | data_input |  |
| 2 | HiFi trimmed reads | data_collection_input |  |
| 3 | max depth | data_input |  |
| 4 | Hap2 GFA contigs | data_input |  |
| 5 | Estimated genome size | data_input |  |
| 6 | lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10, aves_odb10, tetrapoda_odb10 ... |
| 7 | Meryl database | data_input |  |


Ensure your input Hap1 and Hap2 contigs are in GFA format, as the workflow automatically converts them to FASTA for downstream processing. Provide trimmed HiFi reads as a dataset collection and include a pre-computed Meryl database to enable Merqury k-mer evaluation. You must manually specify the lineage for BUSCO and provide estimated genome size and depth parameters to ensure accurate purging of haplotypic duplications. For automated execution, you can initialize your parameters using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter tuning and specific tool configurations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 12 | Parse parameter value | param_value_from_file |  |
| 13 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 14 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 15 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 16 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 17 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 18 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 19 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 20 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 21 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 22 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 23 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 24 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 25 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 26 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 27 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 28 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 29 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 30 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 31 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 25 | output | output |
| 29 | output | output |
| 30 | summary_image | summary_image |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_HiFi_Hap1Hap2_Purge_QC_v2310_(WF3).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_HiFi_Hap1Hap2_Purge_QC_v2310_(WF3).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_HiFi_Hap1Hap2_Purge_QC_v2310_(WF3).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_HiFi_Hap1Hap2_Purge_QC_v2310_(WF3).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_HiFi_Hap1Hap2_Purge_QC_v2310_(WF3).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_HiFi_Hap1Hap2_Purge_QC_v2310_(WF3).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)