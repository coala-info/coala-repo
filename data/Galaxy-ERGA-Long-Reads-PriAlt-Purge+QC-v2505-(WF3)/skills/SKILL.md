---
name: erga-long-reads-prialt-purgeqc-v2505-wf3
description: This Galaxy workflow processes primary and alternate contig GFAs using HiFi or ONT long reads to perform haplotig purging and quality assessment via purge_dups, minimap2, BUSCO, and Merqury. Use this skill when you need to remove false duplications and haplotypic overlaps from a draft genome assembly while validating its biological completeness and consensus accuracy.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-long-reads-prialt-purgeqc-v2505-wf3

## Overview

This Galaxy workflow is part of the European Reference Genome Atlas ([ERGA](https://www.erga-biodiversity.eu/)) assembly pipeline, specifically designed for the refinement of primary and alternate contig assemblies. It processes long-read sequencing data—either PacBio HiFi or Oxford Nanopore (ONT)—to identify and remove haplotypic duplications, ensuring a more accurate collapsed primary assembly and a comprehensive set of alternate haplotigs.

The core of the workflow utilizes [purge_dups](https://github.com/dfguan/purge_dups) to analyze read depth and sequence overlaps. After converting GFA inputs to FASTA, the pipeline uses [minimap2](https://github.com/lh3/minimap2) to map long reads back to the assembly, providing the coverage data necessary for the purging algorithms to distinguish between true genomic repeats and heterozygous alleles.

Integrated quality control is a key feature of this version, providing multi-faceted validation of the assembly. It employs [BUSCO](https://busco.ezlab.org/) to assess ortholog completeness, [Merqury](https://github.com/marbl/merqury) for k-mer based evaluation of consensus accuracy and completeness, and [gfastats](https://github.com/GFA-spec/gfastats) for detailed structural metrics. These tools ensure that the purging process improves assembly quality without losing essential biological information.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pri Contigs GFA | data_input | Primary contigs in GFA format from the Hifiasm run results: pri_contigs_gfa |
| 1 | Alt Contigs GFA | data_input | Alternate contigs in GFA format from the Hifiasm run results: alt_contigs_gfa |
| 2 | (Trimmed) Long Reads | data_collection_input | Collection of Long reads in fastq format |
| 3 | What type of Long Reads? | parameter_input | Select map-hifi if the long reads are PacBio HiFi (default), map-ont if the long reads are ONT |
| 4 | max depth | data_input | Select the max_depth result obtained during profiling |
| 5 | Transition parameter | data_input | Select the transition_param result obtained during profiling |
| 6 | Estimated genome size | data_input | Select the est_genome_size result obtained during profiling |
| 7 | lineage | parameter_input | lineage for BUSCO, e.g.: arthropoda_odb10, vertebrata_odb10, mammalia_odb10, aves_odb10, tetrapoda_odb10 ... |
| 8 | Meryl database | data_input | Select the meryl_db result obtained during profiling |


Ensure your primary and alternate contigs are in GFA format, while long reads should be provided as a dataset collection of fastq.gz files to facilitate efficient mapping with minimap2. You must also provide a pre-computed Meryl database and specific assembly metrics like genome size and depth cutoffs as individual data inputs. For automated execution and parameter scaling, consider using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter tuning for the purge_dups steps and lineage selection for BUSCO.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 10 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 11 | Parse parameter value | param_value_from_file |  |
| 12 | Parse parameter value | param_value_from_file |  |
| 13 | Parse parameter value | param_value_from_file |  |
| 14 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 15 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy1 |  |
| 16 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy1 |  |
| 17 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 18 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 19 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 20 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 21 | Concatenate datasets | cat1 |  |
| 22 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 |  |
| 23 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 24 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 25 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy1 |  |
| 26 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy1 |  |
| 27 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 28 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 29 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.6+galaxy0 |  |
| 30 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy4 |  |
| 31 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 32 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 33 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_Long_Reads_PriAlt_Purge_QC_v2505_(WF3).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_Long_Reads_PriAlt_Purge_QC_v2505_(WF3).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_Long_Reads_PriAlt_Purge_QC_v2505_(WF3).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_Long_Reads_PriAlt_Purge_QC_v2505_(WF3).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_Long_Reads_PriAlt_Purge_QC_v2505_(WF3).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_Long_Reads_PriAlt_Purge_QC_v2505_(WF3).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)