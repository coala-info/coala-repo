---
name: fgenesh-annotation-tsi
description: This Galaxy workflow performs structural genome annotation by processing assembled and hard-masked FASTA sequences alongside known cDNA and protein data using FGENESH++ tools, JCVI GFF stats, and BUSCO. Use this skill when you need to generate high-quality gene models for a newly assembled genome using homology-based evidence and assess the completeness of the resulting proteome.
homepage: https://www.biocommons.org.au/
metadata:
  docker_image: "N/A"
---

# fgenesh-annotation-tsi

## Overview

This Galaxy workflow performs automated genome annotation using the Fgenesh++ suite. It is designed to process large genomic datasets by splitting the input sequences into single entries to optimize computation time before running the annotation engine. The pipeline integrates structural gene prediction with evidence-based mapping, requiring both an assembled genome and a hard-repeat-masked version as primary inputs.

The workflow specifically utilizes known mRNA sequences to guide the annotation process, necessitating the provision of `.cdna`, `.pro`, and `.dat` files. Users must also select appropriate species-specific databases for the Fgenesh-annotate tool and define the relevant lineage for BUSCO assessment. If known mRNA evidence is unavailable, the workflow can be modified by toggling the "Fgenesh annotate" tool options to bypass the requirement for these additional sequence files.

The final stages of the pipeline merge the split results into a comprehensive GFF3 annotation file. It generates several key outputs, including fasta files for predicted mRNAs, cDNAs, and proteins, as well as detailed genome annotation statistics. To evaluate the completeness of the predicted gene set, the workflow concludes with a BUSCO report based on the generated protein sequences.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | assembled_genome.fasta | data_input |  |
| 1 | hard_masked_genome.fasta | data_input |  |
| 2 | Select an approximately closely-related species | parameter_input |  |
| 3 | Select mammal or non-mammal | parameter_input |  |
| 4 | Select lineage | parameter_input |  |


Ensure you provide both unmasked and hard-masked genome sequences in FASTA format, alongside the specific `.cdna`, `.pro`, and `.dat` files required for mapping known mRNA sequences. When configuring the workflow, carefully select the appropriate species-specific databases and BUSCO lineages to ensure accurate gene prediction and quality assessment. If your project lacks known mRNA inputs, modify the Fgenesh-annotate tool settings to "no" within a saved copy of the workflow to bypass those specific file requirements. For automated testing or batch execution, consider using `planemo workflow_job_init` to generate a `job.yml` template. Refer to the `README.md` for comprehensive details on parameter selection and database dependencies.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | FGENESH split | fgenesh_split |  |
| 6 | FGENESH split | fgenesh_split |  |
| 7 | FGENESH annotate | fgenesh_annotate |  |
| 8 | FGENESH merge | fgenesh_merge |  |
| 9 | FGENESH merge | fgenesh_merge |  |
| 10 | FGENESH get mRNA or GC | fgenesh_get_mrnas_gc |  |
| 11 | FGENESH get protein | fgenesh_get_proteins |  |
| 12 | FGENESH get mRNA or GC | fgenesh_get_mrnas_gc |  |
| 13 | Genome annotation statistics | toolshed.g2.bx.psu.edu/repos/iuc/jcvi_gff_stats/jcvi_gff_stats/0.8.4 |  |
| 14 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.5.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | output_gff | output_gff |
| 10 | output_mrna_file | output_mrna_file |
| 11 | output_prot_file | output_prot_file |
| 12 | output_cdna_file | output_mrna_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Fgenesh_annotation_-TSI.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Fgenesh_annotation_-TSI.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Fgenesh_annotation_-TSI.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Fgenesh_annotation_-TSI.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Fgenesh_annotation_-TSI.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Fgenesh_annotation_-TSI.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)