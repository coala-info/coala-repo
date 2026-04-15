---
name: essential-genes-detection-with-transposon-insertion-sequenci
description: This genomics workflow processes transposon insertion sequencing (Tn-Seq) data using Cutadapt for demultiplexing, Bowtie for mapping reads to a reference genome, and the Transit Gumbel method to statistically identify essential genes. Use this skill when you need to determine which genes are critical for bacterial survival under specific experimental conditions by analyzing the distribution and frequency of transposon insertions across the genome.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# essential-genes-detection-with-transposon-insertion-sequenci

## Overview

This workflow provides a comprehensive pipeline for identifying essential genes in bacterial genomes using Transposon Insertion Sequencing (Tn-Seq). It is designed to process raw sequencing reads, demultiplex them based on condition and construct barcodes, and map the resulting sequences to a reference genome. The workflow is particularly useful for researchers working on genome annotation and functional genomics, following methodologies often highlighted in [GTN](https://training.galaxyproject.org/) tutorials.

The analysis begins with extensive data preprocessing using [Cutadapt](https://cutadapt.readthedocs.io/) to trim adapters and filter reads by barcodes. Once cleaned, reads are aligned to the reference genome using [Bowtie](http://bowtie-bio.sourceforge.net/index.shtml). The pipeline also handles genomic annotation files (GFF3), converting them into formats suitable for downstream statistical analysis while calculating insertion site densities across the genome.

The core of the essentiality testing is performed using the [Gumbel](https://transit.readthedocs.io/en/latest/transit_methods.html#gumbel) method from the TRANSIT toolset. This statistical approach calculates the probability of gene essentiality by analyzing the longest gaps between transposon insertions. By comparing insertion patterns across different experimental conditions, the workflow identifies which genes are required for survival under specific pressures.

Final outputs include detailed reports of insertion sites, filtered lists of essential genes for both control and experimental conditions, and comparative datasets. These results allow for the identification of "conditionally essential" genes, providing insights into the genetic requirements of the organism in varying environments.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Tnseq-Tutorial-reads.fastqsanger.gz | data_input |  |
| 1 | condition_barcodes.fasta | data_input |  |
| 2 | construct_barcodes.fasta | data_input |  |
| 3 | staph_aur.fasta | data_input |  |
| 4 | staph_aur.gff3 | data_input |  |


Ensure your input sequencing data is in fastqsanger.gz format, while the reference genome and annotation must be provided as FASTA and GFF3 files respectively. Barcode files for conditions and constructs should be uploaded as individual datasets to facilitate the demultiplexing and trimming steps performed by Cutadapt. For large-scale analysis, you can automate the setup using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific barcode configurations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 6 | Nucleotide subsequence search | toolshed.g2.bx.psu.edu/repos/bgruening/find_subsequences/bg_find_subsequences/0.2 |  |
| 7 | Convert GFF3 | toolshed.g2.bx.psu.edu/repos/iuc/gff_to_prot/gff_to_prot/3.0.2+galaxy0 |  |
| 8 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 9 | Cut | Cut1 |  |
| 10 | Cut | Cut1 |  |
| 11 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 12 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.3.0 |  |
| 13 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 14 | Cut | Cut1 |  |
| 15 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 16 | Map with Bowtie for Illumina | toolshed.g2.bx.psu.edu/repos/devteam/bowtie_wrappers/bowtie_wrapper/1.2.0 |  |
| 17 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.2.0.0 |  |
| 18 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 19 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 20 | Cut | Cut1 |  |
| 21 | Cut | Cut1 |  |
| 22 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 23 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.3.0 |  |
| 24 | Cut | Cut1 |  |
| 25 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 26 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 27 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.3.0 |  |
| 28 | Cut | Cut1 |  |
| 29 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 30 | Gumbel | toolshed.g2.bx.psu.edu/repos/iuc/transit_gumbel/transit_gumbel/3.0.2+galaxy0 |  |
| 31 | Filter | Filter1 |  |
| 32 | Extract Dataset | __EXTRACT_DATASET__ |  |
| 33 | Extract Dataset | __EXTRACT_DATASET__ |  |
| 34 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 35 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 36 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | split_output | split_output |
| 5 | report | report |
| 6 | output | output |
| 7 | output | output |
| 8 | out1 | out1 |
| 8 | report | report |
| 9 | out_file1 | out_file1 |
| 10 | out_file1 | out_file1 |
| 11 | report | report |
| 11 | out1 | out1 |
| 12 | out_file1 | out_file1 |
| 13 | split_output | split_output |
| 13 | report | report |
| 14 | out_file1 | out_file1 |
| 15 | out1 | out1 |
| 15 | report | report |
| 16 | output | output |
| 17 | outFileName | outFileName |
| 18 | output | output |
| 19 | output | output |
| 20 | out_file1 | out_file1 |
| 21 | out_file1 | out_file1 |
| 22 | outfile | outfile |
| 23 | out_file1 | out_file1 |
| 24 | out_file1 | out_file1 |
| 25 | outfile | outfile |
| 26 | output | output |
| 27 | out_file1 | out_file1 |
| 28 | out_file1 | out_file1 |
| 29 | outfile | outfile |
| 30 | sites | sites |
| 31 | out_file1 | out_file1 |
| 32 | control | output |
| 33 | condition | output |
| 34 | essential_both | output |
| 35 | essential_control | output |
| 36 | essential_condition | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run essential-genes-detection-transposon-insertion-sequencing-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run essential-genes-detection-transposon-insertion-sequencing-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run essential-genes-detection-transposon-insertion-sequencing-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init essential-genes-detection-transposon-insertion-sequencing-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint essential-genes-detection-transposon-insertion-sequencing-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `essential-genes-detection-transposon-insertion-sequencing-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)