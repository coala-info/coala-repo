---
name: erga-long-readshic-assemblyqc-hifiasm-v2602-wf2
description: This ERGA workflow performs de novo genome assembly using PacBio HiFi or ONT long reads integrated with Hi-C data, utilizing Hifiasm for assembly and BUSCO, Merqury, and gfastats for comprehensive quality control. Use this skill when you need to generate high-quality, chromosome-level phased genome assemblies for eukaryotic species and evaluate their completeness and accuracy using standard reference metrics.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-long-readshic-assemblyqc-hifiasm-v2602-wf2

## Overview

This Galaxy workflow is designed for high-quality *de novo* genome assembly as part of the European Reference Genome Atlas (ERGA) initiative. It utilizes [Hifiasm](https://github.com/chhylp123/hifiasm) to generate phased assemblies by integrating long-read sequencing data (either PacBio HiFi or ONT) with Hi-C data for improved contiguity and scaffolding.

The pipeline requires trimmed long reads, Hi-C paired-end data, and a pre-computed Meryl database. Users also provide an estimated genome size and a specific BUSCO lineage to guide the assembly evaluation and biological completeness checks.

Comprehensive quality control is integrated into the workflow. It generates assembly graph visualizations using [Bandage](https://rrwick.github.io/Bandage/), detailed scaffold and contig metrics via [gfastats](https://github.com/marbl/gfastats), and biological completeness assessments through [BUSCO](https://busco.ezlab.org/). Additionally, [Merqury](https://github.com/marbl/merqury) is used to provide k-mer based consensus quality (QV) scores and completeness statistics.

This MIT-licensed workflow is specifically tagged for ERGA assembly projects involving HiFi, ONT, and Hi-C data, ensuring a standardized and reproducible approach to generating reference-quality genomes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | The Long Reads are PacBio HiFi | parameter_input | If your long reads are HiFi, leave it 'yes' |
| 1 | The Long reads are ONT | parameter_input | If your long reads are ONT, switch to 'yes'. IMPORTANT: Remember to also switch HiFi to 'no' |
| 2 | (Trimmed) Long Reads Collection | data_collection_input | Collection of Long reads in fastq format |
| 3 | HiC R trimmed | data_input |  |
| 4 | HiC F trimmed | data_input |  |
| 5 | Estimated genome size | data_input | Select the est_genome_size result obtained during profiling |
| 6 | lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10, aves_odb10, tetrapoda_odb10 ... |
| 7 | Meryl Database | data_input | Select the meryl_db result obtained during profiling |


Ensure your long reads (HiFi or ONT) are provided as a list of datasets or a collection, while HiC forward and reverse reads should be uploaded as individual fastq.gz files. You must also provide a pre-computed Meryl database and a text file containing the estimated genome size to support Merqury and Hifiasm calculations. Select the appropriate BUSCO lineage string to ensure accurate ortholog assessment during the QC phase. For automated execution, you can initialize your configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific file format requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | Hifiasm | toolshed.g2.bx.psu.edu/repos/bgruening/hifiasm/hifiasm/0.25.0+galaxy1 |  |
| 9 | Hifiasm | toolshed.g2.bx.psu.edu/repos/bgruening/hifiasm/hifiasm/0.25.0+galaxy1 |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 12 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 13 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 14 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 15 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 16 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 17 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 18 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 19 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 20 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 21 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 22 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 23 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 24 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 25 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 26 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 27 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy2 |  |
| 28 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy2 |  |
| 29 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy4 |  |
| 30 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy2 |  |
| 31 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy2 |  |
| 32 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 16 | outfile | outfile |
| 17 | stats | stats |
| 19 | outfile | outfile |
| 20 | stats | stats |
| 22 | outfile | outfile |
| 23 | stats | stats |
| 25 | outfile | outfile |
| 26 | stats | stats |
| 27 | busco_sum | busco_sum |
| 27 | summary_image | summary_image |
| 28 | summary_image | summary_image |
| 28 | busco_sum | busco_sum |
| 29 | png_files | png_files |
| 29 | qv_files | qv_files |
| 29 | stats_files | stats_files |
| 30 | busco_sum | busco_sum |
| 30 | summary_image | summary_image |
| 31 | summary_image | summary_image |
| 31 | busco_sum | busco_sum |
| 32 | png_files | png_files |
| 32 | stats_files | stats_files |
| 32 | qv_files | qv_files |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_Long_reads_HiC_Assembly_QC_Hifiasm_v2602_(WF2).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_Long_reads_HiC_Assembly_QC_Hifiasm_v2602_(WF2).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_Long_reads_HiC_Assembly_QC_Hifiasm_v2602_(WF2).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_Long_reads_HiC_Assembly_QC_Hifiasm_v2602_(WF2).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_Long_reads_HiC_Assembly_QC_Hifiasm_v2602_(WF2).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_Long_reads_HiC_Assembly_QC_Hifiasm_v2602_(WF2).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)