---
name: comparison-of-two-annotation-tools-helixer-and-braker3
description: This Galaxy workflow performs comparative genome annotation using Helixer and BRAKER3 by processing genome sequences, RNA-seq alignments, and protein data, followed by quality assessment with BUSCO, OMArk, and JBrowse. Use this skill when you need to evaluate and compare the accuracy of different gene prediction methodologies to ensure high-quality structural annotations for a newly sequenced organism.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# comparison-of-two-annotation-tools-helixer-and-braker3

## Overview

This Galaxy workflow facilitates a comparative analysis between two prominent genome annotation tools: [Helixer](https://toolshed.g2.bx.psu.edu/repos/genouest/helixer/helixer/0.3.3+galaxy1), which utilizes deep learning, and [BRAKER3](https://toolshed.g2.bx.psu.edu/repos/genouest/braker3/braker3/3.0.8+galaxy0), which integrates RNA-seq and protein homology data. By executing both pipelines in parallel on the same genomic input, users can evaluate how different algorithmic approaches and evidence types impact the accuracy and completeness of gene prediction.

The process begins with a genome sequence and supporting evidence, including RNA-seq alignments and protein sequences. After the primary annotation steps, [gffread](https://toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0) is used to extract predicted protein sequences from both tools. The workflow then performs a comprehensive quality assessment using [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy0) to check for conserved orthologs and [OMArk](https://toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.1+galaxy0) for proteome consistency and taxonomic placement.

Final outputs include detailed summary statistics, BUSCO completeness plots, and an interactive [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) instance for visual inspection of the gene models. This workflow is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) standards to optimize annotation strategies for novel genomes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genome sequence | data_input | Input dataset containing genomic sequences in FASTA format |
| 1 | Alignments from RNA-seq | data_input | Alignments from RNA-seq |
| 2 | Protein sequences | data_input | Protein sequences |


Ensure your genome sequence and protein references are in FASTA format, while RNA-seq alignments must be provided as coordinate-sorted BAM files to ensure compatibility with BRAKER3. While individual datasets are standard for these inputs, using collections can streamline the management of multiple protein reference sets or RNA-seq libraries across the workflow. Refer to the README.md for specific parameter requirements and detailed data preparation instructions. You can automate the setup of these input parameters by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Helixer | toolshed.g2.bx.psu.edu/repos/genouest/helixer/helixer/0.3.3+galaxy1 | Helixer tool for genomic annotation |
| 4 | BRAKER3 | toolshed.g2.bx.psu.edu/repos/genouest/braker3/braker3/3.0.8+galaxy0 | Braker3 is an automated bioinformatics tool that uses RNA-seq and protein data to annotate genomes. |
| 5 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 | Converts GFF files to other formats, such as FASTA |
| 6 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 | JBrowse |
| 7 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 | Converts GFF files to other formats, such as FASTA |
| 8 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy0 | Completeness assessment of the genome using the Busco tool |
| 9 | OMArk | toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.1+galaxy0 | OMArk |
| 10 | OMArk | toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.1+galaxy0 | OMArk |
| 11 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy0 | Completeness assessment of the genome using the Busco tool |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | helixer output | output |
| 5 | predicted proteins Helixer annotation | output_pep |
| 6 | output | output |
| 7 | predicted proteins Braker3 annotation | output_pep |
| 8 | busco gff predicted proteins Helixer | busco_gff |
| 8 | busco image predicted proteins Helixer | summary_image |
| 8 | busco missing predicted proteins Helixer | busco_missing |
| 8 | busco table predicted proteins Helixer | busco_table |
| 8 | busco sum predicted proteins Helixer | busco_sum |
| 9 | omark detail sum Helixer annotation | omark_detail_sum |
| 10 | omark sum | omark_sum |
| 10 | omark detail sum Braker3 annotation | omark_detail_sum |
| 11 | busco image predicted proteins Braker3 | summary_image |
| 11 | busco gff predicted proteins Braker3 | busco_gff |
| 11 | busco sum predicted proteins Braker3 | busco_sum |
| 11 | busco table predicted proteins Braker3 | busco_table |
| 11 | busco missing predicted proteins Braker3 | busco_missing |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-comparison-of-two-annotation-tools--helixer-and-braker3.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-comparison-of-two-annotation-tools--helixer-and-braker3.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-comparison-of-two-annotation-tools--helixer-and-braker3.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-comparison-of-two-annotation-tools--helixer-and-braker3.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-comparison-of-two-annotation-tools--helixer-and-braker3.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-comparison-of-two-annotation-tools--helixer-and-braker3.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)