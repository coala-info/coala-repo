---
name: vgp-assembly-training-workflow
description: "This workflow performs high-quality de novo genome assembly using Bionano, Hi-C, and long-read sequencing data through a pipeline of purging, scaffolding with SALSA and Bionano Hybrid Scaffold, and quality assessment via BUSCO and QUAST. Use this skill when you need to generate chromosome-level reference assemblies for complex eukaryotic genomes while ensuring the removal of haplotypic duplications and verifying structural integrity."
homepage: https://workflowhub.eu/workflows/1607
---

# VGP assembly: training workflow

## Overview

This Galaxy workflow implements the Vertebrate Genomes Project (VGP) assembly pipeline, designed to generate high-quality, near-error-free reference genomes. It processes a combination of sequencing data, including Bionano optical maps and Hi-C datasets, to perform assembly, curation, and scaffolding. The workflow is structured to follow the best practices established by the [VGP consortium](https://vertebrategenomesproject.org/) for producing chromosome-level assemblies.

The pipeline begins with initial assembly processing using [GFA to FASTA](https://github.com/GFA-spec/GFA-spec) and quality control steps. It utilizes [Meryl](https://github.com/marbl/meryl) and [GenomeScope](https://github.com/schatzlab/genomescope) for k-mer analysis, while [Purge Dups](https://github.com/dfguan/purge_dups) is employed across multiple stages to identify and remove haplotypic duplications. This ensures the final assembly represents a collapsed haploid genome without redundant sequences.

Scaffolding and structural refinement are handled through [Bionano Hybrid Scaffold](https://bionano.com/) and [SALSA](https://github.com/marbl/salsa), integrating optical mapping and Hi-C data to orient and join contigs. Mapping tasks are performed using [minimap2](https://github.com/lh3/minimap2) and [BWA-MEM2](https://github.com/bwa-mem2/bwa-mem2), while Hi-C contact maps are visualized and validated using [PretextMap](https://github.com/wtsi-hpag/PretextMap) and [PretextSnapshot](https://github.com/wtsi-hpag/PretextSnapshot).

Throughout the process, the workflow continuously monitors assembly quality and completeness. [BUSCO](https://busco.ezlab.org/) is used to assess gene content conservation, [QUAST](https://github.com/ablab/quast) provides structural statistics, and [Merqury](https://github.com/marbl/merqury) evaluates k-mer based accuracy and completeness. This comprehensive suite of tools ensures a highly accurate and contiguous final genomic sequence.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Bionano_dataset | data_input |  |
| 1 | Hi-C_dataset_R | data_input |  |
| 2 | Hi-C_dataset_F | data_input |  |
| 3 | Input Dataset Collection | data_collection_input |  |


Ensure all sequencing data is correctly formatted, specifically using fastq.gz for Hi-C reads and appropriate Bionano datasets, while organizing raw reads into a data collection to streamline downstream processing. Verify that the Hi-C forward and reverse datasets are paired correctly to avoid errors during the BWA-MEM2 mapping stages. For comprehensive configuration details and parameter settings, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution. These preparations ensure the assembly and purging tools receive the high-quality inputs required for an accurate VGP-standard assembly.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 5 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 6 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/3.5+galaxy2 |  |
| 7 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 8 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 9 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 10 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 11 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 12 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 13 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy4 |  |
| 14 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 15 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 16 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 17 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 18 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy1 |  |
| 19 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 20 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1 |  |
| 21 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 22 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 23 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.6 |  |
| 24 | Bionano Hybrid Scaffold | toolshed.g2.bx.psu.edu/repos/bgruening/bionano_scaffold/bionano_scaffold/3.7.0+galaxy0 |  |
| 25 | Concatenate datasets | cat1 |  |
| 26 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 27 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 28 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.6 |  |
| 29 | Concatenate datasets | cat1 |  |
| 30 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 31 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 32 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 33 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 34 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 35 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 36 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 37 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 38 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy4 |  |
| 39 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 40 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 41 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 42 | Convert | Convert characters1 |  |
| 43 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy0 |  |
| 44 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 45 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 46 | bedtools BAM to BED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtobed/2.30.0+galaxy2 |  |
| 47 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0 |  |
| 48 | Purge overlaps | toolshed.g2.bx.psu.edu/repos/iuc/purge_dups/purge_dups/1.2.5+galaxy4 |  |
| 49 | Sort | sort1 |  |
| 50 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1 |  |
| 51 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 52 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy4 |  |
| 53 | SALSA | toolshed.g2.bx.psu.edu/repos/iuc/salsa/salsa/2.3+galaxy2 |  |
| 54 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 55 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 56 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 57 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy4 |  |
| 58 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy0 |  |
| 59 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0 |  |
| 60 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
