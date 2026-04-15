---
name: erga-hic-pri-scaffoldingqc-yahs-v2505-wf4
description: This ERGA workflow performs Hi-C scaffolding of primary and alternate purged contigs using YAHS, BWA-MEM2, and Pairtools, followed by comprehensive quality control with BUSCO, Merqury, and Pretext. Use this skill when you need to organize genomic contigs into chromosome-scale scaffolds using Hi-C proximity data while validating the assembly's structural integrity, completeness, and k-mer consistency.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-hic-pri-scaffoldingqc-yahs-v2505-wf4

## Overview

This Galaxy workflow is designed for the ERGA (European Reference Genome Atlas) initiative to perform Hi-C scaffolding and comprehensive quality control on primary assembly contigs. It accepts primary and alternate contigs in GFA format, Hi-C paired-end reads, and essential reference data including a Meryl database and BUSCO lineage information.

The core scaffolding process begins by converting GFA inputs to FASTA and mapping Hi-C reads using [BWA-MEM2](https://github.com/bwa-mem2/bwa-mem2). The alignments are processed through the [Pairtools](https://github.com/open2c/pairtools) suite—including parsing, sorting, and deduplication—to prepare the data for [YAHS](https://github.com/c-zhou/yahs) (Yet Another Hi-C Scaffolder). YAHS utilizes the Hi-C contact signals to order and orient contigs into chromosome-level scaffolds.

To ensure assembly integrity, the workflow integrates a robust QC suite. It generates assembly statistics via [gfastats](https://github.com/GFA-spec/gfastats), evaluates k-mer completeness and consensus quality (QV) with [Merqury](https://github.com/marbl/merqury), and assesses biological completeness using [BUSCO](https://busco.ezlab.org/). Visual validation of the scaffolding is provided through [PretextMap](https://github.com/wtsi-hpag/PretextMap) and [PretextSnapshot](https://github.com/wtsi-hpag/PretextSnapshot), which produce Hi-C contact maps for manual inspection.

This workflow is released under the MIT license and is tagged for ERGA assembly and QC pipelines. Detailed documentation regarding specific tool versions and parameterization can be found in the [README.md](README.md) file in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pri (Purged) Contigs GFA | data_input | Primary contigs in GFA format from the Purge_Dups run results: pri_purged_gfa |
| 1 | Alt (Purged) Contigs GFA | data_input | Alternate contigs in GFA format from the Purge_Dups run results: alt_purged_gfa |
| 2 | (Trimmed) Hi-C Reads | data_collection_input | Collection of Hi-C reads in fastq format |
| 3 | Multiple Hi-C paired-end files? | parameter_input | IMPORTANT! If you have more than one pair of paired-end files, select Yes |
| 4 | Estimated genome size | data_input | Select the est_genome_size result obtained during profiling |
| 5 | Lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10, aves_odb10, tetrapoda_odb10 ... |
| 6 | Meryl database | data_input | Select the meryl_db result obtained during profiling |


Ensure your primary and alternate contigs are provided in GFA format, while Hi-C reads must be organized into a paired-end dataset collection for proper mapping. You should also provide a Meryl database and the estimated genome size to enable accurate Merqury QC and scaffolding metrics. If you are processing multiple Hi-C libraries, ensure the corresponding boolean parameter is set to true to trigger the appropriate merging steps. For automated job configuration and testing, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on lineage selection and specific tool parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 8 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy4 |  |
| 11 | Convert FASTA to fai file | CONVERTER_fasta_to_fai |  |
| 12 | Extract dataset | __EXTRACT_DATASET__ |  |
| 13 | Sambamba merge | toolshed.g2.bx.psu.edu/repos/bgruening/sambamba_merge/sambamba_merge/1.0.1+galaxy2 |  |
| 14 | Cut | Cut1 |  |
| 15 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 16 | Sambamba flagstat | toolshed.g2.bx.psu.edu/repos/bgruening/sambamba_flagstat/sambamba_flagstat/1.0.1+galaxy1 |  |
| 17 | Pairtools parse | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_parse/pairtools_parse/1.1.3+galaxy0 |  |
| 18 | Pairtools sort | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_sort/pairtools_sort/1.1.3+galaxy0 |  |
| 19 | Pairtools dedup | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_dedup/pairtools_dedup/1.1.3+galaxy0 |  |
| 20 | Pairtools split | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_split/pairtools_split/1.1.3+galaxy0 |  |
| 21 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy1 |  |
| 22 | YAHS | toolshed.g2.bx.psu.edu/repos/iuc/yahs/yahs/1.2a.2+galaxy2 |  |
| 23 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.4+galaxy0 |  |
| 24 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 25 | Convert FASTA to fai file | CONVERTER_fasta_to_fai |  |
| 26 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy4 |  |
| 27 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy4 |  |
| 28 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 |  |
| 29 | Cut | Cut1 |  |
| 30 | Extract dataset | __EXTRACT_DATASET__ |  |
| 31 | Sambamba merge | toolshed.g2.bx.psu.edu/repos/bgruening/sambamba_merge/sambamba_merge/1.0.1+galaxy2 |  |
| 32 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 33 | Sambamba flagstat | toolshed.g2.bx.psu.edu/repos/bgruening/sambamba_flagstat/sambamba_flagstat/1.0.1+galaxy1 |  |
| 34 | Pairtools parse | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_parse/pairtools_parse/1.1.3+galaxy0 |  |
| 35 | Pairtools sort | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_sort/pairtools_sort/1.1.3+galaxy0 |  |
| 36 | Pairtools dedup | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_dedup/pairtools_dedup/1.1.3+galaxy0 |  |
| 37 | Pairtools split | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_split/pairtools_split/1.1.3+galaxy0 |  |
| 38 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy1 |  |
| 39 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 24 | stats | stats |
| 27 | stats_files | stats_files |
| 27 | png_files | png_files |
| 27 | qv_files | qv_files |
| 34 | parsed_pairs_stats | parsed_pairs_stats |
| 36 | dedup_pairs_stats | dedup_pairs_stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_HiC_Pri_Scaffolding_QC_YaHS_v2505_(WF4).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_HiC_Pri_Scaffolding_QC_YaHS_v2505_(WF4).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_HiC_Pri_Scaffolding_QC_YaHS_v2505_(WF4).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_HiC_Pri_Scaffolding_QC_YaHS_v2505_(WF4).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_HiC_Pri_Scaffolding_QC_YaHS_v2505_(WF4).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_HiC_Pri_Scaffolding_QC_YaHS_v2505_(WF4).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)