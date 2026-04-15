---
name: detonate
description: DETONATE evaluates de novo transcriptome assemblies using probabilistic scores and reference-based metrics to assess assembly quality. Use when user asks to evaluate transcriptome assembly quality, calculate RSEM-EVAL scores, compare assemblies against a reference, or filter low-quality contigs.
homepage: https://github.com/deweylab/detonate
metadata:
  docker_image: "quay.io/biocontainers/detonate:1.11--boost1.64_1"
---

# detonate

## Overview

DETONATE (DE novo TranscriptOme rNa-seq Assembly with or without the Truth Evaluation) is a computational framework designed to move beyond simple metrics like N50 when assessing transcriptome assemblies. It consists of two main components:

1.  **RSEM-EVAL**: A reference-free method that calculates a probabilistic score based on how well the RNA-Seq reads support the assembly and the assembly's compactness.
2.  **REF-EVAL**: A toolkit for reference-based evaluation, providing metrics such as kmer compression (KC) scores, and nucleotide/contig precision, recall, and F1 scores.

This skill should be used to guide the selection of the best assembler, optimize assembly parameters, or filter low-quality contigs from a final set.

## RSEM-EVAL: Reference-Free Evaluation

RSEM-EVAL is the preferred method when a high-quality reference genome or transcriptome is unavailable.

### Basic Usage
To calculate the RSEM-EVAL score for an assembly:
```bash
rsem-eval-calculate-score [options] reads.fq assembly.fa output_prefix average_read_length
```

### Expert Tips for RSEM-EVAL
*   **Score Interpretation**: RSEM-EVAL scores are log-likelihoods and are always negative. **Higher scores (closer to zero) indicate better assemblies.** For example, -80,000 is superior to -200,000.
*   **Transcript Length Parameters**: For the most accurate results, provide species-specific parameters using `--transcript-length-parameters`. You can estimate these from a related species using `rsem-eval-estimate-transcript-length-distribution`.
*   **Paired-End Data**: When using paired-end reads, the `average_read_length` argument should represent the average **fragment** length.
*   **Contig Filtering**: Check the `.score.isoforms.results` output. The `contig_impact_score` can be used to identify and remove contigs that do not contribute positively to the overall assembly score.

## REF-EVAL: Reference-Based Evaluation

REF-EVAL is used when you have a reference transcriptome or wish to compare an assembly against an estimated "true" assembly derived from alignments.

### Workflow 1: Estimating the "True" Assembly
Before running REF-EVAL, you often need to generate a "true" assembly estimate using RSEM alignments to a reference:
```bash
ref-eval-estimate-true-assembly --reference ref_prefix --expression expr_prefix --assembly output_prefix --alignment-policy [sample|best|all]
```

### Workflow 2: Calculating Scores
Once you have a reference (B.fa) and your assembly (A.fa), run the evaluation:
```bash
ref-eval --scores [nucl,pair,contig,kmer,kc] \
         --A-seqs A.fa \
         --B-seqs B.fa \
         [additional-required-flags]
```

### Common CLI Patterns
*   **Kmer Compression (KC) Score**: This is a highly recommended alignment-free metric. It requires `--scores kc`, `--kmerlen`, `--readlen`, and `--num-reads`.
*   **Alignment-Based Scores**: To compute `nucl` or `contig` scores, you must first generate alignments (typically using Blat) and provide them via `--A-to-B` and `--B-to-A`.
*   **Weighted vs. Unweighted**: Use `--weighted both` if you have RSEM expression results (`.isoforms.results`) for both the assembly and the reference. Weighted scores account for transcript abundance.

## Best Practices
*   **Consistency**: Ensure the RNA-Seq data used for evaluation is identical to the data used to generate the assembly.
*   **Memory Management**: For large assemblies, use `--hash-table-type sparse` and `--hash-table-numeric-type float` in REF-EVAL to reduce RAM consumption.
*   **Strand Specificity**: If your RNA-Seq library is strand-specific, always include the `--strand-specific` flag to avoid incorrect kmer matching or alignment accounting.



## Subcommands

| Command | Description |
|---------|-------------|
| ref-eval-estimate-true-assembly | A program to estimate the "true" assembly of a set of reads, relative to a set of reference sequences |
| rsem-eval-calculate-score | Calculates RSEM-EVAL score and expression values using alignments. |

## Reference documentation
- [DETONATE Overview](./references/deweylab_biostat_wisc_edu_detonate.md)
- [RSEM-EVAL Usage](./references/deweylab_biostat_wisc_edu_detonate_rsem-eval.html.md)
- [REF-EVAL Usage](./references/deweylab_biostat_wisc_edu_detonate_ref-eval.html.md)
- [Estimating True Assembly](./references/deweylab_biostat_wisc_edu_detonate_ref-eval-estimate-true-assembly.html.md)
- [DETONATE Vignette](./references/deweylab_biostat_wisc_edu_detonate_vignette.html.md)