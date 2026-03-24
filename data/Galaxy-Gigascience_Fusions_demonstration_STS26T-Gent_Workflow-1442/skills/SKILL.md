---
name: gigascience_fusions_demonstration_sts26t-gent_workflow
description: "This workflow processes paired-end RNA-Seq reads, a human reference genome, and GTF annotations using STAR and Arriba to identify gene fusions and generate a protein fusion database. Use this skill when you need to detect chimeric transcripts and translate them into potential neoantigen sequences for cancer immunotherapy research."
homepage: https://workflowhub.eu/workflows/1442
---

# Gigascience_Fusions_demonstration_STS26T-Gent_Workflow

## Overview

This Galaxy workflow automates the detection of gene fusions from RNA-Seq data to generate a specialized protein fusion database. It is designed for neoantigen discovery and genomic research, specifically utilizing the [Arriba](https://github.com/suhrig/arriba) suite to identify chimeric transcripts from paired-end sequencing reads.

The pipeline begins by processing raw RNA-Seq reads and a human reference genome. It uses [RNA STAR](https://github.com/alexdobin/STAR) for high-performance alignment, followed by Arriba to detect and filter fusion events. The workflow incorporates automated retrieval of essential filtering resources, such as cytobands, blacklists, and known fusion datasets, to ensure high-confidence results.

In the final stages, the workflow performs text reformatting and tabular querying to extract relevant fusion sequences. These results are converted into FASTA format and refined using regex tools to produce a final protein fusion database. This structured output is suitable for downstream proteogenomic analysis and neoantigen prediction.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | RNA-Seq_Reads_1 | data_input | Forward strand |
| 1 | RNA-Seq_Reads_2 | data_input | Reverse strand |
| 2 | human_reference_genome_annotation.gtf | data_input | human GTF |
| 3 | human_reference_genome.fasta | data_input | Reference HUMAN FASTA |


Ensure your input RNA-Seq reads are in FASTQ format and the reference files are provided as GTF and FASTA for compatibility with the STAR and Arriba tools. While individual datasets are suitable for single-sample demonstrations, organizing paired-end reads into a dataset collection is recommended for scaling this fusion detection pipeline. Consult the accompanying README.md for specific versioning requirements and detailed parameter settings for the workflow steps. You can automate the configuration of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

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
