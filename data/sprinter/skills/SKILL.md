---
name: sprinter
description: SPRINTER (Single-cell Proliferation Rate Inference in Non-homogeneous Tumours through Evolutionary Routes) is a specialized bioinformatics tool for inferring the growth dynamics of tumor clones.
homepage: https://github.com/zaccaria-lab/SPRINTER
---

# sprinter

## Overview
SPRINTER (Single-cell Proliferation Rate Inference in Non-homogeneous Tumours through Evolutionary Routes) is a specialized bioinformatics tool for inferring the growth dynamics of tumor clones. By analyzing single-cell DNA sequencing data, it identifies cells actively replicating their DNA and assigns them to specific evolutionary lineages. This allows for the estimation of proliferation rates at a clonal level, providing insights into how different parts of a tumor are growing relative to one another.

## Installation and Environment
The recommended way to install SPRINTER is via Bioconda. Using `mamba` is preferred for faster dependency resolution.

```bash
# Create and activate a dedicated environment
conda create -n sprinter -c bioconda sprinter
conda activate sprinter

# Verify installation
sprinter --help
```

## Input Requirements
SPRINTER requires a specific TSV dataframe (can be `.gz` compressed) containing single-cell read counts per 50kb genomic regions.

### Required Columns
The input file must contain the following columns:
- `CHR`: Chromosome name (autosomes only).
- `START`: Start position of the genomic bin.
- `END`: End position of the genomic bin.
- `CELL`: Unique identifier for the cell.
- `NORM_COUNT`: Sequencing reads from a control/normal bin.
- `COUNT`: Sequencing reads from the specific cell in that bin.
- `RAW_RDR`: Raw read-depth ratio (can be placeholder values).

### Reference Genome
Always provide the reference genome in FASTA format using the `-r` flag. While SPRINTER defaults to pre-calculated hg19 GC-content if omitted, providing the specific FASTA used for alignment ensures accurate GC-bias correction.

## Common CLI Patterns

### Basic Execution
```bash
sprinter -i input_counts.tsv.gz -r reference_genome.fa -o output_directory
```

### High-Performance Execution
SPRINTER is highly parallelized. For large datasets (>1000 cells), ensure you allocate sufficient resources.
- **RAM**: Minimum 12GB for small demos; 50GB+ for large datasets.
- **CPU**: 12+ cores recommended for efficient processing.

## Expert Tips and Recommendations

### Quality Control and Tuning
- **Bin Sizes**: If CNA (Copy Number Alteration) or RT (Replication Timing) events are not being captured with enough resolution, consider varying the bin sizes in your preprocessing step.
- **GC-Bias Correction**: If your sequencing data is particularly noisy, pay close attention to the GC-content correction parameters to avoid false-positive replication signals.
- **Ploidy Control**: For highly aneuploid tumors, manually specify or control the maximum cancer cell ploidy to be inferred to prevent the algorithm from converging on incorrect copy number states.
- **Clone Selection**: If the inferred clones do not match known evolutionary history from other assays, tune the clone selection parameters to be more or less stringent.

### Output Interpretation
- `sprinter.output.tsv.gz`: The primary file for downstream analysis, containing the inferred clone and cell cycle phase (G1, S, or G2) for every cell.
- `rtinferred_clones.tsv.gz`: Useful for visualizing how replication timing varies across different tumor lineages.

## Reference documentation
- [SPRINTER Overview](./references/anaconda_org_channels_bioconda_packages_sprinter_overview.md)
- [SPRINTER GitHub Documentation](./references/github_com_zaccaria-lab_SPRINTER.md)