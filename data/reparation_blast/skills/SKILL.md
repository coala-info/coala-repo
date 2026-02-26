---
name: reparation_blast
description: reparation_blast is a bioinformatics pipeline that uses ribosome profiling data and machine learning to re-annotate prokaryotic genomes and identify novel open reading frames. Use when user asks to re-annotate a prokaryotic genome, identify novel ORFs using Ribo-seq data, or predict coding sequences with a Random Forest model.
homepage: https://github.com/RickGelhausen/REPARATION_blast
---


# reparation_blast

## Overview

reparation_blast is a specialized bioinformatics pipeline designed for the (re-)annotation of prokaryotic genomes. It integrates ribosome profiling (Ribo-seq) data with machine learning to identify novel open reading frames (ORFs) that might be missed by traditional sequence-based predictors. The tool generates a genome-wide ribosome occupancy profile, creates a training set using established predictors like Prodigal or Glimmer, and then trains a Random Forest model to predict coding sequences across the genome. This specific version replaces the commercial USEARCH dependency with the open-source BLAST tool, making it suitable for open-source environments and Bioconda distribution.

## Usage Guidelines

### Basic Command Structure
The primary entry point is the `reparation.pl` script. While the tool historically accepted SAM files, recent versions (v1.0.8+) are optimized for BAM files.

```bash
./reparation.pl -sam alignment.bam -g genome.fasta -db curated_proteins.fasta -sdir ./scripts [options]
```

### Mandatory Parameters
- `-sam`: Ribosome profiling alignment file (BAM format preferred).
- `-g`: Genome fasta file. **Critical**: This must be the exact same fasta file used for the Ribo-seq read alignment.
- `-db`: A curated protein database (fasta) used for BLAST searches to validate potential ORFs.
- `-sdir`: Path to the REPARATION "scripts" directory.

### Key Configuration Options
- **P-site Assignment (`-p`)**: 
  - `1`: Plastid P-site estimation (default).
  - `3`: 3' end of the read.
  - `5`: 5' end of the read.
- **Read Length Filtering**: Use `-mn` (minimum, default 22) and `-mx` (maximum, default 40) to restrict the analysis to high-quality ribosome footprints.
- **ORF Prediction Threshold (`-score`)**: The Random Forest probability threshold. Default is `0.5`; increase this to improve specificity at the cost of sensitivity.
- **Initial Predictor (`-pg`)**: Choose the tool used to generate the initial positive training set: `1` for Prodigal (default) or `2` for Glimmer.

### Expert Tips and Best Practices
- **Environment Setup**: Ensure `prodigal`, `glimmer3`, `samtools`, and `blastp` are in your system `$PATH`. If using the Bioconda installation, these dependencies are typically handled automatically.
- **Performance Note**: Because this version uses BLAST instead of USEARCH, it is significantly slower. Ensure you have sufficient compute time for large bacterial genomes.
- **Start Codons**: By default, the tool looks for `ATG, GTG, TTG`. If working with non-standard organisms, customize this using the `-cdn` flag.
- **Output Interpretation**:
  - `_Predicted_ORFs.txt`: The primary list of predicted coding sequences.
  - `_Predicted_ORFs.bed`: Useful for visualization in genome browsers (IGV/UCSC) alongside your Ribo-seq tracks.
  - `_plastid_image.png`: Check this file to verify if the P-site offset estimation was successful.

## Reference documentation
- [REPARATION_blast GitHub Repository](./references/github_com_RickGelhausen_REPARATION_blast.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_reparation_blast_overview.md)