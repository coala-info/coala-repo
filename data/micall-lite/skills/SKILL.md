---
name: micall-lite
description: Micall-lite maps high-throughput sequencing data to reference genomes to generate alignments, counts, and consensus files for viral genotyping. Use when user asks to map sequencing reads to a reference, generate consensus sequences, or perform HIV-1 drug resistance prediction.
homepage: https://github.com/PoonLab/MiCall-Lite
metadata:
  docker_image: "quay.io/biocontainers/micall-lite:0.1rc--py27h14c3975_0"
---

# micall-lite

## Overview

The micall-lite skill provides a streamlined workflow for mapping high-throughput sequencing data to reference genomes. It is a portable, lightweight version of the MiCall pipeline designed for ease of installation and execution. The tool automates a multi-step process including preliminary mapping, iterative remapping, and the generation of alignment, count, and consensus files. It is specifically optimized for genotyping human RNA viruses and can be extended with specialized modules for clinical resistance scoring.

## Core CLI Usage

The primary interface for the pipeline is the `micall` script.

### Standard Processing
For paired-end Illumina data (default behavior assumes gzipped files):
```bash
micall sample_R1.fastq.gz sample_R2.fastq.gz
```

For single-read (unpaired) sequencing:
```bash
micall sample_R1.fastq.gz
```

### Handling Uncompressed Data
If your FASTQ files are already extracted, use the `-u` flag to prevent the tool from looking for gzip headers:
```bash
micall -u sample_R1.fastq sample_R2.fastq
```

## Quality Control and Filtering

### Tile-Cycle Censoring
To improve accuracy by filtering out specific tile-cycle combinations with high empirical error rates (derived from Illumina phiX control spikes), provide the InterOp binary file:
```bash
micall -i ErrorMetricsOut.bin sample_R1.fastq.gz sample_R2.fastq.gz
```

## HIV-1 Drug Resistance Prediction

If the `sierralocal` Python module is installed, you can perform drug resistance genotyping on the output of the micall-lite pipeline.

1. **Run the pipeline** to generate the consensus CSV:
   ```bash
   micall sample_R1.fastq.gz sample_R2.fastq.gz
   ```
2. **Score the results** using the utility script:
   ```bash
   python3 micall/utils/scoreHIVdb.py sample.conseq.csv sample.hivdb.tsv
   ```

## Expert Tips and Best Practices

- **Resource Management**: The pipeline uses `bowtie2` for mapping, which defaults to 4 threads. Ensure your environment has sufficient CPU allocation for these subprocesses.
- **Storage Efficiency**: Always prefer gzipped FASTQ files (`.gz`) as input. Micall-lite processes them natively, saving significant disk space compared to uncompressed files.
- **Project Customization**: Use `configure-projects.py` or the `project-editor.py` utility to modify reference sequences or target regions if working with non-standard viral variants.
- **Installation**: For the most stable environment, install via Bioconda: `conda install bioconda::micall-lite`.

## Reference documentation
- [MiCall-Lite GitHub Overview](./references/github_com_PoonLab_MiCall-Lite.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_micall-lite_overview.md)