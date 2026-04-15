---
name: unicycler-training
description: This Galaxy workflow performs hybrid bacterial genome assembly and annotation by processing paired-end short reads and long reads using FastQC, Unicycler, Quast, and Prokka. Use this skill when you need to produce a high-quality, polished consensus sequence and functional annotation for a bacterial isolate using a combination of short-read and long-read sequencing data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# unicycler-training

## Overview

This Galaxy workflow provides a comprehensive pipeline for bacterial genome assembly and annotation, specifically designed for training purposes following [GTN](https://training.galaxyproject.org/) standards. It utilizes a hybrid assembly approach by integrating forward and reverse short reads with long-read sequencing data to produce high-quality genomic scaffolds.

The process begins with quality control using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) on the raw input reads, followed by de novo assembly using [Unicycler](https://github.com/rrwick/Unicycler). Unicycler functions as a SPAdes-optimizing pipeline that excels at resolving complex bacterial structures by leveraging the accuracy of short reads and the connectivity of long reads.

Post-assembly, the workflow evaluates the results through [QUAST](http://quast.sourceforge.net/quast) for assembly metrics and [MultiQC](https://multiqc.info/) for aggregated quality reporting. Finally, the assembled contigs are automatically annotated using [Prokka](https://github.com/tseemann/prokka), generating a suite of standard output files including GFF, GenBank, and protein FASTA files for downstream functional analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Forward reads | data_input |  |
| 1 | Reverse Reads | data_input |  |
| 2 | Long Reads | data_input |  |


Ensure your input FastQ files are correctly formatted, and consider organizing paired-end reads into a dataset collection to streamline the Unicycler assembly process. Long reads should be uploaded as individual datasets to support the hybrid assembly approach. For comprehensive details on sample metadata and specific parameter settings, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated job submission and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 5 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.8.0 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 7 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy0 |  |
| 8 | Prokka | toolshed.g2.bx.psu.edu/repos/crs4/prokka/prokka/1.14.5 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | html_file | html_file |
| 3 | text_file | text_file |
| 4 | html_file | html_file |
| 4 | text_file | text_file |
| 5 | assembly | assembly |
| 6 | stats | stats |
| 6 | html_report | html_report |
| 7 | quast_tsv | quast_tsv |
| 7 | report_html | report_html |
| 7 | icarus | icarus |
| 8 | tbl | out_tbl |
| 8 | out_txt | out_txt |
| 8 | gbk | out_gbk |
| 8 | out_err | out_err |
| 8 | ffn | out_ffn |
| 8 | out_fsa | out_fsa |
| 8 | out_fna | out_fna |
| 8 | out_log | out_log |
| 8 | out_faa | out_faa |
| 8 | out_sqn | out_sqn |
| 8 | out_gff | out_gff |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run unicycler.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run unicycler.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run unicycler.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init unicycler.ga -o job.yml`
- Lint: `planemo workflow_lint unicycler.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `unicycler.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)