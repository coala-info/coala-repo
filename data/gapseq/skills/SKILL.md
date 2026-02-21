---
name: gapseq
description: gapseq is a specialized tool for the informed prediction of bacterial and archaeal metabolic pathways and the reconstruction of genome-scale metabolic networks.
homepage: https://github.com/jotech/gapseq
---

# gapseq

## Overview

gapseq is a specialized tool for the informed prediction of bacterial and archaeal metabolic pathways and the reconstruction of genome-scale metabolic networks. It integrates genomic information with biochemical databases to automate the transition from protein or genome sequences to functional metabolic models. It is particularly effective for identifying missing reactions (gap-filling) and predicting membrane transport systems, which are often bottlenecks in automated model reconstruction.

## Core Workflows

### The "doall" Pipeline
The most common way to use gapseq is the `doall` command, which executes the entire pipeline: pathway prediction, transporter inference, draft model construction, and gap-filling.

```bash
# Basic execution with protein sequences
gapseq doall input_sequences.faa

# Execution with a specific growth medium for gap-filling
gapseq doall -m dat/media/MM_glu.csv input_sequences.faa
```

### Modular Execution
If you need more control over specific steps, gapseq allows you to run components individually:

1.  **Pathway Prediction**: Find metabolic pathways and reactions.
    `gapseq find input.faa`
2.  **Transporter Inference**: Identify transport proteins and reactions.
    `gapseq find-transport input.faa`
3.  **Draft Reconstruction**: Create a draft metabolic model (RDS format).
    `gapseq draft -p input-all-pathways.txt -t input-all-transporters.txt`
4.  **Gap-filling**: Fill gaps in the network to enable biomass production.
    `gapseq fill -m medium.csv -n draft_model.rds`

## Expert Tips and Best Practices

- **Input Formats**: While gapseq can handle genome FASTA files, using high-quality protein sequences (.faa) is generally preferred for more accurate functional annotation.
- **Media Selection**: The quality of the final model depends heavily on the media file used during the gap-filling step. Use a medium that closely matches the experimental growth conditions of the organism.
- **Path Management**: If installed via Bioconda, the `gapseq` binary is in your PATH. If installed from source, ensure you are in the gapseq directory or use `./gapseq`.
- **Verification**: Always run `gapseq test` after installation to ensure all dependencies (R, blast, etc.) and the "full model" are correctly configured.
- **Output Files**: gapseq primarily works with `.rds` files (R data objects). To use the model in other tools like COBRApy or OptFlux, ensure you export or convert the final model to SBML format.
- **Resource Allocation**: For large genomes or complex media, gap-filling can be computationally intensive. Ensure sufficient memory is available for the R environment.

## Reference documentation
- [gapseq GitHub Repository](./references/github_com_jotech_gapseq.md)
- [gapseq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gapseq_overview.md)