---
name: workflow-constructed-from-history-stacks-rad-population-geno
description: This workflow performs reference-based RAD-Seq data analysis for population genomics by processing raw FASTQ reads, demultiplexing with Stacks, mapping sequences to a reference genome using BWA, and calculating population-level statistics. Use this skill when you need to identify single nucleotide polymorphisms and assess genetic diversity or population structure in ecological studies where a reference genome is available for the target species.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-stacks-rad-population-geno

## Overview

This Galaxy workflow provides a comprehensive pipeline for reference-based RAD-Seq (Restriction site Associated DNA sequencing) data analysis, specifically tailored for population genomics. Based on [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) methodologies, it automates the transition from raw sequencing reads to population-level statistics by leveraging a known reference genome.

The process begins with data retrieval and preparation, importing raw FASTQ files from the [EBI SRA](ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR034/SRR034310/SRR034310.fastq.gz) and essential metadata from [Zenodo](https://zenodo.org/record/1134547). Initial steps utilize `Stacks: process radtags` for demultiplexing and cleaning reads, while `FastQC` and `MultiQC` provide rigorous quality control assessments. A series of text-processing tools are used to format population maps and barcodes required for the Stacks suite.

The core analysis involves aligning the processed reads to a reference genome using `Map with BWA`. These alignments are then fed into `Stacks: reference map` to identify loci and `Stacks: populations` to calculate genetic diversity and differentiation metrics. The workflow concludes with filtering and summary statistics, making it a robust tool for researchers in ecology and evolutionary biology.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | EBI SRA: SRR034310 File: ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR034/SRR034310/SRR034310.fastq.gz | data_input |  |
| 1 | https://zenodo.org/record/1134547/files/Barcode_SRR034310.txt | data_input |  |
| 2 | https://zenodo.org/record/1134547/files/Details_Barcode_Population_SRR034310.txt | data_input |  |
| 3 | https://zenodo.org/record/1134547/files/Reference_genome_11_chromosomes.fasta | data_input |  |


To execute this RAD-Seq workflow, ensure your raw sequence data is in FASTQ.GZ format and your reference genome is a standard FASTA file. You must provide a tab-separated barcode file and a population map to correctly demultiplex and group samples within the Stacks suite. While individual datasets are used for initial processing, organizing large sample sets into collections can significantly streamline the mapping and reference-map steps. For automated job configuration and testing, you can use `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the README.md for comprehensive details on parameter settings and metadata requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 5 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 6 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 7 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1 |  |
| 8 | Select | Grep1 |  |
| 9 | Select | Grep1 |  |
| 10 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.71 |  |
| 11 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 12 | Select | Grep1 |  |
| 13 | Select | Grep1 |  |
| 14 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1 |  |
| 15 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1 |  |
| 16 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1 |  |
| 17 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.6 |  |
| 18 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1 |  |
| 19 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1 |  |
| 20 | Add column | addValue |  |
| 21 | Concatenate datasets | cat1 |  |
| 22 | Cut | Cut1 |  |
| 23 | Convert | Convert characters1 |  |
| 24 | Regex Replace | toolshed.g2.bx.psu.edu/repos/kellrott/regex_replace/regex_replace/1.0.0 |  |
| 25 | Stacks: reference map | toolshed.g2.bx.psu.edu/repos/iuc/stacks_refmap/stacks_refmap/1.46.0 |  |
| 26 | Stacks: populations | toolshed.g2.bx.psu.edu/repos/iuc/stacks_populations/stacks_populations/1.46.0 |  |
| 27 | Summary Statistics | Summary_Statistics1 |  |
| 28 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 29 | Count | Count1 |  |
| 30 | Filter | Filter1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-workflow-constructed-from-history--stacks-rad--population-genomics-with-reference-genome-.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-workflow-constructed-from-history--stacks-rad--population-genomics-with-reference-genome-.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-workflow-constructed-from-history--stacks-rad--population-genomics-with-reference-genome-.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-workflow-constructed-from-history--stacks-rad--population-genomics-with-reference-genome-.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-workflow-constructed-from-history--stacks-rad--population-genomics-with-reference-genome-.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-workflow-constructed-from-history--stacks-rad--population-genomics-with-reference-genome-.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)