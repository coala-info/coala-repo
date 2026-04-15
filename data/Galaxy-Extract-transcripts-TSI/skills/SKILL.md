---
name: extract-transcripts-tsi
description: This workflow processes merged transcriptome FASTA files using TransDecoder to identify coding sequences and longest open reading frames, followed by a BUSCO analysis to evaluate assembly completeness. Use this skill when you need to extract high-quality protein-coding transcripts from a de novo transcriptome assembly and verify the biological quality of the resulting proteome.
homepage: https://www.biocommons.org.au/
metadata:
  docker_image: "N/A"
---

# extract-transcripts-tsi

## Overview

This workflow automates the identification and extraction of coding sequences from merged transcriptome assemblies. It begins by processing a `merged_transcriptomes.fasta` file through a [text transformation tool](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.3+galaxy1) to ensure the sequence headers are properly formatted for downstream analysis.

The core of the pipeline utilizes [TransDecoder](https://toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/5.5.0+galaxy2) to identify candidate coding regions. The workflow executes both the `LongOrfs` and `Predict` stages in a single run, specifically configured with a minimum protein length of 20 amino acids (`-m 20`). This process generates a comprehensive set of outputs, including predicted CDS, peptide sequences (PEP), and structural annotations in GFF3 and BED formats.

To assess the quality and completeness of the extracted transcripts, the workflow concludes by running [Busco](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.5.0+galaxy0) on the TransDecoder results. This provides users with both a detailed summary table and a quantitative assessment of the transcriptome's protein-coding content based on evolutionarily-informed expectations.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | merged_transcriptomes.fasta | data_input |  |


Ensure the primary input `merged_transcriptomes.fasta` is in standard FASTA format and contains valid nucleotide sequences for TransDecoder to process correctly. While the workflow is configured for individual datasets, you may utilize dataset collections to run the analysis across multiple transcriptomes in parallel. For comprehensive details on specific parameter configurations like the minimum protein length, refer to the `README.md` file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.3+galaxy1 |  |
| 2 | TransDecoder | toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/5.5.0+galaxy2 |  |
| 3 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.5.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | out_lo_cds | out_lo_cds |
| 2 | out_gff3 | out_gff3 |
| 2 | out_pep | out_pep |
| 2 | out_bed | out_bed |
| 2 | out_lo_pep | out_lo_pep |
| 2 | out_cds | out_cds |
| 3 | busco_table | busco_table |
| 3 | busco_sum | busco_sum |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Extract-transcripts-TSI.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Extract-transcripts-TSI.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Extract-transcripts-TSI.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Extract-transcripts-TSI.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Extract-transcripts-TSI.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Extract-transcripts-TSI.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)