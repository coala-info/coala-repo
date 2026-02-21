---
name: helixer-docker
description: Helixer-docker provides a pre-configured environment for running the Helixer gene prediction pipeline.
homepage: https://github.com/gglyptodon/helixer-docker
---

# helixer-docker

## Overview
Helixer-docker provides a pre-configured environment for running the Helixer gene prediction pipeline. It encapsulates complex dependencies like NVIDIA CUDA and cuDNN, allowing for high-throughput gene annotation across various lineages (such as land plants) using deep learning models. This skill facilitates the containerized workflow, including data mounting for persistence, model acquisition, and the execution of the primary prediction scripts.

## Environment Setup
To utilize GPU acceleration, the host system must have an NVIDIA GPU (CUDA capability >= 6.1) and the NVIDIA Container Toolkit installed.

- **Pull the image**: `docker pull gglyptodon/helixer-docker:latest`
- **CPU Fallback**: If no GPU is available, the tool will run on the CPU, but processing time will increase significantly. In this case, omit the `--gpus all` flag from Docker commands.

## Core Workflow

### 1. Data Persistence and Mounting
Docker containers are immutable. To save results, you must mount a host directory to the container.
- **Host Preparation**:
  ```bash
  mkdir -p data/out
  chmod o+w data/out  # Ensure the container user can write to this directory
  ```
- **Launch Container**:
  ```bash
  docker run --gpus all -it --rm \
    --mount type=bind,source="$(pwd)"/data,target=/home/helixer_user/shared \
    gglyptodon/helixer-docker:latest
  ```

### 2. Model Acquisition
Before running predictions for the first time inside the container, download the required neural network models:
```bash
Helixer/scripts/fetch_helixer_models.py
```
*Note: Models are stored in `~/.local/share/Helixer/models/`.*

### 3. Running Predictions
Use the `Helixer.py` script to annotate your FASTA files.
```bash
Helixer.py --fasta-path shared/your_genome.fa --lineage land_plant --gff-output-path shared/output.gff3
```

## CLI Reference and Best Practices

### Common Helixer.py Arguments
- `--fasta-path`: Path to the input genomic sequence (supports .gz).
- `--lineage`: The biological lineage of the sample (e.g., `land_plant`).
- `--gff-output-path`: Destination for the resulting annotation file.
- `--batch-size`: Adjust based on available VRAM (default is often 32).

### Expert Tips
- **Apptainer/Singularity**: If using Apptainer, use the `--nv` flag for GPU support: `apptainer run --nv docker://gglyptodon/helixer-docker:latest`.
- **Permission Issues**: If you encounter "Permission Denied" when writing to mounted volumes, ensure the host directory has world-write permissions (`chmod 777` or `chmod o+w`) or matches the UID of the container user.
- **Large Genomes**: For genomes larger than 10GB, monitor system RAM closely as the windowing process can be memory-intensive.

## Reference documentation
- [Helixer-Docker Main Documentation](./references/github_com_gglyptodon_helixer-docker.md)