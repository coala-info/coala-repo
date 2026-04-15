---
name: guidemaker
description: GuideMaker identifies and filters CRISPR guide RNAs for diverse genomes and custom Cas enzymes. Use when user asks to design gRNA panels, manage off-target constraints, or calculate efficiency scores for CRISPR experiments.
homepage: https://github.com/USDA-ARS-GBRU/GuideMaker
metadata:
  docker_image: "quay.io/biocontainers/guidemaker:0.4.2--pyhdfd78af_0"
---

# guidemaker

## Overview

GuideMaker is a specialized bioinformatics tool designed for the rapid identification and filtering of CRISPR guide RNAs. Unlike tools optimized for standard model organisms, GuideMaker is built for flexibility, allowing researchers to define custom Protospacer Adjacent Motifs (PAM) and work with non-standard Cas enzymes. It is particularly effective for bacterial genomes and small eukaryotes, using advanced indexing to ensure that gRNAs are unique within a specified edit distance. Use this skill to generate command-line instructions for designing gRNA panels, managing off-target constraints, and calculating efficiency scores.

## Command Line Usage

### Basic Execution
GuideMaker requires either a GenBank file or a combination of Fasta and GFF/GTF files.

**Using GenBank:**
```bash
guidemaker --genbank genome.gbk --pamseq NGG --outdir results/
```

**Using Fasta and GFF:**
```bash
guidemaker --fasta genome.fasta --gff genome.gff --pamseq TTTV --pam_orientation 5prime --outdir results/
```

### Key Parameters and Best Practices

*   **PAM Configuration**: 
    *   Use `--pamseq` with IUPAC ambiguous bases (e.g., `NGG`, `TTTV`).
    *   Set `--pam_orientation` to `5prime` (e.g., Cas12a) or `3prime` (e.g., Cas9). Default is `3prime`.
*   **Specificity and Off-targets**:
    *   `--dist`: Minimum edit distance (Hamming or Levenshtein) from other potential guides. Default is 2.
    *   `--lsr`: Length of the "Seed Region" near the PAM that must be unique. Default is 10.
*   **Targeting Logic**:
    *   `--before`: Distance (bp) to keep guides in front of a feature.
    *   `--into`: Distance (bp) to keep guides inside the start of a feature.
*   **Scoring**:
    *   `--doench_efficiency_score`: Use for NGG PAMs and 25bp length to get on-target efficiency.
    *   `--cfd_score`: Use for NGG PAMs to assess off-target activity.

### Expert Tips

1.  **Performance**: For large genomes, increase `--threads` to utilize multi-core processing. GuideMaker uses HNSW graphs for fast nearest-neighbor searches, which scales well with more threads.
2.  **Filtering**: Use `--attribute_key` (default: `ID`) and `--filter_by_attribute` to design guides only for a specific subset of locus tags or genes.
3.  **Restriction Sites**: If cloning gRNAs into a specific vector, use `--restriction_enzyme_list` followed by the recognition sequences (e.g., `GGTCTC`) to automatically filter out guides containing those sites.
4.  **Control RNAs**: By default, GuideMaker generates 1000 random non-targeting control RNAs. Adjust this with `--controls` based on your experimental design.

## Reference documentation
- [GuideMaker Main Repository](./references/github_com_USDA-ARS-GBRU_GuideMaker.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_guidemaker_overview.md)