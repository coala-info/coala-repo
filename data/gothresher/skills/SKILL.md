---
name: gothresher
description: GOThresher identifies and removes annotation biases from Gene Association Files to create balanced protein function datasets. Use when user asks to filter GAF files by evidence codes, remove redundant Gene Ontology terms based on information content, or generate ontology graphs and ancestor maps.
homepage: https://github.com/FriedbergLab/GOThresher
metadata:
  docker_image: "quay.io/biocontainers/gothresher:1.0.29--pyh7cba7a3_0"
---

# gothresher

## Overview
GOThresher is a specialized bioinformatics tool designed to create more balanced protein function datasets. It identifies and removes annotation biases from Gene Association Files (GAF) by evaluating Gene Ontology (GO) terms against criteria such as information content (IC), evidence codes, and the frequency of protein annotations from specific sources. This is particularly useful for researchers who need to mitigate the "rich-get-richer" effect in protein databases where well-studied proteins or high-throughput automated annotations dominate the functional landscape.

## Installation and Setup
The most reliable way to use GOThresher is via a dedicated Conda environment to manage its dependencies (networkx, Biopython, etc.).

```bash
conda create --name gth
conda activate gth
conda install -c bioconda gothresher
```

## Core Workflow

### 1. Preparation (gothresher_prep)
Before filtering GAF files, you must generate the necessary ontology graphs and ancestor maps. This step only needs to be performed once for a specific version of the Gene Ontology.

**Required Files:**
- An ontology file (e.g., `go.obo` or `go-basic.obo`).
- A configuration file (`gothresher.ini`) defining the root nodes for BPO, CCO, and MFO.

**Command:**
```bash
gothresher_prep -c gothresher.ini -i go.obo
```
This generates seven files in the directory specified by `onto_dir` in your `.ini` file (default is `./onto/`), including `.graph` and `.map` files for all three GO aspects.

### 2. Filtering Annotations (gothresher)
Once the mapping files are ready, use the main `gothresher` command to process your datasets.

**Common CLI Pattern:**
```bash
gothresher --input data.gaf --output filtered_data.gaf --evidence EXP IDA IPI --aspect BP
```

**Key Parameters:**
- `--input`: One or more GAF files to process.
- `--evidence` / `--evidence_inverse`: Include or exclude specific GO evidence codes (e.g., excluding IEA for electronic annotations).
- `--aspect`: Filter by specific ontologies: `BP` (Biological Process), `MF` (Molecular Function), or `CC` (Cellular Component).
- `--cutoff_prot`: Set a threshold for the number of proteins annotated from a given source.
- `--info_threshold_Wyatt_Clark_percentile`: Filter terms based on their information content percentile.

## Expert Tips and Best Practices
- **Ontology Updates**: Always re-run `gothresher_prep` if you download a newer version of the `go.obo` file, as the underlying graph structure and term relationships will have changed.
- **Config Management**: Ensure the `gothresher.ini` file correctly points to the desired `onto_dir`. If you move your project directory, update the path or the tool may fail to find the generated mapping files.
- **Information Content (IC)**: Use the Wyatt Clark or Phillip Lord IC thresholds to remove very general GO terms that provide little functional specificity. Percentile-based thresholds (e.g., `--info_threshold_Wyatt_Clark_percentile 20`) are often more intuitive than absolute IC values.
- **Source Filtering**: Use `--assigned_by` or `--assigned_by_inverse` to handle biases introduced by specific database providers or annotation pipelines.

## Reference documentation
- [github_com_FriedbergLab_GOThresher.md](./references/github_com_FriedbergLab_GOThresher.md)
- [anaconda_org_channels_bioconda_packages_gothresher_overview.md](./references/anaconda_org_channels_bioconda_packages_gothresher_overview.md)