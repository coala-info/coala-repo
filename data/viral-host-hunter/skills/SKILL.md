---
name: viral-host-hunter
description: Viral-Host-Hunter predicts phage-host interactions from protein and DNA sequences. Use when user asks to predict phage-host interactions, specify the protein type, define the phage source environment, or set the taxonomic prediction level.
homepage: https://github.com/YuehuaOu/Viral-Host-Hunter
metadata:
  docker_image: "quay.io/biocontainers/viral-host-hunter:0.2.0--pyhdfd78af_1"
---

# viral-host-hunter

## Overview

Viral-Host-Hunter (VHH) is a protein-centered, alignment-free framework designed to decrypt "viral dark matter" by predicting phage-host interactions. Unlike traditional tools that require full viral genomes, VHH utilizes Protein Language Models (PLMs) and Vision Transformers (ViTs) to analyze specific functional proteins—tails and lysins. This allows for accurate host inference even from fragmented metagenomic data. The tool supports taxonomic predictions at the family, genus, and species levels with varying confidence thresholds.

## Installation and Setup

Viral-Host-Hunter is available via Bioconda. A GPU (e.g., NVIDIA RTX 3090) is strongly recommended for embedding and prediction; running the underlying ProtT5 model on a CPU is significantly slower and may cause numerical instability.

```bash
# Installation via Conda
conda install -c conda-forge -c bioconda viral-host-hunter

# Required: Download trained model weights from Zenodo
wget https://zenodo.org/records/17340381/files/models.zip
unzip models.zip
```

## Command Line Usage

The primary command is `vhh-predict`. You must provide both protein and DNA FASTA files, and specify the protein type being analyzed.

### Basic Prediction
```bash
vhh-predict \
  --protein path/to/proteins.fasta \
  --dna path/to/dna.fasta \
  --seq_type tail \
  --model_dir /path/to/unzipped_models \
  --phage_type gut
```

### Key Parameters

| Argument | Description | Options |
| :--- | :--- | :--- |
| `--seq_type` | The functional protein type in the input. | `tail`, `lysin` |
| `--phage_type` | The source environment of the phage. | `gut` (default), `environment` |
| `--level` | Taxonomic depth of the prediction. | `all` (default), `family`, `genus`, `species` |
| `--lineage` | Flag to include the full host lineage in output. | (Flag) |
| `--prott5_dir` | Path to local ProtT5 weights for offline use. | Path |

## Best Practices and Expert Tips

### Model Selection (`--phage_type`)
*   **gut**: Use this for human or animal gut microbiome samples. It is optimized for disease-associated datasets.
*   **environment**: Use this for environmental samples (soil, water, etc.) or general multi-taxonomic searches.

### Interpreting Confidence Thresholds
The output provides four prediction columns based on different confidence levels:
1.  **No_Threshold**: The raw prediction (highest risk of false positives).
2.  **Confidence_69%**: Balanced precision and recall.
3.  **Confidence_84%**: High stringency.
4.  **Confidence_95%**: Maximum stringency; use this when identifying specific therapeutic candidates or high-certainty hosts.

### Performance Optimization
*   **Embeddings**: Use `--embedding_dir` to save precomputed embeddings. If you need to re-run predictions on the same sequences with different parameters (e.g., changing `--level`), VHH will load the existing embeddings to save time.
*   **Offline Mode**: If working on a cluster without internet access, download the `ProtT5-XL-UniRef50` weights manually and point to them using `--prott5_dir`. Ensure the directory contains `pytorch_model.bin` (~11GB) and the associated JSON/model config files.

### Input Requirements
*   Ensure the IDs in your `--protein` FASTA file match the corresponding entries in your `--dna` FASTA file.
*   VHH is specifically trained on tails and lysins; providing other protein types to `--seq_type` will result in inaccurate predictions.

## Reference documentation
- [Viral-Host-Hunter GitHub Repository](./references/github_com_YuehuaOu_Viral-Host-Hunter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_viral-host-hunter_overview.md)