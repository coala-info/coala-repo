---
name: qc-mapping-counting-singlepaired-ref-based-rna-seq-transcrip
description: "This transcriptomics workflow processes single-end and paired-end RNA-Seq FASTQ files through quality control, adapter trimming with Cutadapt, reference-based alignment using RNA STAR, and gene-level quantification with featureCounts. Use this skill when you need to generate expression count matrices and quality metrics from raw sequencing data to support downstream differential gene expression analysis in reference-based transcriptomic studies."
homepage: https://workflowhub.eu/workflows/1715
---

# QC + Mapping + Counting (single+paired) - Ref Based RNA Seq - Transcriptomics - GTN

## Overview

This workflow provides a comprehensive pipeline for reference-based RNA-Seq data analysis, capable of processing both single-end and paired-end sequencing data simultaneously. Based on [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) best practices for transcriptomics, it automates the transition from raw sequence reads to quantified gene expression levels using a *Drosophila melanogaster* reference.

The pipeline begins with rigorous preprocessing, utilizing [Cutadapt](https://cutadapt.readthedocs.io/) for adapter trimming and [Falco](https://github.com/isovic/falco) for initial quality control. Reads are then aligned to the reference genome using [RNA STAR](https://github.com/alexdobin/STAR). The workflow is structured to handle complex collections, incorporating subworkflows to automatically determine library strandness and perform specialized QC at various stages of the mapping process.

Post-alignment, the workflow employs [featureCounts](https://subread.sourceforge.net/featureCounts.html) to calculate gene-level abundances. It generates several [MultiQC](https://multiqc.info/) reports that aggregate metrics from trimming, mapping, and quantification into accessible HTML summaries. Final outputs include sorted count tables and BAM files compatible with the integrated [JBrowse2](https://jbrowse.org/jb2/) genome browser for visual inspection of alignment data.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | single fastqs | data_collection_input |  |
| 1 | paired fastqs | data_collection_input |  |
| 2 | Drosophila_melanogaster.BDGP6.32.109_UCSC.gtf.gz | data_input |  |


Ensure your sequencing reads are organized into list collections for single-end data and paired-end list collections for paired data to ensure compatibility with the merge and flatten steps. Use FASTQ format for reads and a compressed or uncompressed GTF file for the reference annotation. For comprehensive details on parameter configuration and metadata, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.2+galaxy0 |  |
| 4 | Flatten collection | __FLATTEN__ |  |
| 5 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.2+galaxy0 |  |
| 6 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.11b+galaxy0 |  |
| 7 | Merge collections | __MERGE_COLLECTION__ |  |
| 8 | Merge collections | __MERGE_COLLECTION__ |  |
| 9 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.11b+galaxy0 |  |
| 10 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.1.1+galaxy0 |  |
| 11 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 12 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |
| 13 | Merge collections | __MERGE_COLLECTION__ |  |
| 14 | Merge collections | __MERGE_COLLECTION__ |  |
| 15 | Merge collections | __MERGE_COLLECTION__ |  |
| 16 | Merge collections | __MERGE_COLLECTION__ |  |
| 17 | Merge collections | __MERGE_COLLECTION__ |  |
| 18 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.1.1+galaxy0 |  |
| 19 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |
| 20 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |
| 21 | count STAR | (subworkflow) |  |
| 22 | JBrowse2 | toolshed.g2.bx.psu.edu/repos/fubar/jbrowse2/jbrowse2/3.6.5+galaxy1 |  |
| 23 | more QC | (subworkflow) |  |
| 24 | Determine strandness | (subworkflow) |  |
| 25 | Merge collections | __MERGE_COLLECTION__ |  |
| 26 | Merge collections | __MERGE_COLLECTION__ |  |
| 27 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 28 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 12 | multiqc_cutadapt_html | html_report |
| 15 | STAR_BAM | output |
| 18 | featureCounts_gene_length | output_feature_lengths |
| 19 | multiqc_falco_html | html_report |
| 20 | multiqc_star_html | html_report |
| 25 | featureCounts | output |
| 27 | featureCounts_sorted | outfile |
| 28 | multiqc_featureCounts_html | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run qc-mapping-counting-paired-and-single.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run qc-mapping-counting-paired-and-single.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run qc-mapping-counting-paired-and-single.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init qc-mapping-counting-paired-and-single.ga -o job.yml`
- Lint: `planemo workflow_lint qc-mapping-counting-paired-and-single.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `qc-mapping-counting-paired-and-single.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
