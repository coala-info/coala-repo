---
name: ribotricer
description: Ribotricer is a specialized bioinformatics tool for Ribo-seq analysis that identifies translating ORFs by assessing the sub-codon periodicity of mapped reads.
homepage: https://github.com/smithlabcode/ribotricer
---

# ribotricer

## Overview
Ribotricer is a specialized bioinformatics tool for Ribo-seq analysis that identifies translating ORFs by assessing the sub-codon periodicity of mapped reads. Unlike tools that rely solely on read density, Ribotricer uses a phase-score based on the 3-nt movement of the ribosome. This allows for the detection of active translation in short ORFs (uORFs, dORFs) and overlapping ORFs that are often missed by standard RNA-seq pipelines.

The workflow consists of two primary phases:
1.  **Index Generation**: Identifying all potential candidate ORFs from the genome and annotation.
2.  **ORF Detection**: Evaluating the periodicity of Ribo-seq reads across those candidates to determine translation status.

## Core Workflow

### 1. Prepare Candidate ORFs
Generate a candidate ORF index from your reference files. This step identifies all possible start-to-stop sequences.

```bash
ribotricer prepare-orfs \
    --gtf genome_annotation.gtf \
    --fasta reference_genome.fasta \
    --prefix study_index
```

**Expert Tips:**
*   **Start Codons**: By default, it only looks for 'ATG'. For non-canonical translation studies, use `--start_codons ATG,CTG,GTG`.
*   **ORF Length**: The default minimum length is 60 nts. Adjust with `--min_orf_length` if searching for small peptides (sORFs).

### 2. Detect Translating ORFs
Run the detection algorithm on your alignment data.

```bash
ribotricer detect-orfs \
    --bam alignment.bam \
    --ribotricer_index study_index_candidate_orfs.tsv \
    --prefix sample_output \
    --phase_score_cutoff 0.440
```

## Species-Specific Phase Score Cutoffs
The phase score cutoff is critical for accuracy. Use these recommended values based on your organism:

| Species | Recommended Cutoff |
| :--- | :--- |
| Human | 0.440 |
| Mouse | 0.418 |
| Rat | 0.453 |
| Baker's Yeast | 0.318 |
| Arabidopsis | 0.330 |
| Zebrafish | 0.249 |
| C. elegans | 0.239 |
| Drosophila | 0.181 |

## Advanced Filtering and Quality Control

### Translation Status Filters
By default, an ORF is marked "translating" if its phase score exceeds the cutoff and it has at least 5 codons with non-zero reads. You can tighten these requirements:
*   `--min_valid_codons_ratio`: Set to `0.75` to ensure reads cover at least 75% of the ORF's length.
*   `--min_read_density`: Use to filter out very lowly expressed ORFs.

### Handling Strandedness
Ribotricer automatically infers protocol strandedness, but for complex libraries, it is safer to specify it:
*   `--stranded yes`: Standard stranded protocol.
*   `--stranded reverse`: For "reverse-stranded" (e.g., Illumina TruSeq) protocols.

### Quality Control Outputs
After running `detect-orfs`, always inspect the following files:
*   `{prefix}_read_length_dist.pdf`: Check if the RPF length distribution matches expected sizes (typically 28-30nt for eukaryotes).
*   `{prefix}_metagene_plots.pdf`: Ensure strong 3-nt periodicity is visible at the start codon of annotated CDS regions.
*   `{prefix}_psite_offsets.txt`: Verify the P-site offsets calculated for each read length.

## Reference documentation
- [ribotricer GitHub README](./references/github_com_smithlabcode_ribotricer.md)
- [ribotricer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ribotricer_overview.md)