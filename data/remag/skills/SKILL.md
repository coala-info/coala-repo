---
name: remag
description: REMAG (REcovery of eukaryotic genomes) is a specialized metagenomic binning pipeline designed to extract high-quality eukaryotic genomes from mixed prokaryotic-eukaryotic samples.
homepage: https://github.com/danielzmbp/remag
---

# remag

## Overview

REMAG (REcovery of eukaryotic genomes) is a specialized metagenomic binning pipeline designed to extract high-quality eukaryotic genomes from mixed prokaryotic-eukaryotic samples. It distinguishes itself from general-purpose binners by utilizing a Siamese neural network with Barlow Twins self-supervised loss to generate contig embeddings. It also integrates the HyenaDNA LLM-based classifier to automatically filter out bacterial sequences, ensuring the resulting bins are focused on eukaryotic organisms. The tool is particularly effective for environmental or host-associated metagenomes where eukaryotic signals are often obscured by dominant prokaryotic populations.

## Installation and Environment Setup

For optimal performance, especially during the HyenaDNA classification and neural network training phases, GPU acceleration is highly recommended.

### Conda (Recommended)
```bash
# Create environment and install remag
conda create -n remag -c bioconda -c conda-forge remag
conda activate remag

# Enable GPU support (Essential for faster training)
conda install pytorch pytorch-cuda=12.1 -c pytorch -c nvidia
```

### Docker
```bash
docker run --rm -v $(pwd):/data danielzmbp/remag:latest \
    /data/contigs.fasta -c /data/alignments.bam -o /data/output
```

## Command Line Usage

### Basic Execution
The simplest command requires a contig FASTA file and at least one BAM alignment file.
```bash
remag contigs.fasta -c alignments.bam
```

### Multi-Sample Binning
REMAG can leverage coverage profiles across multiple samples to improve binning resolution. Use glob patterns for multiple BAM files.
```bash
remag contigs.fasta -c "alignments/*.bam" -o multi_sample_output
```

### Common Options
- `-o, --outdir`: Specify the output directory (defaults to `remag_output` in the input directory).
- `-k, --keep-intermediate`: Retain intermediate files (embeddings, fragments, etc.) for troubleshooting or manual inspection.
- `--skip-bacterial-filter`: Disable the HyenaDNA eukaryotic filtering if you want to bin the entire sample or if the sample is already pre-filtered.
- `--help`: View all advanced parameters including clustering resolution and training epochs.

## Expert Tips and Best Practices

- **GPU Acceleration**: Without a GPU, the HyenaDNA classifier and the Siamese network training will be significantly slower. Always verify PyTorch can see your CUDA device if performance is a bottleneck.
- **Contig Length**: Metagenomic binning generally performs better on longer contigs. Consider filtering your assembly (e.g., >2000bp) before running REMAG to improve embedding quality.
- **Adaptive Resolution**: REMAG automatically tests multiple Leiden clustering resolutions to maximize bin completeness while minimizing contamination. If you find the results too fragmented or too merged, check the logs to see the completeness/contamination trade-offs selected during the "Adaptive Resolution" stage.
- **Quality Assessment**: REMAG uses `miniprot` against a database of eukaryotic core genes. If your target organism is highly divergent, the quality scores might be underestimated.
- **Intermediate Files**: Use the `-k` flag if you plan to perform downstream visualization (like UMAP) of the learned embeddings, as these files are deleted by default to save space.

## Reference documentation

- [REMAG GitHub Repository](./references/github_com_danielzmbp_remag.md)
- [REMAG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_remag_overview.md)