---
name: deepsignal-plant
description: The deepsignal-plant tool is a deep-learning framework designed to identify DNA methylation patterns in plant genomes using Oxford Nanopore Technologies (ONT) reads.
homepage: https://github.com/PengNi/deepsignal-plant
---

# deepsignal-plant

## Overview
The deepsignal-plant tool is a deep-learning framework designed to identify DNA methylation patterns in plant genomes using Oxford Nanopore Technologies (ONT) reads. It utilizes a Bidirectional Long Short-Term Memory (BiLSTM) network to process signal-level features. This skill guides the user through the multi-step pipeline of basecalling, signal alignment (re-squiggling), modification calling, and frequency calculation.

## Workflow and CLI Patterns

### 1. Pre-processing Requirements
Before using deepsignal-plant, raw data must be processed through specific external tools:
*   **Basecalling**: Use Guppy (v3.6.1+) to generate fastq files and sequencing summaries.
*   **Format Conversion**: If using multi-read FAST5 files, convert them to single-read format using `multi_to_single_fast5` from the `ont_fast5_api` package.
*   **Re-squiggling**: Use `tombo resquiggle` to align raw signals to a reference genome. This is a mandatory prerequisite for the `call_mods` step.

### 2. Calling Methylation Modifications
Use the `call_mods` command to predict methylation states. This step is computationally intensive and benefits significantly from GPU acceleration.

```bash
CUDA_VISIBLE_DEVICES=0 deepsignal_plant call_mods \
    --input_path /path/to/resquiggled_fast5s/ \
    --model_path /path/to/pretrained_model.ckpt \
    --result_file output.call_mods.tsv \
    --corrected_group RawGenomeCorrected_000 \
    --motifs C \
    --nproc 30 \
    --nproc_gpu 6
```

**Key Arguments:**
*   `--motifs`: Set to `C` to call 5mC in all contexts (CG, CHG, CHH) simultaneously.
*   `--corrected_group`: Must match the group name used during the `tombo resquiggle` step.
*   `--nproc_gpu`: Number of processes used per GPU; adjust based on VRAM availability.

### 3. Calculating Methylation Frequency
After calling modifications, aggregate the results to determine the methylation frequency at specific genomic sites.

```bash
deepsignal_plant call_freq \
    --input_path output.call_mods.tsv \
    --result_file output.frequency.tsv
```

### 4. Post-processing: Motif Splitting
Plant DNA methylation is often analyzed separately by context. Use the provided helper script to split the master frequency file.

```bash
python /path/to/deepsignal_plant/scripts/split_freq_file_by_5mC_motif.py \
    --freqfile output.frequency.tsv
```

## Expert Tips and Troubleshooting

### Handling VBZ Compression Issues
If `tombo` or `deepsignal-plant` fails to read Fast5 files, it is often due to missing VBZ compression plugins. 
1.  Download the `ont-vbz-hdf-plugin`.
2.  Set the environment variable: `export HDF5_PLUGIN_PATH=/path/to/plugin/usr/local/hdf5/lib/plugin`.

### Resource Optimization
*   **Memory Management**: For large datasets, use the `--batch_size` parameter (default is often 1024) to prevent GPU out-of-memory (OOM) errors.
*   **Parallelization**: Balance `--nproc` (CPU processes for data loading) and `--nproc_gpu` (GPU processes for inference). A common ratio is 5:1.

### Model Selection
Ensure the model matches the pore type and library prep. For R9.4.1 reads in plants, use the `CNN.arabnrice2` model which was trained on *A. thaliana* and *O. sativa* data.

## Reference documentation
- [DeepSignal-plant GitHub Repository](./references/github_com_PengNi_deepsignal-plant.md)
- [Bioconda deepsignal-plant Overview](./references/anaconda_org_channels_bioconda_packages_deepsignal-plant_overview.md)