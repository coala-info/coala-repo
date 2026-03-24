---
name: amr-seqsero2sistr
description: "This workflow processes sequencing dataset collections for Salmonella serotyping and antimicrobial resistance analysis using SeqSero2, SISTR, Shovill, and hamronize. Use this skill when you need to determine Salmonella serovars and identify associated resistance genes or plasmid sequences for food safety or clinical pathogen surveillance."
homepage: https://workflowhub.eu/workflows/407
---

# AMR - SeqSero2/SISTR

## Overview

This Galaxy workflow is designed for the comprehensive genomic characterization of *Salmonella* isolates, focusing on serotyping and Antimicrobial Resistance (AMR) detection. It processes input dataset collections through a pipeline that integrates quality control, de novo assembly, and specialized typing tools to provide high-resolution taxonomic and functional insights.

The workflow begins with preprocessing using [BBduk](https://toolshed.g2.bx.psu.edu/repos/iuc/bbtools_bbduk/bbtools_bbduk/39.01+galaxy0) for read trimming and filtering, followed by assembly using [Shovill](https://toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy1). Serotype prediction is performed at multiple stages using [SeqSero2](https://toolshed.g2.bx.psu.edu/repos/iuc/seqsero2/seqsero2/1.2.1+galaxy0) and [SISTR](https://toolshed.g2.bx.psu.edu/repos/nml/sistr_cmd/sistr_cmd/1.1.1+galaxy1), ensuring consistent results from both raw reads and assembled contigs.

For resistance profiling and mobile genetic element analysis, the pipeline utilizes [SRST2](https://toolshed.g2.bx.psu.edu/repos/iuc/srst2/srst2/0.2.0+galaxy1) and [hamronize](https://toolshed.g2.bx.psu.edu/repos/iuc/hamronize_tool/hamronize_tool/1.0.3+galaxy1) to identify and summarize AMR gene presence. Additionally, [MOB-Recon](https://toolshed.g2.bx.psu.edu/repos/nml/mob_suite/mob_recon/3.0.3+galaxy0) is employed to reconstruct and type plasmids, allowing users to differentiate between chromosomal and plasmid-borne resistance markers.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |


For optimal performance, provide paired-end FASTQ files organized into a list of dataset pairs to ensure the workflow correctly unzips and processes individual samples through SeqSero2 and Shovill. Ensure your input collection is properly tagged and formatted as fastqsanger or fastqsanger.gz to avoid tool execution errors during the BBduk and KMA mapping stages. You can streamline local testing and execution by using `planemo workflow_job_init` to generate a `job.yml` file for your input parameters. Refer to the README.md for comprehensive details on parameter settings and specific database requirements for SISTR and MOB-Recon.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | SeqSero2 | toolshed.g2.bx.psu.edu/repos/iuc/seqsero2/seqsero2/1.2.1+galaxy0 |  |
| 2 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 3 | BBTools: BBduk | toolshed.g2.bx.psu.edu/repos/iuc/bbtools_bbduk/bbtools_bbduk/39.01+galaxy0 |  |
| 4 | Map with KMA | toolshed.g2.bx.psu.edu/repos/iuc/kma/kma_map/1.2.21+galaxy1 |  |
| 5 | SeqSero2 | toolshed.g2.bx.psu.edu/repos/iuc/seqsero2/seqsero2/1.2.1+galaxy0 |  |
| 6 | SRST2 | toolshed.g2.bx.psu.edu/repos/iuc/srst2/srst2/0.2.0+galaxy1 |  |
| 7 | BBTools: Tadpole | toolshed.g2.bx.psu.edu/repos/iuc/bbtools_tadpole/bbtools_tadpole/39.01+galaxy0 |  |
| 8 | hamronize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_tool/hamronize_tool/1.0.3+galaxy1 |  |
| 9 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy1 |  |
| 10 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy1 |  |
| 11 | hamronize: summarize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_summarize/hamronize_summarize/1.0.3+galaxy2 |  |
| 12 | SeqSero2 | toolshed.g2.bx.psu.edu/repos/iuc/seqsero2/seqsero2/1.2.1+galaxy0 |  |
| 13 | sistr_cmd | toolshed.g2.bx.psu.edu/repos/nml/sistr_cmd/sistr_cmd/1.1.1+galaxy1 |  |
| 14 | MOB-Recon | toolshed.g2.bx.psu.edu/repos/nml/mob_suite/mob_recon/3.0.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | results | results |
| 9 | contigs | contigs |
| 9 | contigs_graph | contigs_graph |
| 9 | shovill_std_log | shovill_std_log |
| 10 | contigs_graph | contigs_graph |
| 10 | contigs | contigs |
| 10 | shovill_std_log | shovill_std_log |
| 13 | output_prediction_tab | output_prediction_tab |
| 13 | alleles_output | alleles_output |
| 13 | cgmlst_profiles | cgmlst_profiles |
| 13 | novel_alleles | novel_alleles |
| 14 | chromosome | chromosome |
| 14 | mobtyper_aggregate_report | mobtyper_aggregate_report |
| 14 | plasmids | plasmids |
| 14 | contig_report | contig_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-CFIA.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-CFIA.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-CFIA.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-CFIA.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-CFIA.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-CFIA.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
