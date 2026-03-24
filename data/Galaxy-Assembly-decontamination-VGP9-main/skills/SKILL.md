---
name: assembly-decontamination-vgp9
description: "This VGP workflow processes scaffolded genome assemblies to remove foreign contaminants, adaptors, and mitochondrial sequences using NCBI FCS GX, FCS Adaptor, and BLAST+. Use this skill when you need to finalize a high-quality genome assembly by purging non-target biological sequences and identifying mitochondrial scaffolds to ensure data integrity for public submission."
homepage: https://workflowhub.eu/workflows/645
---

# Assembly decontamination VGP9

## Overview

The Assembly decontamination VGP9 workflow is a specialized pipeline designed for the final cleaning of genome assemblies following the scaffolding stage. As a curated component of the [VGP Suite](https://github.com/VGP/vgp-assembly), it focuses on identifying and removing foreign contaminants, adapter sequences, and mitochondrial DNA to ensure high-quality, publication-ready genomic data.

The workflow utilizes [NCBI FCS GX](https://github.com/ncbi/fcs) to detect cross-species contamination and [NCBI FCS Adaptor](https://github.com/ncbi/fcs) for identifying sequencing adapters. It further employs [NCBI BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi) and `dustmasker` to isolate mitochondrial sequences and low-complexity regions. Users provide the scaffolded assembly along with taxonomic metadata, such as the NCBI taxonomic identifier and species binomial name, to guide the identification process.

Key outputs include a final decontaminated assembly in FASTA format, detailed taxonomy and contaminant reports, and a list of identified mitochondrial scaffolds. For comprehensive details on input parameters and file preparation, please refer to the [README.md](README.md) in the Files section. This workflow is licensed under the BSD-3-Clause and carries the `VGP_curated` tag.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Scaffolded assembly (fasta) | data_input |  |
| 1 | Database for NCBI FCS GX | parameter_input |  |
| 2 | Taxonomic Identifier | parameter_input | NCBI taxon ID. E.g. 9606 for Homo Sapiens. |
| 3 | Species Binomial Name | parameter_input | NCBI Species Name. E.g. Homo Sapiens |
| 4 | Assembly Name | parameter_input | For Workflow report |
| 5 | Haplotype | parameter_input | For Workflow report |
| 6 | Maximum length of sequence to consider for mitochondrial scaffolds | parameter_input | If set to 0, use all sequences. Use this parameter if you have large contigs that cause Blast to fail. |


Ensure your scaffolded assembly is in FASTA format and have the specific NCBI taxonomic identifier and binomial name ready for the FCS GX and BLAST modules. You must provide the correct database path for NCBI FCS GX and can adjust the maximum sequence length parameter to prevent BLAST failures on exceptionally long mitochondrial scaffolds. For automated job configuration, you may use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and expected report formats. One should verify that all input metadata, such as haplotype and assembly name, matches the project's naming conventions for consistent reporting.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | NCBI FCS Adaptor | toolshed.g2.bx.psu.edu/repos/richard-burhans/ncbi_fcs_adaptor/ncbi_fcs_adaptor/0.5.0+galaxy0 |  |
| 8 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 9 | Modify action report | (subworkflow) |  |
| 10 | NCBI FCS GX | toolshed.g2.bx.psu.edu/repos/iuc/ncbi_fcs_gx/ncbi_fcs_gx/0.5.5+galaxy2 |  |
| 11 | NCBI BLAST+ dustmasker | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_dustmasker_wrapper/2.16.0+galaxy0 |  |
| 12 | Filter sequences by length | toolshed.g2.bx.psu.edu/repos/devteam/fasta_filter_by_length/fasta_filter_by_length/1.2 |  |
| 13 | NCBI FCS GX | toolshed.g2.bx.psu.edu/repos/iuc/ncbi_fcs_gx/ncbi_fcs_gx/0.5.5+galaxy2 |  |
| 14 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.5+galaxy3 |  |
| 15 | NCBI FCS GX | toolshed.g2.bx.psu.edu/repos/iuc/ncbi_fcs_gx/ncbi_fcs_gx/0.5.5+galaxy2 |  |
| 16 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.16.0+galaxy0 |  |
| 17 | Parse mitochondrial blast | toolshed.g2.bx.psu.edu/repos/iuc/parse_mito_blast/parse_mito_blast/1.0.2+galaxy0 |  |
| 18 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Adaptor Report | adaptor_report |
| 8 | Assembly Info | out1 |
| 13 | Taxonomy Report | taxonomy_report |
| 13 | Contaminants report | action_report |
| 15 | Contaminants sequences | contam_fasta |
| 17 | Mitochondrial Scaffolds | mito_scaff_names |
| 18 | Final Decontaminated Assembly | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Assembly-decontamination-VGP9.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Assembly-decontamination-VGP9.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Assembly-decontamination-VGP9.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Assembly-decontamination-VGP9.ga -o job.yml`
- Lint: `planemo workflow_lint Assembly-decontamination-VGP9.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Assembly-decontamination-VGP9.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
