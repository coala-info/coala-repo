---
name: covid-19-genomics-5-analysis-of-s-protein-polymorphism
description: This Galaxy workflow processes SARS-CoV-2 nucleotide sequences to analyze S-protein polymorphisms using EMBOSS transeq for translation, MAFFT for protein alignment, and EMBOSS tranalign for codon-aware nucleotide alignment. Use this skill when you need to identify amino acid variations in the SARS-CoV-2 spike protein and generate high-quality codon-based alignments to study viral evolution or mutation patterns.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-genomics-5-analysis-of-s-protein-polymorphism

## Overview

This workflow is designed to analyze polymorphisms in the SARS-CoV-2 Spike (S) protein by processing genomic sequences to identify variations at both the amino acid and nucleotide levels. It is a critical tool for monitoring viral evolution and understanding how mutations might affect protein function or host cell interaction.

The pipeline begins by translating nucleotide sequences into their corresponding peptide sequences using [transeq](https://www.ebi.ac.uk/Tools/st/emboss_transeq/). These protein sequences are then aligned using [MAFFT](https://mafft.cbrc.jp/alignment/software/), a high-performance multiple sequence alignment tool, to identify conserved regions and substitutions across different viral samples.

In the final stage, the workflow utilizes [tranalign](https://emboss.sourceforge.net/apps/cvs/emboss/apps/tranalign.html) to perform a codon-aware alignment. By mapping the protein alignment back onto the original nucleotide data, the tool ensures that the resulting DNA alignment maintains the correct reading frame. This allows researchers to accurately distinguish between synonymous and non-synonymous mutations within the S-gene.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


Ensure your input is a FASTA file containing nucleotide sequences of the S-protein to be analyzed. While the workflow is configured for a single dataset, you may utilize dataset collections to batch process multiple sequences efficiently. Refer to the `README.md` for comprehensive details on sequence preparation and specific parameter configurations. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | transeq | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: transeq101/5.0.0 |  |
| 2 | MAFFT | toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.221.3 |  |
| 3 | tranalign | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: tranalign100/5.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | outputAlignment | outputAlignment |
| 3 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-5-S-analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-5-S-analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-5-S-analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-5-S-analysis.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-5-S-analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-5-S-analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)