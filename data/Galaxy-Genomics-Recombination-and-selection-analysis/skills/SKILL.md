---
name: covid-19-genomics-6-recombination-and-selection-analysis
description: This workflow processes COVID-19 nucleotide sequences to perform evolutionary analysis using MAFFT for alignment, FastTree for phylogenetic reconstruction, and HyPhy tools for recombination and selection detection. Use this skill when you need to identify genomic recombination breakpoints and determine if specific lineages or sites in a viral population are undergoing adaptive evolution.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-genomics-6-recombination-and-selection-analysis

## Overview

This Galaxy workflow is designed for the evolutionary analysis of SARS-CoV-2, specifically focusing on identifying recombination and selective pressures within the Spike (S) protein. Starting with nucleotide sequences (`S_nt.fna`), the pipeline automates the complex process of preparing codon-aware alignments and executing statistical tests to track viral adaptation.

The workflow first translates nucleotide sequences into proteins using [EMBOSS transeq](https://www.ebi.ac.uk/Tools/st/emboss_transeq/) and performs multiple sequence alignment via [MAFFT](https://mafft.cbrc.jp/alignment/software/). These protein alignments are then mapped back to their original nucleotide sequences using [tranalign](https://www.bioinformatics.nl/cgi-bin/emboss/tranalign) to maintain the reading frame. A phylogenetic tree is subsequently generated using [FastTree](http://www.microbesonline.org/fasttree/) to provide the necessary evolutionary framework for downstream analysis.

The core of the analysis utilizes the [HyPhy](http://www.hyphy.org/) software suite to detect significant evolutionary events. The [GARD](http://www.hyphy.org/methods/selection-methods/#gard) tool is used to screen for recombination breakpoints that could otherwise bias selection analyses. Finally, the [aBSREL](http://www.hyphy.org/methods/selection-methods/#absrel) method is applied to identify specific branches in the phylogeny that have experienced positive diversifying selection, offering insights into the virus's functional evolution.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | S_nt.fna | data_input |  |


The primary input required is a nucleotide FASTA file (`.fna`) containing coding sequences, such as the SARS-CoV-2 Spike gene, for evolutionary analysis. Ensure your input is a single dataset or a properly structured collection to maintain consistency across the alignment and phylogenetic tools. For comprehensive guidance on sequence filtering and specific tool parameters, consult the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | transeq | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: transeq101/5.0.0 |  |
| 2 | MAFFT | toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.221.3 |  |
| 3 | tranalign | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: tranalign100/5.0.0 |  |
| 4 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 5 | HyPhy-GARD | toolshed.g2.bx.psu.edu/repos/iuc/hyphy_gard/hyphy_gard/2.5.4+galaxy0 |  |
| 6 | HyPhy-aBSREL | toolshed.g2.bx.psu.edu/repos/iuc/hyphy_absrel/hyphy_absrel/2.5.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | translated | translated |
| 5 | gard_output | gard_output |
| 5 | gard_log | gard_log |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-6-RecombinationSelection.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-6-RecombinationSelection.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-6-RecombinationSelection.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-6-RecombinationSelection.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-6-RecombinationSelection.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-6-RecombinationSelection.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)