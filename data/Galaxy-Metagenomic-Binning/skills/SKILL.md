---
name: metagenomic-binning
description: This metagenomic workflow processes trimmed reads and assemblies to group contigs into bins using CONCOCT, MetaBAT2, MaxBin2, and SemiBin, followed by bin refinement with Binette. Use this skill when you need to reconstruct individual microbial genomes from complex environmental samples to characterize the taxonomic and functional diversity of a microbiome.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# metagenomic-binning

## Overview

This workflow performs metagenomic binning to group assembled contigs into discrete taxonomic units, facilitating the recovery of metagenome-assembled genomes (MAGs). It requires trimmed reads and corresponding assemblies as primary inputs. By leveraging abundance information through read mapping with [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0) and [Samtools](https://toolshed.g2.bx.psu.edu/repos/devteam/samtools_sort/samtools_sort/2.0.7), the pipeline calculates contig depth and coverage to improve binning accuracy.

The workflow employs an ensemble approach by running four distinct binning tools: [CONCOCT](https://toolshed.g2.bx.psu.edu/repos/iuc/concoct/concoct/1.1.0+galaxy2), [MetaBAT2](https://toolshed.g2.bx.psu.edu/repos/iuc/metabat2/metabat2/2.17+galaxy0), [MaxBin2](https://toolshed.g2.bx.psu.edu/repos/mbernt/maxbin2/maxbin2/2.2.7+galaxy6), and [SemiBin](https://toolshed.g2.bx.psu.edu/repos/iuc/semibin/semibin/2.1.0+galaxy1). This multi-tool strategy allows the pipeline to capture diverse genomic signals, utilizing both sequence composition and differential abundance across samples to maximize the quality of the output.

In the final stages, the results from the different binners are integrated and refined using [Binette](https://toolshed.g2.bx.psu.edu/repos/iuc/binette/binette/1.2.0+galaxy0). This refinement step ensures the selection of the highest quality bins, providing a consolidated set of MAGs for downstream analysis. This workflow is designed for microbiome research and follows [GTN](https://training.galaxyproject.org/) best practices under an MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Trimmed reads | data_collection_input | Samples grouped for co-assembly. For individual assembly use same reads as `Trimmed reads input`. The tool fastq_groupmerge can be used to perform the grouping. |
| 1 | Read length (CONCOCT) | parameter_input | CONCOCT requires the read length for coverage. Best use fastQC to estimate the mean value. |
| 2 | Assemblies | data_collection_input | This workflow allows using a custom assembly as input. If provided, select `custom assembly` as Assembler. Provide one assembly for each group of trimmed input reads. |
| 3 | Environment for the built-in model (SemiBin) | parameter_input | Environment for the built-in model (SemiBin), options are: human_gut, dog_gut, ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater, chicken_caecum, global |


Ensure your input trimmed reads are in FASTQ format and assemblies are provided as FASTA contig files. Organize these inputs into data collections to allow the workflow to process multiple samples simultaneously through the various binning algorithms like MetaBAT2 and SemiBin. Consult the README.md for comprehensive details on preparing your data and selecting appropriate parameters for specific tool environments. For automated execution, you can use `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | CONCOCT: Cut up contigs | toolshed.g2.bx.psu.edu/repos/iuc/concoct_cut_up_fasta/concoct_cut_up_fasta/1.1.0+galaxy2 |  |
| 5 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 6 | Samtools sort | toolshed.g2.bx.psu.edu/repos/devteam/samtools_sort/samtools_sort/2.0.7 |  |
| 7 | CONCOCT: Generate the input coverage table | toolshed.g2.bx.psu.edu/repos/iuc/concoct_coverage_table/concoct_coverage_table/1.1.0+galaxy2 |  |
| 8 | Calculate contig depths | toolshed.g2.bx.psu.edu/repos/iuc/metabat2_jgi_summarize_bam_contig_depths/metabat2_jgi_summarize_bam_contig_depths/2.17+galaxy0 |  |
| 9 | SemiBin | toolshed.g2.bx.psu.edu/repos/iuc/semibin/semibin/2.1.0+galaxy1 |  |
| 10 | CONCOCT | toolshed.g2.bx.psu.edu/repos/iuc/concoct/concoct/1.1.0+galaxy2 |  |
| 11 | MetaBAT2 | toolshed.g2.bx.psu.edu/repos/iuc/metabat2/metabat2/2.17+galaxy0 |  |
| 12 | MaxBin2 | toolshed.g2.bx.psu.edu/repos/mbernt/maxbin2/maxbin2/2.2.7+galaxy6 |  |
| 13 | Converts genome bins in fasta format | toolshed.g2.bx.psu.edu/repos/iuc/fasta_to_contig2bin/Fasta_to_Contig2Bin/1.1.7+galaxy1 |  |
| 14 | CONCOCT: Merge cut clusters | toolshed.g2.bx.psu.edu/repos/iuc/concoct_merge_cut_up_clustering/concoct_merge_cut_up_clustering/1.1.0+galaxy2 |  |
| 15 | Converts genome bins in fasta format | toolshed.g2.bx.psu.edu/repos/iuc/fasta_to_contig2bin/Fasta_to_Contig2Bin/1.1.7+galaxy1 |  |
| 16 | Converts genome bins in fasta format | toolshed.g2.bx.psu.edu/repos/iuc/fasta_to_contig2bin/Fasta_to_Contig2Bin/1.1.7+galaxy1 |  |
| 17 | CONCOCT: Extract a fasta file | toolshed.g2.bx.psu.edu/repos/iuc/concoct_extract_fasta_bins/concoct_extract_fasta_bins/1.1.0+galaxy2 |  |
| 18 | Converts genome bins in fasta format | toolshed.g2.bx.psu.edu/repos/iuc/fasta_to_contig2bin/Fasta_to_Contig2Bin/1.1.7+galaxy1 |  |
| 19 | Build list | __BUILD_LIST__ |  |
| 20 | Binette | toolshed.g2.bx.psu.edu/repos/iuc/binette/binette/1.2.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run metagenomic-binning.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run metagenomic-binning.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run metagenomic-binning.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init metagenomic-binning.ga -o job.yml`
- Lint: `planemo workflow_lint metagenomic-binning.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `metagenomic-binning.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)