---
name: hormon
description: HORmon is a bioinformatics pipeline that identifies alpha-satellite monomers and extracts higher-order repeat structures from human centromeric sequences. Use when user asks to infer draft monomers, refine monomer sequences, or map the organizational architecture of centromeres.
homepage: https://github.com/ablab/HORmon
metadata:
  docker_image: "quay.io/biocontainers/hormon:1.0.0--pyhdfd78af_0"
---

# hormon

## Overview

HORmon is a specialized bioinformatics pipeline for the structural analysis of human centromeres. It automates the identification of alpha-satellite monomers and the higher-order repeat (HOR) structures they form. The tool operates in two distinct phases: first, it infers draft monomers using a consensus template; second, it refines these monomers and maps the organizational architecture of the centromere. This is essential for understanding centromere evolution and ensuring the accuracy of satellite DNA annotations in complex genomic assemblies.

## Command Line Usage

The workflow consists of two primary executable modules: `monomer_inference` and `HORmon`.

### 1. Monomer Inference
This stage extracts draft monomers from a centromeric sequence based on a provided alpha-satellite template.

```bash
monomer_inference -seq <centromere_sequence.fa> -mon <alpha_sat_template.fa> -o <output_dir>
```

**Key Outputs:**
- `final/monomers.fa`: The extracted draft monomers.
- `final/final_decomposition.tsv`: Initial sequence annotation.

### 2. HORmon (Polishing and HOR Extraction)
This stage refines the monomers and identifies the Higher-Order Repeat structures.

```bash
HORmon --seq <centromere_sequence.fa> --mon <inference_output/final/monomers.fa> --cen-id <ID> --monomer-thr 2 --edge-thr 2 --min-traversals 2 -o <output_dir>
```

**Parameters:**
- `--cen-id`: A unique identifier for the centromere (e.g., chromosome number) used for output labeling.
- `--monomer-thr`: Minimum number of occurrences required for a monomer to be considered.
- `--edge-thr`: Minimum number of occurrences for monomer pairs.
- `--min-traversals`: Minimum number of occurrences for a sequence to be classified as an HOR.

**Key Outputs:**
- `mn.fa`: Final polished monomers.
- `HORs.tsv`: Detailed description of identified HORs.
- `HORdecomposition.tsv`: The final decomposition of the centromere into HOR units.

## Expert Tips and Best Practices

- **Independent Processing**: Always run HORmon on each centromere independently. Processing multiple centromeres simultaneously in a single run is not supported and may lead to inaccurate results.
- **Input Requirements**: Ensure the input sequence is a FASTA file containing centromeric or alpha-satellite-rich regions.
- **Monomer Thresholds**: If the centromere is highly divergent or contains rare variants, consider lowering the `--monomer-thr` and `--edge-thr` values to capture less frequent structures, though this may increase noise.
- **Dependencies**: HORmon relies on `stringdecomposer` and `clustalo` for its internal alignment and decomposition logic. Ensure these are available in the environment path.



## Subcommands

| Command | Description |
|---------|-------------|
| HORmon | updating monomers to make it consistent with CE postulate, and canonical HOR inferencing |
| monomer_inference | Monomer Inference Problem: complement monomers set |

## Reference documentation
- [HORmon README](./references/github_com_ablab_HORmon_blob_main_README.md)
- [HORmon Setup and Entry Points](./references/github_com_ablab_HORmon_blob_main_setup.py.md)