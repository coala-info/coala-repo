---
name: srna-seq-step-2-salmon-and-deseq2
description: This transcriptomics workflow performs small RNA quantification and differential abundance analysis using Salmon and DESeq2 on control and case dataset collections paired with a reference transcriptome and gene mapping file. Use this skill when you need to identify differentially expressed small RNAs and determine their statistical significance across different experimental conditions.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# srna-seq-step-2-salmon-and-deseq2

## Overview

This workflow facilitates the second stage of small RNA sequencing (sRNA-seq) analysis, specifically designed to follow the [GTN](https://training.galaxyproject.org/) tutorial for transcriptomics. It transitions from raw sequence processing to biological interpretation by quantifying transcript abundance and performing differential expression testing between experimental conditions.

The process begins with [Salmon](https://salmon.readthedocs.io/en/latest/salmon.html), which performs quasi-mapping and quantification of sRNA transcripts. It utilizes dataset collections for both "Control" and "Case" samples, requiring a reference transcriptome and a transcript-to-gene (Tx2Gene) mapping file to accurately assign counts to specific genomic features.

Following quantification, the workflow employs [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html) to model the data and identify differentially expressed sRNAs. The final steps involve automated filtering to refine the output, allowing researchers to isolate statistically significant results for downstream functional analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Dataset collection - Control | data_collection_input |  |
| 1 | Dataset - Ref Txome | data_input |  |
| 2 | Dataset collection - Case | data_collection_input |  |
| 3 | Tx2Gene reference | data_input | Tab-delimited |


Ensure your Control and Case samples are organized into list collections of fastq or fastq.gz files to facilitate batch processing through Salmon. The reference transcriptome must be a FASTA file, while the Tx2Gene mapping requires a tabular format linking transcript IDs to gene names for proper aggregation. Consult the accompanying README.md for specific naming conventions and detailed metadata requirements for the DESeq2 contrast design. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Salmon | toolshed.g2.bx.psu.edu/repos/bgruening/salmon/salmon/0.8.2 | Salmon quantification on control datasets calculating SF/sense hits |
| 5 | Salmon | toolshed.g2.bx.psu.edu/repos/bgruening/salmon/salmon/0.8.2 | Salmon quantification on control datasets calculating SR/antisense hits |
| 6 | Salmon | toolshed.g2.bx.psu.edu/repos/bgruening/salmon/salmon/0.8.2 | Salmon quantification on case datasets calculating SF/sense hits |
| 7 | Salmon | toolshed.g2.bx.psu.edu/repos/bgruening/salmon/salmon/0.8.2 | Salmon quantification on case datasets calculating SR/antisense hits |
| 8 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.39 | Calculating differential abundance of SF/sense hits |
| 9 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.39 | Calculating differential abundance of SR/antisense hits |
| 10 | Filter | Filter1 |  |
| 11 | Filter | Filter1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run srna-seq-step-2-salmon-and-deseq2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run srna-seq-step-2-salmon-and-deseq2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run srna-seq-step-2-salmon-and-deseq2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init srna-seq-step-2-salmon-and-deseq2.ga -o job.yml`
- Lint: `planemo workflow_lint srna-seq-step-2-salmon-and-deseq2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `srna-seq-step-2-salmon-and-deseq2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)