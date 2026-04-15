---
name: rna-seq-reads-to-counts
description: This transcriptomics workflow processes raw FASTQ read collections and reference gene BED files using FastQC, Cutadapt, HISAT2, and featureCounts to generate gene-level expression counts. Use this skill when you need to transform raw RNA-Seq sequencing data into a count matrix for downstream differential gene expression analysis while performing comprehensive quality control and alignment.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# rna-seq-reads-to-counts

## Overview

This workflow automates the transition from raw transcriptomics data to a gene expression count matrix. It begins by assessing raw sequence quality using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72) and performing adapter trimming via [Cutadapt](https://toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.3) to ensure high-quality input for downstream analysis.

Processed reads are aligned to a reference genome using [HISAT2](https://toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy3). Following alignment, [featureCounts](https://toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.3) calculates the number of reads mapped to genomic features based on a provided reference gene BED file, while [MarkDuplicates](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.1) identifies potential PCR artifacts.

The pipeline includes extensive post-alignment diagnostics using RSeQC tools to evaluate [Gene Body Coverage](https://toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_geneBody_coverage/2.6.4.3) and [Read Distribution](https://toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_read_distribution/2.6.4.1). Finally, [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.6) aggregates all quality metrics into a single comprehensive report, providing a clear overview of the experiment's performance.

This workflow is aligned with [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards for transcriptomics, making it suitable for both production-level bioinformatics and educational purposes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input FASTQs collection | data_collection_input |  |
| 1 | Input Reference gene BED | data_input |  |


Ensure your sequencing data is organized into a paired-end or single-end collection of FASTQ files, while the reference gene annotations must be provided as a single BED dataset. Verify that FASTQ headers and BED coordinates match the same reference genome assembly to avoid mapping errors during the HISAT2 and featureCounts steps. Consult the `README.md` for comprehensive instructions on data formatting and specific parameter requirements for the RSeQC tools. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72 |  |
| 3 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.3 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72 |  |
| 5 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy3 |  |
| 6 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.3 |  |
| 7 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.1 |  |
| 8 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.2 |  |
| 9 | Gene Body Coverage (BAM) | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_geneBody_coverage/2.6.4.3 |  |
| 10 | Infer Experiment | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_infer_experiment/2.6.4.1 |  |
| 11 | Read Distribution | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_read_distribution/2.6.4.1 |  |
| 12 | Column Join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 13 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.6 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rna-seq-reads-to-counts.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rna-seq-reads-to-counts.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rna-seq-reads-to-counts.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rna-seq-reads-to-counts.ga -o job.yml`
- Lint: `planemo workflow_lint rna-seq-reads-to-counts.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rna-seq-reads-to-counts.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)