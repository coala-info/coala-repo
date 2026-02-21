---
name: pycov3
description: pycov3 is a specialized bioinformatics tool designed to process sequence alignment data and binned contigs into a format compatible with the DEMIC R package.
homepage: https://github.com/Ulthran/pycov3
---

# pycov3

## Overview

pycov3 is a specialized bioinformatics tool designed to process sequence alignment data and binned contigs into a format compatible with the DEMIC R package. By analyzing SAM files (coverage information) and FASTA files (genomic sequences), it generates .cov3 files which are used to estimate the Peak-to-Trough Ratio (PTR)—a proxy for bacterial growth rates in complex microbial communities. It supports both a command-line interface for batch processing and a Python API for integration into custom scripts.

## Installation and Setup

The tool can be installed via multiple package managers:

- **Pip**: `pip install pycov3`
- **Conda**: `conda install -c bioconda pycov3`
- **Docker**: `docker pull chopmicrobiome/pycov3:latest`

## Command Line Usage

The primary interface is the `pycov3` command. Use `pycov3 -h` to view all available options.

### Strict File Naming Conventions
pycov3 relies on specific naming patterns to correctly pair SAM files with their corresponding FASTA files:
- **FASTA files**: Must be in one directory with the format `{sample}.{bin_name}.fasta` (or `.fa`, `.fna`).
- **SAM files**: Must be in one directory with the format `{sample}_{bin_name}.sam`.
- **Output**: Generated .cov3 files will follow the format `{sample}.{bin_name}.cov3`.

### Resource Optimization
- **Threads**: Use the `--thread_num` flag. For maximum efficiency, set this to the number of input FASTA files. There is no performance benefit to exceeding the number of FASTAs.
- **Memory**: Ensure the environment has at least **twice the size of the largest contig** available in RAM per thread.

## Python API Integration

For more granular control or integration into Python pipelines, use the internal classes:

```python
from pathlib import Path
from pycov3.Directory import Cov3Dir, FastaDir, SamDir

# Initialize directories
sam_d = SamDir(Path("/path/to/sams/"), False)
fasta_d = FastaDir(Path("/path/to/fastas/"), False)

# Configure parameters
window_params = {
    "edge_length": sam_d.calculate_edge_length(),
}
coverage_params = {
    "mapq_cutoff": 10, # Example cutoff
}

# Generate COV3 files
cov3_d = Cov3Dir(
    Path("/path/to/output/"), 
    False, 
    fasta_d.get_filenames(), 
    window_params, 
    coverage_params
)
cov3_d.generate(sam_d, fasta_d)
```

## Expert Tips and Best Practices

- **Edge Length**: Always use `sam_d.calculate_edge_length()` when using the API to ensure window parameters are correctly calibrated to your alignment data.
- **Filtering**: Use `mapq_cutoff` and `mapl_cutoff` to filter out low-quality mappings before coverage calculation to improve the accuracy of PTR estimates.
- **Large Contigs**: If the tool skips large contigs without warning, check the memory allocation; the generator-based architecture still requires significant memory for the `Contig` objects and coverage dictionaries of very long sequences.
- **Parallelization**: Since pycov3 parallelizes by FASTA file, if you have one very large bin and many small ones, the runtime will be bottlenecked by the single large file regardless of thread count.

## Reference documentation
- [pycov3 GitHub Repository](./references/github_com_Ulthran_pycov3.md)
- [pycov3 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pycov3_overview.md)