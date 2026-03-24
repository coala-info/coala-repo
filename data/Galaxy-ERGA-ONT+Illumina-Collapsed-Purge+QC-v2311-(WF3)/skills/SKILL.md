---
name: erga-ontillumina-collapsed-purgeqc-v2311-wf3
description: "This ERGA workflow refines genome assemblies by processing GFA contigs and ONT reads with purge_dups and minimap2, followed by comprehensive quality control using BUSCO, Merqury, and gfastats. Use this skill when you need to eliminate redundant haplotigs from a collapsed assembly and evaluate the biological completeness and k-mer accuracy of the resulting genomic sequence."
homepage: https://workflowhub.eu/workflows/701
---

# ERGA ONT+Illumina Collapsed Purge+QC v2311 (WF3)

## Overview

This Galaxy workflow is designed for the European Reference Genome Atlas ([ERGA](https://www.erga-biodiversity.eu/)) initiative to refine primary genome assemblies. It focuses on purging haplotypic duplications and performing comprehensive quality control (QC) on assemblies generated from ONT and Illumina data. The pipeline accepts GFA contigs, ONT long reads, and an Illumina-derived Meryl database as primary inputs.

The core processing engine utilizes [purge_dups](https://github.com/dfguan/purge_dups) to identify and remove redundant sequences. After converting GFA inputs to FASTA, the workflow maps ONT reads using [minimap2](https://github.com/lh3/minimap2) to calculate coverage depth. This information, combined with transition parameters and estimated genome size, allows the workflow to accurately collapse the assembly into a high-quality haploid representation.

Validation and assessment are integrated through several industry-standard tools. [gfastats](https://github.com/nuno-agostinho/gfastats) generates structural assembly metrics, while [BUSCO](https://busco.ezlab.org/) assesses biological completeness using lineage-specific orthologs. Finally, [Merqury](https://github.com/marbl/merqury) provides k-mer based evaluation to ensure consensus accuracy and completeness against the provided Meryl database.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GFA contigs | data_input |  |
| 1 | ONT reads | data_collection_input |  |
| 2 | Transition parameter | data_input |  |
| 3 | max depth | data_input |  |
| 4 | Estimated genome size | data_input |  |
| 5 | lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10, aves_odb10, tetrapoda_odb10 ... |
| 6 | Meryl database | data_input |  |


Ensure your input GFA contigs and ONT reads (provided as a data collection) are in the correct format, as the workflow automatically converts GFA to FASTA for downstream processing. You must provide a pre-computed Meryl database and specific numerical parameters for genome size and depth to ensure accurate purging of haplotypic duplications. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` template. Refer to the `README.md` for comprehensive details on parameter tuning and lineage selection for BUSCO. Always verify that your input datasets are properly labeled to avoid mapping errors during the minimap2 steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 8 | Parse parameter value | param_value_from_file |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 12 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 13 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 14 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 15 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 16 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 17 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 18 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 19 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 20 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 17 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_Illumina_Collapsed_Purge_QC_v2311_(WF3).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_Illumina_Collapsed_Purge_QC_v2311_(WF3).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_Illumina_Collapsed_Purge_QC_v2311_(WF3).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_Illumina_Collapsed_Purge_QC_v2311_(WF3).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_Illumina_Collapsed_Purge_QC_v2311_(WF3).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_Illumina_Collapsed_Purge_QC_v2311_(WF3).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
