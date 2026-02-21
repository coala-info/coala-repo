---
name: variabel
description: Variabel is a specialized variant caller optimized for the high error rates of Oxford Nanopore Technology (ONT) data.
homepage: https://gitlab.com/treangenlab/variabel
---

# variabel

## Overview
Variabel is a specialized variant caller optimized for the high error rates of Oxford Nanopore Technology (ONT) data. It is designed specifically for intrahost variant detection, outperforming general-purpose callers in identifying low-frequency mutations within a population. The tool operates by leveraging the LoFreq EM algorithm, which requires a specific preprocessing step where quality scores are stripped from the input data.

## Installation
Install Variabel using conda from the Bioconda channel:
```bash
conda install -c bioconda variabel
```

## Core Workflow and Best Practices

### Preprocessing: FASTQ to FASTA Conversion
A critical requirement for Variabel is stripping quality scores from ONT data. This forces the underlying LoFreq engine to use its Expectation-Maximization (EM) algorithm rather than relying on potentially unreliable ONT quality scores.

**Recommended conversion methods:**
- Using `awk`:
  ```bash
  awk 'NR % 4 == 1 || NR % 4 == 2' input.fastq > input.fasta
  ```
- Using `seqtk`:
  ```bash
  seqtk seq -a input.fastq > input.fasta
  ```

### Execution Patterns
The main entry point for the tool is `variabel.py`. The package also includes several utility scripts for downstream analysis:

- **Main Pipeline**: Run `variabel.py` on your prepared FASTA files.
- **Comparison**: Use `vcf_compare.py` to evaluate differences between VCF outputs or against a ground truth.
- **Visualization**: 
    - `scatter_plot.py`: Generate basic variant distribution plots.
    - `time_scatter_plot.py`: Useful for longitudinal studies or time-series intrahost data.

### Expert Tips
- **VCF Compatibility**: If you encounter "Sample could not be read as a VCF file" errors when using outputs from other tools (like Clair3 or Medaka) with Variabel's comparison scripts, ensure the VCF headers are standard and the sample names match the expected input labels.
- **Python Environment**: Variabel is designed for Python 3. Ensure your environment uses `python3`. If running scripts directly from the source, use `#!/usr/bin/env python3` to ensure the environment-specific interpreter is used rather than the system default.
- **Input Lists**: The tool supports `.txt` files containing lists of inputs for batch processing.

## Reference documentation
- [anaconda_org_channels_bioconda_packages_variabel_overview.md](./references/anaconda_org_channels_bioconda_packages_variabel_overview.md)
- [gitlab_com_treangenlab_variabel.md](./references/gitlab_com_treangenlab_variabel.md)
- [gitlab_com_treangenlab_variabel.atom.md](./references/gitlab_com_treangenlab_variabel.atom.md)