---
name: pacbio-hifi-genome-assembly-using-hifiasm-v21
description: This workflow performs de novo genome assembly on PacBio HiFi FASTQ reads using HiFi Adapter Filter for preprocessing, Hifiasm for assembly, and Bandage for visualization and statistics. Use this skill when you need to generate high-quality, contiguous genome assemblies from circular consensus sequencing data and evaluate the structural connectivity of the resulting assembly graphs.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# pacbio-hifi-genome-assembly-using-hifiasm-v21

## Overview

This workflow provides a comprehensive pipeline for the assembly, visualization, and quality assessment of PacBio High Fidelity (HiFi) reads. It is designed to process circular consensus sequence (CCS) data, ensuring high-quality genomic reconstructions by leveraging the [hifiasm](https://github.com/chhylp123/hifiasm) assembler.

The process begins with raw FASTQ input, which undergoes initial preprocessing using [HiFiAdapterFilt](https://github.com/fenderglass/HiFiAdapterFilt) to remove residual adapter sequences and contaminants. The cleaned reads are then assembled by hifiasm, which generates assembly graphs in GFA format. These graphs represent the primary assembly and alternative haplotypes, providing a phased view of the genome.

To evaluate the assembly, the workflow utilizes [Bandage](https://rrwick.github.io/Bandage/) to generate both visual images and numerical statistics of the assembly graphs. Finally, the GFA files are converted to FASTA format, and comprehensive assembly metrics are calculated to provide a final report on the genome's continuity and quality.

For detailed usage instructions and best practices, users should refer to the [Genome assembly with hifiasm on Galaxy Australia](https://australianbiocommons.github.io/how-to-guides/genome_assembly/hifi_assembly) guide. This workflow is licensed under GPL-3.0-or-later and is tagged for `hifiasm`, `HiFi`, and `genome_assembly`.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | FASTQ input | data_input | The FASTQ input to hifiasm can be sourced from the "BAM to FASTQ + QC" sub workflow. |


Ensure your input data consists of high-fidelity (HiFi) circular consensus sequences in FASTQ format to achieve optimal assembly results. While the workflow accepts individual datasets, utilizing dataset collections is recommended for efficiently managing multiple sequencing runs or large-scale projects. Refer to the README.md for comprehensive instructions on data preparation and specific parameter configurations tailored to your organism. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined job configuration and automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | HiFi Adapter Filter | toolshed.g2.bx.psu.edu/repos/galaxy-australia/hifiadapterfilt/hifiadapterfilt/2.0.0+galaxy0 |  |
| 2 | Hifiasm | toolshed.g2.bx.psu.edu/repos/bgruening/hifiasm/hifiasm/0.16.1+galaxy3 |  |
| 3 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 4 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy3 |  |
| 5 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 6 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy3 |  |
| 7 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 8 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 9 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 10 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy3 |  |
| 11 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy3 |  |
| 12 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | HiFi Adapter Filter on input dataset(s): clean reads | cleanfastq |
| 1 | HiFi Adapter Filter on input dataset(s): contaminant statistic | stats |
| 1 | HiFi Adapter Filter on input dataset(s): contaminant blastout | blastout |
| 1 | HiFi Adapter Filter on input dataset(s): blocklist | blocklist |
| 8 | primary bandage info | outfile |
| 9 | converted FASTA | out_fa |
| 11 | primary bandage image | outfile |
| 12 | metrics | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-PacBio_HiFi_genome_assembly_using_hifiasm_v2.1.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-PacBio_HiFi_genome_assembly_using_hifiasm_v2.1.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-PacBio_HiFi_genome_assembly_using_hifiasm_v2.1.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-PacBio_HiFi_genome_assembly_using_hifiasm_v2.1.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-PacBio_HiFi_genome_assembly_using_hifiasm_v2.1.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-PacBio_HiFi_genome_assembly_using_hifiasm_v2.1.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)