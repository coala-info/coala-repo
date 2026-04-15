---
name: qc-mapping-counting-ref-based-rna-seq-transcriptomics-gtn-su
description: This transcriptomics workflow processes paired-end RNA-Seq FASTQ reads and GTF annotations using Cutadapt, STAR, and featureCounts to perform quality control, mapping, and gene expression quantification. Use this skill when you need to transform raw sequencing reads into count matrices for downstream differential expression analysis in studies involving organisms with a reference genome.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# qc-mapping-counting-ref-based-rna-seq-transcriptomics-gtn-su

## Overview

This workflow provides a comprehensive pipeline for reference-based RNA-Seq data analysis, following the best practices established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It is structured using modular subworkflows to handle the transition from raw sequencing reads to quantified gene expression levels. The pipeline accepts paired-end FASTQ collections and a reference GTF annotation file as primary inputs.

The initial processing stages focus on quality assurance and read preparation. The workflow executes initial quality control using [Falco](https://github.com/pireddu/falco) and [MultiQC](https://multiqc.info/), followed by adapter and quality trimming via [Cutadapt](https://cutadapt.readthedocs.io/). Cleaned reads are then aligned to the reference genome using the [STAR](https://github.com/alexdobin/STAR) aligner, which includes integrated mapping statistics and support for genome browsing through [JBrowse2](https://gmod.github.io/jbrowse2/).

To ensure accurate downstream quantification, the workflow includes a specialized subworkflow to automatically determine library strandness. Final gene counts are generated using two parallel methods: STAR’s internal counting functionality and [featureCounts](https://subread.sourceforge.net/featureCounts.html). This dual-quantification approach, supplemented by additional QC steps, produces a robust count matrix suitable for differential expression analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired list collection with PE fastqs | data_collection_input | input fastqs |
| 1 | Drosophila_melanogaster.BDGP6.32.109_UCSC.gtf.gz | data_input | gtf with genes |


Ensure your raw sequencing data is organized into a paired-end list collection to enable efficient batch processing through the QC, trimming, and STAR mapping subworkflows. The reference annotation must be provided in GTF format to ensure compatibility with the feature counting and JBrowse2 visualization steps. For comprehensive instructions on parameter configuration and reference genome preparation, refer to the `README.md` file. You can also use `planemo workflow_job_init` to quickly generate a `job.yml` for local execution or testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | QC-Falco-MultiQC | (subworkflow) |  |
| 3 | cutadapt | (subworkflow) |  |
| 4 | STAR + multiQC | (subworkflow) |  |
| 5 | JBrowse2 | toolshed.g2.bx.psu.edu/repos/fubar/jbrowse2/jbrowse2/3.6.5+galaxy1 |  |
| 6 | Determine strandness | (subworkflow) |  |
| 7 | more QC | (subworkflow) |  |
| 8 | count STAR | (subworkflow) |  |
| 9 | count featureCount | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run qc-mapping-counting.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run qc-mapping-counting.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run qc-mapping-counting.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init qc-mapping-counting.ga -o job.yml`
- Lint: `planemo workflow_lint qc-mapping-counting.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `qc-mapping-counting.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)