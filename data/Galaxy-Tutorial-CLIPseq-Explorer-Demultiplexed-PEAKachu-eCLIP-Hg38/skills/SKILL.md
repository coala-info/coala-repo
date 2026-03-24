---
name: tutorial-clipseq-explorer-demultiplexed-peakachu-eclip-hg38
description: "This transcriptomics workflow processes demultiplexed paired-end eCLIP data using Cutadapt, RNA STAR, and PEAKachu to perform peak calling and motif detection against a background control. Use this skill when you need to identify protein-RNA binding sites, analyze binding motifs, and characterize the functional distribution of cross-linked sites across the human genome."
homepage: https://workflowhub.eu/workflows/1706
---

# Tutorial CLIPseq Explorer Demultiplexed PEAKachu eCLIP Hg38

## Overview

This Galaxy workflow provides a comprehensive pipeline for the analysis of eCLIP-Seq data, specifically designed for demultiplexed paired-end reads mapped to the Human genome (Hg38). It automates the transition from raw sequencing data to biological insights, covering essential stages such as quality control, adapter trimming with [Cutadapt](https://cutadapt.readthedocs.io/), and UMI extraction and deduplication using [UMI-tools](https://github.com/CGATOxford/UMI-tools).

The core analysis utilizes [RNA STAR](https://github.com/alexdobin/STAR) for genomic alignment, followed by peak calling via [PEAKachu](https://github.com/rnateam/peakachu) to identify protein-RNA interaction sites. The workflow integrates background control sets to ensure the specificity of the enriched signals. Post-processing steps include the generation of bigWig coverage files for visualization and quality assessment using [deepTools](https://deeptools.readthedocs.io/) for fingerprint and correlation plotting.

The final stages of the pipeline focus on functional characterization and motif discovery. It employs [MEME-ChIP](https://meme-suite.org/meme/tools/meme-chip) for identifying conserved sequence motifs within the identified peaks and [RCAS](https://bioconductor.org/packages/release/bioc/html/RCAS.html) for detailed RNA centric annotation and analysis. This workflow is ideal for researchers performing transcriptomics studies who require a robust, reproducible method for detecting RNA-binding protein binding sites and their associated motifs.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Background | data_collection_input |  |
| 1 | Enriched set as a paired-end reads collection | data_collection_input |  |
| 2 | Annotation Reference File for RCAS | data_input |  |
| 3 | Genome Chromosome Sizes | data_input |  |


Ensure your enriched and background eCLIP reads are organized into paired-end data collections to maintain sample relationships throughout the demultiplexing and mapping stages. You will need a GTF/GFF3 annotation file for RCAS and a standard tab-delimited chromosome sizes file compatible with the Hg38 genome. Verify that your fastq headers contain the necessary UMI sequences for the UMI-tools extraction steps. For a comprehensive guide on parameter settings and data structure, refer to the README.md. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 5 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/4.0+galaxy1 |  |
| 6 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 7 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/4.0+galaxy1 |  |
| 8 | UMI-tools extract | toolshed.g2.bx.psu.edu/repos/iuc/umi_tools_extract/umi_tools_extract/1.1.2+galaxy2 |  |
| 9 | UMI-tools extract | toolshed.g2.bx.psu.edu/repos/iuc/umi_tools_extract/umi_tools_extract/1.1.2+galaxy2 |  |
| 10 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.8a+galaxy1 |  |
| 11 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.8a+galaxy1 |  |
| 12 | UMI-tools deduplicate | toolshed.g2.bx.psu.edu/repos/iuc/umi_tools_dedup/umi_tools_dedup/1.1.2+galaxy2 |  |
| 13 | UMI-tools deduplicate | toolshed.g2.bx.psu.edu/repos/iuc/umi_tools_dedup/umi_tools_dedup/1.1.2+galaxy2 |  |
| 14 | Extract alignment ends | toolshed.g2.bx.psu.edu/repos/iuc/bctools_extract_alignment_ends/bctools_extract_alignment_ends/0.2.2 |  |
| 15 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 16 | PEAKachu | toolshed.g2.bx.psu.edu/repos/rnateam/peakachu/peakachu/0.1.0.2 |  |
| 17 | Merge collections | __MERGE_COLLECTION__ |  |
| 18 | Extract alignment ends | toolshed.g2.bx.psu.edu/repos/iuc/bctools_extract_alignment_ends/bctools_extract_alignment_ends/0.2.2 |  |
| 19 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 20 | Sort | sort1 |  |
| 21 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 22 | Sort collection | __SORTLIST__ |  |
| 23 | Sort | sort1 |  |
| 24 | Create a BedGraph of genome coverage | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_genomecoveragebed_bedgraph/2.19.0 |  |
| 25 | bedtools SlopBed | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_slopbed/2.30.0+galaxy1 |  |
| 26 | plotFingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_fingerprint/deeptools_plot_fingerprint/3.5.1.0.0 |  |
| 27 | multiBamSummary | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_multi_bam_summary/deeptools_multi_bam_summary/3.5.1.0.0 |  |
| 28 | Create a BedGraph of genome coverage | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_genomecoveragebed_bedgraph/2.19.0 |  |
| 29 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 30 | Extract Genomic DNA | toolshed.g2.bx.psu.edu/repos/iuc/extract_genomic_dna/Extract genomic DNA 1/3.0.3+galaxy2 |  |
| 31 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 32 | plotCorrelation | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_correlation/deeptools_plot_correlation/3.5.1.0.0 |  |
| 33 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 34 | MEME-ChIP | toolshed.g2.bx.psu.edu/repos/iuc/meme_chip/meme_chip/4.11.2+galaxy1 |  |
| 35 | RCAS | toolshed.g2.bx.psu.edu/repos/rnateam/rcas/rcas/1.5.4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | html_file | html_file |
| 6 | html_file | html_file |
| 7 | out_pairs | out_pairs |
| 15 | html_file | html_file |
| 16 | peak_annotations | peak_annotations |
| 16 | peak_tables | peak_tables |
| 16 | MA_plot | MA_plot |
| 19 | html_file | html_file |
| 26 | outFileName | outFileName |
| 32 | outFileName | outFileName |
| 33 | out_file1 | out_file1 |
| 34 | output | output |
| 35 | report | report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run init-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run init-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run init-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init init-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint init-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `init-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
