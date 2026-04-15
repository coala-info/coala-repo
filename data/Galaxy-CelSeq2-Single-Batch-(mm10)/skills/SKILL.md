---
name: celseq2-single-batch-mm10
description: This transcriptomics workflow processes CelSeq2 single-cell RNA-seq batches using UMI-tools for barcode extraction and counting, RNA STAR for alignment to the mm10 genome, and featureCounts for gene quantification. Use this skill when you need to generate gene expression count matrices from raw mouse scRNA-seq data to analyze cellular heterogeneity or differential expression.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# celseq2-single-batch-mm10

## Overview

This workflow provides a standardized pipeline for the pre-processing of single-cell RNA-seq data generated via the CelSeq2 protocol, specifically configured for the *Mus musculus* (mm10) genome. It handles the initial processing of a sequencing batch by utilizing a barcode whitelist and a UCSC GTF annotation file to ensure precise gene mapping and quantification.

The pipeline begins with [UMI-tools extract](https://umi-tools.readthedocs.io/en/latest/reference/extract.html) to manage cell barcodes and Unique Molecular Identifiers (UMIs), followed by read alignment using [RNA STAR](https://github.com/alexdobin/STAR). After filtering the aligned reads for quality, the workflow employs [featureCounts](https://subread.sourceforge.net/featureCounts.html) to assign reads to genomic features and [UMI-tools count](https://umi-tools.readthedocs.io/en/latest/reference/count.html) to generate the final digital expression matrix by collapsing duplicate UMIs.

Key outputs include mapped BAM files, chimeric junction data, and the final gene count matrix required for downstream differential expression or clustering analysis. This workflow follows best practices for transcriptomics as outlined by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), ensuring a reproducible path from raw reads to quantified expression data.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Batch | data_collection_input |  |
| 1 | Barcodes (single-col) | data_input |  |
| 2 | GTF file (UCSC) | data_input |  |


Ensure your raw sequencing reads are organized into a paired-end data collection for the "Batch" input, while the barcodes must be a single-column tabular file and the annotation a UCSC-formatted GTF. Verify that the chromosome identifiers in your GTF file strictly match those in the reference genome used by RNA STAR to ensure successful feature counting. For comprehensive details on barcode patterns and specific tool parameters, refer to the README.md file. You can streamline the configuration of these inputs by using `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | UMI-tools extract | toolshed.g2.bx.psu.edu/repos/iuc/umi_tools_extract/umi_tools_extract/0.5.3.2 |  |
| 4 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.5.2b-2 | The genome should match that of the GTF file |
| 5 | Filter | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.4.1 |  |
| 6 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.2 |  |
| 7 | UMI-tools count | toolshed.g2.bx.psu.edu/repos/iuc/umi_tools_count/umi_tools_count/0.5.3.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | out2 | out2 |
| 4 | chimeric_reads | chimeric_reads |
| 4 | chimeric_junctions | chimeric_junctions |
| 4 | reads_per_gene | reads_per_gene |
| 4 | splice_junctions | splice_junctions |
| 4 | mapped_reads | mapped_reads |
| 4 | output_log | output_log |
| 6 | output_bam | output_bam |
| 7 | out_counts | out_counts |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scrna-pp-celseq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scrna-pp-celseq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scrna-pp-celseq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scrna-pp-celseq.ga -o job.yml`
- Lint: `planemo workflow_lint scrna-pp-celseq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scrna-pp-celseq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)