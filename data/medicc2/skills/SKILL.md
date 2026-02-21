---
name: medicc2
description: MEDICC2 is a specialized tool for reconstructing the evolutionary history of cancer cells using copy number variation (CNV) data.
homepage: https://bitbucket.org/schwarzlab/medicc2
---

# medicc2

## Overview
MEDICC2 is a specialized tool for reconstructing the evolutionary history of cancer cells using copy number variation (CNV) data. Unlike standard phylogenetic methods, it uses a minimum evolution framework to calculate genomic distances and ancestral states, specifically handling the complexities of whole-genome doubling. It is the preferred choice when you need to identify the timing of WGD events relative to other copy number alterations across multiple biopsies or single cells from the same patient.

## Core Workflow and CLI Patterns

### Input Preparation
MEDICC2 requires a tab-separated file (TSF) containing segmented copy number data.
- **Required Columns**: `sample_id`, `chrom`, `start`, `end`, `n_total`, `n_minor`.
- **Note**: Ensure coordinates are 1-based and non-overlapping.

### Basic Tree Reconstruction
To run the standard pipeline for a single patient:
```bash
medicc2 input_segments.tsv output_dir/
```

### Handling Whole-Genome Doubling
If you suspect or want to explicitly model WGD, use the `--total` or `--major-minor` modes. MEDICC2 automatically searches for the most parsimonious tree including potential doubling events.
- **Force WGD detection**:
  ```bash
  medicc2 --wgd input_segments.tsv output_dir/
  ```

### Advanced Configuration
- **Reference Genome**: Specify the genome build (e.g., hg19, hg38) to ensure correct chromosomal lengths.
  ```bash
  medicc2 --genome hg38 input_segments.tsv output_dir/
  ```
- **Parallelization**: Use the `-p` flag to speed up distance matrix calculations.
  ```bash
  medicc2 -p 8 input_segments.tsv output_dir/
  ```

## Best Practices
- **Filtering**: Remove highly fragmented segments or those in centromeric regions before input to reduce computational noise.
- **Normal Cell Integration**: Always include a "normal" sample (n_total=2, n_minor=1 for autosomes) to act as the root of the phylogenetic tree.
- **Output Interpretation**: 
    - `final_tree.newick`: The reconstructed phylogeny.
    - `ancestral_states.tsv`: Inferred copy number profiles for internal nodes.
    - `distances.tsv`: Pairwise genomic distances between samples.

## Reference documentation
- [MEDICC2 Bitbucket Repository](./references/bitbucket_org_schwarzlab_medicc2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_medicc2_overview.md)