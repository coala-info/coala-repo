---
name: purging-duplicates-in-one-haplotype-vgp6b
description: This workflow identifies and removes haplotypic or overlap duplications from a single genomic haplotype using purge_dups, minimap2, and Merqury based on PacBio HiFi reads and k-mer profiles. Use this skill when you need to refine a VGP-style assembly by purging redundant contigs from one haplotype to improve assembly contiguity and accuracy after initial contigging.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# purging-duplicates-in-one-haplotype-vgp6b

## Overview

This Galaxy workflow is the sixth stage of the Vertebrate Genomes Project (VGP) pipeline, specifically designed to identify and remove haplotypic duplications or overlap duplications within a single haplotype assembly. It is intended to be run following initial contigging steps (Workflows 3, 4, or 5). By utilizing [purge_dups](https://github.com/dfguan/purge_dups), the workflow cleans the primary assembly while ensuring that purged contigs are not erroneously moved to the alternative haplotype.

The process integrates several high-accuracy tools to validate the purging results. It uses [minimap2](https://github.com/lh3/minimap2) for read mapping and coverage calculation, followed by [Merqury](https://github.com/marbl/merqury) for k-mer based evaluation and [compleasm](https://github.com/oliverSI/compleasm) (or BUSCO) for gene completeness assessment. These steps ensure that the reduction in assembly size does not result in the loss of unique genomic content.

Key outputs include the purged assembly in both FASTA and GFA formats, along with a comprehensive suite of quality control reports. These reports feature assembly statistics, Nx and size plots via [gfastats](https://github.com/albiatwork/gfastats), and k-mer spectra plots to visualize the distribution of genomic material before and after the purging process.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Species Name | parameter_input | For workflow report. |
| 1 | Assembly Name | parameter_input | For workflow report. |
| 2 | Haplotype | parameter_input | For workflow report. |
| 3 | Genomescope model parameters | data_input | Model parameters obtained in the k-mer profiling workflow. |
| 4 | Pacbio Reads Collection - Trimmed | data_collection_input | Trimmed PacBio HiFi reads—outputs of cutadapt in the contiging workflow. |
| 5 | Assembly to purge | data_input | Assembly containing duplications to be purged. |
| 6 | Meryl Database | data_input | Meryl database obtained in the k-mer profiling workflow. |
| 7 | Assembly to leave alone (For Merqury comparison) | data_input | Assembly that does not need purging. |
| 8 | Estimated genome size - Parameter File | data_input | Estimated genome file obtained in the contiging workflow. |
| 9 | Database for Busco Lineage | parameter_input | Database to use for Busco lineages. |
| 10 | Lineage | parameter_input | Taxonomic lineage for the organism being assembled for Busco analysis |
| 11 | Name of purged assembly | parameter_input |  |
| 12 | Name of un-altered assembly | parameter_input |  |


To prepare your data, ensure you have the FASTA assemblies, Meryl database, and GenomeScope parameters generated from previous VGP pipeline steps. Trimmed PacBio reads must be provided as a dataset collection, while the assemblies and k-mer databases are handled as individual datasets. Verify that the estimated genome size and lineage parameters match your specific species to ensure accurate BUSCO and Merqury QC metrics. For a comprehensive guide on formatting these inputs and configuring parameters, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 13 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 14 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 15 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 16 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 17 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy2 |  |
| 18 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy1 |  |
| 19 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy1 |  |
| 20 | Parse parameter value | param_value_from_file |  |
| 21 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 22 | Cut | Cut1 |  |
| 23 | Cut | Cut1 |  |
| 24 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy2 |  |
| 25 | gfastats_data_prep | (subworkflow) |  |
| 26 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy1 |  |
| 27 | Parse parameter value | param_value_from_file |  |
| 28 | Parse parameter value | param_value_from_file |  |
| 29 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 30 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy1 |  |
| 31 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy1 |  |
| 32 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy3 |  |
| 33 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy1 |  |
| 34 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy4 |  |
| 35 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy1 |  |
| 36 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy1 |  |
| 37 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy1 |  |
| 38 | compleasm | toolshed.g2.bx.psu.edu/repos/iuc/compleasm/compleasm/0.2.6+galaxy3 |  |
| 39 | Extract dataset | __EXTRACT_DATASET__ |  |
| 40 | Extract dataset | __EXTRACT_DATASET__ |  |
| 41 | Extract dataset | __EXTRACT_DATASET__ |  |
| 42 | Extract dataset | __EXTRACT_DATASET__ |  |
| 43 | Extract dataset | __EXTRACT_DATASET__ |  |
| 44 | Extract dataset | __EXTRACT_DATASET__ |  |
| 45 | gfastats_data_prep | (subworkflow) |  |
| 46 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 47 | gfastats_plot | (subworkflow) |  |
| 48 | Join two Datasets | join1 |  |
| 49 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.5+galaxy3 |  |
| 50 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 13 | Species for report | out1 |
| 14 | Assembly for report | out1 |
| 15 | Haplotype for report | out1 |
| 21 | Lineage for report | out1 |
| 30 | Read Coverage and cutoffs calculation: Histogram plot | hist |
| 30 | Cutoffs | calcuts_cutoff |
| 33 | Removed haplotigs | get_seqs_hap |
| 33 | Purged assembly | get_seqs_purged |
| 34 | Merqury on Phased assemblies: stats | stats_files |
| 34 | qv_files | qv_files |
| 34 | Merqury on Phased assemblies: Images | png_files |
| 36 | Purged assembly (GFA) | output |
| 37 | Purged assembly statistics | stats |
| 38 | Compleasm on purged Assembly: Full Table | full_table |
| 38 | Compleasm on purged Assembly: Miniprot | miniprot |
| 38 | Compleasm on purged Assembly: Translated Proteins | translated_protein |
| 38 | Compleasm on purged Assembly: Summary | summary |
| 38 | Compleasm on purged Assembly: Full Table Busco | full_table_busco |
| 39 | merqury_QV | output |
| 40 | output_merqury.spectra-cn.fl | output |
| 41 | output_merqury.spectra-asm.fl | output |
| 42 | output_merqury.assembly_01.spectra-cn.fl | output |
| 43 | merqury_stats | output |
| 44 | output_merqury.assembly_02.spectra-cn.fl | output |
| 49 | Assembly statistics for both assemblies | output |
| 50 | clean_stats | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Purging-duplicates-one-haplotype-VGP6b.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Purging-duplicates-one-haplotype-VGP6b.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Purging-duplicates-one-haplotype-VGP6b.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Purging-duplicates-one-haplotype-VGP6b.ga -o job.yml`
- Lint: `planemo workflow_lint Purging-duplicates-one-haplotype-VGP6b.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Purging-duplicates-one-haplotype-VGP6b.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)