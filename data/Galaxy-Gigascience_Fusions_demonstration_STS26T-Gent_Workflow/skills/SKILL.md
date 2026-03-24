---
name: gigascience_fusions_demonstration_sts26t-gent_workflow
description: "This cancer genomics workflow processes paired-end RNA-Seq reads against a human reference genome using STAR and Arriba to identify gene fusions and generate a protein fusion database. Use this skill when you need to detect chimeric transcripts and translate them into protein sequences for neoantigen prediction or the study of oncogenic fusion events in tumor samples."
homepage: https://workflowhub.eu/workflows/1792
---

# Gigascience_Fusions_demonstration_STS26T-Gent_Workflow

## Overview

This workflow is designed to identify gene fusions from RNA-Seq data and generate a specialized protein fusion database. It implements the [Arriba](https://github.com/suhrig/arriba) detection framework, a robust methodology for identifying chromosomal rearrangements in cancer research. The pipeline is particularly relevant for [neoantigen](https://training.galaxyproject.org/training-material/topics/proteomics/tutorials/neoantigen-finding/tutorial.html) discovery and proteogenomics workflows.

The process begins by preparing paired-end RNA-Seq reads and a human reference genome. It utilizes [RNA STAR](https://github.com/alexdobin/STAR) for high-performance sequence alignment, followed by the Arriba toolset to detect fusion events. The workflow automatically retrieves essential genomic filters, including protein domains, cytobands, and known fusion blacklists, to refine the results and reduce false positives.

Following detection, the workflow employs a suite of text-processing tools—including AWK, Query Tabular, and Regex—to reformat and filter the raw fusion data. The final output is a comprehensive protein fusion database in FASTA format, ready for downstream analysis. This workflow is licensed under GPL-3.0-or-later and is associated with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | RNA-Seq_Reads_1 | data_input | Forward strand |
| 1 | RNA-Seq_Reads_2 | data_input | Reverse strand |
| 2 | human_reference_genome_annotation.gtf | data_input | human GTF |
| 3 | human_reference_genome.fasta | data_input | Reference HUMAN FASTA |


Ensure your input RNA-Seq reads are provided as uncompressed FASTQ files or use the built-in converters, while the reference genome and annotation must be in FASTA and GTF formats respectively. For high-throughput processing, consider organizing paired-end reads into a dataset collection to streamline the STAR alignment and Arriba fusion detection steps. Detailed parameter settings and reference versioning should be documented in your README.md to ensure reproducibility across different Galaxy instances. You can quickly generate a configuration template for local testing using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Arriba Get Filters | toolshed.g2.bx.psu.edu/repos/iuc/arriba_get_filters/arriba_get_filters/2.4.0+galaxy1 |  |
| 5 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed | Uncompressed RNA-Seq forward reads |
| 6 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed | Uncompressed RNA-Seq reverse reads |
| 7 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.10b+galaxy4 |  |
| 8 | Arriba | toolshed.g2.bx.psu.edu/repos/iuc/arriba/arriba/2.4.0+galaxy1 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 10 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.1 |  |
| 11 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 12 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Arriba-Get-Filters_protein_domains | protein_domains |
| 4 | Arriba-Get-Filters_cytobands | cytobands |
| 4 | Arriba-Get-Filters_blacklist | blacklist |
| 4 | Arriba-Get-Filters_known_fusions | known_fusions |
| 5 | Uncompressed-RNA-Seq-forward-reads | output1 |
| 6 | Uncompressed-RNA-Seq-reverse-reads | output1 |
| 7 | RNA_STAR_mapped_reads | mapped_reads |
| 8 | Arriba-Fusions-tsv | fusions_tsv |
| 9 | Reformated_Fusion_data | outfile |
| 10 | Table_generation_from_Fusion_data | output |
| 11 | Converting_Tabular_to_Fasta | output |
| 12 | Arriba-Fusion-Database | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
