---
name: predicthaplo
description: PredictHaplo is a specialized bioinformatics tool designed to resolve the genetic diversity within a viral population.
homepage: https://github.com/cbg-ethz/PredictHaplo
---

# predicthaplo

## Overview
PredictHaplo is a specialized bioinformatics tool designed to resolve the genetic diversity within a viral population. It uses a propagating Dirichlet process mixture model to infer the number and sequences of individual haplotypes (strains) present in a sample. This skill provides the necessary command-line patterns to execute the reconstruction process, manage local vs. global analysis, and tune MCMC parameters for accurate strain discovery.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda install -c bioconda predicthaplo
```

## Core Usage Pattern
The basic execution requires an aligned SAM file and the corresponding reference FASTA.

```bash
predicthaplo --sam input.sam --reference ref.fasta --prefix output_name --do_local_Analysis 1
```

### Required Arguments
- `--sam FILE`: Aligned reads in SAM format.
- `--reference FILE`: Reference sequence in FASTA format.
- `--prefix STR`: Base name for all generated output files.
- `--do_local_Analysis 1`: Must be set to 1 for the initial run to perform window-based reconstruction.

## Advanced Configuration
PredictHaplo allows fine-tuning of the reconstruction window and the Bayesian inference model.

### Window and Mapping Filters
- `--reconstruction_start INT` / `--reconstruction_stop INT`: Define specific genomic coordinates for analysis.
- `--min_mapping_qual INT`: Filter out low-quality alignments (default is often 0, but 20-30 is recommended for high confidence).
- `--min_readlength INT`: Minimum length of reads to consider for haplotype linking.
- `--max_gap_fraction FLOAT`: Maximum allowed fraction of gaps relative to alignment length (e.g., 0.05).

### Model Parameters
- `--cluster_number INT`: The maximum number of clusters in the truncated Dirichlet process. Increase this if you suspect a very high number of distinct strains.
- `--nSample INT`: Number of MCMC iterations. Higher values improve convergence but increase runtime.
- `--include_deletions INT`: Set to 1 to treat deletions as informative characters rather than missing data.
- `--entropy_threshold FLOAT`: Threshold used to identify polymorphic sites.

## Output Files
PredictHaplo generates several files based on the provided prefix:
- `[prefix].fas`: The reconstructed haplotype sequences in FASTA format.
- `[prefix].txt`: Frequencies and metadata for the inferred haplotypes.
- Visualization files (if `--visualization_level 1` is set).

## Best Practices
- **Paired-End Data**: Ensure your SAM file contains properly flagged paired-end reads to maximize the "bridge" between local windows.
- **Reference Alignment**: The quality of the haplotype reconstruction is highly dependent on the initial alignment. Use a high-sensitivity aligner like BWA-MEM or Bowtie2 before running PredictHaplo.
- **Local vs. Global**: Always start with `--do_local_Analysis 1`. If you need to refine a specific region after a global run, you can adjust the start/stop coordinates.
- **Memory Management**: For very deep sequencing datasets, consider subsampling the SAM file if the tool encounters memory limits, as the complexity scales with the number of reads in the reconstruction window.

## Reference documentation
- [PredictHaplo GitHub Repository](./references/github_com_cbg-ethz_PredictHaplo.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_predicthaplo_overview.md)