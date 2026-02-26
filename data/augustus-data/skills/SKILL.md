---
name: augustus-data
description: AUGUSTUS predicts gene structures in eukaryotic genomic sequences using ab initio methods or external evidence. Use when user asks to predict genes, annotate eukaryotic genomes, or incorporate extrinsic evidence like RNA-Seq and protein alignments into gene models.
homepage: http://bioinf.uni-greifswald.de/augustus/
---


# augustus-data

## Overview

AUGUSTUS is a specialized gene prediction tool designed for eukaryotic genomic sequences. It functions as both an ab initio predictor—relying solely on the DNA sequence—and as a flexible framework for evidence-based annotation. By incorporating "hints" from external sources like RNA-Seq, ESTs, or protein alignments, it significantly improves the accuracy of predicted exon-intron structures, including alternative splicing and UTRs.

## CLI Usage and Best Practices

### Basic Command Structure
The most common usage involves specifying a pre-trained species model and a FASTA file:
```bash
augustus --species=SPECIES_NAME query.fasta
```

### Species Selection
*   **Closest Relative**: If your specific organism is not available, use the most closely related species (e.g., `human` for most mammals).
*   **List Available Species**: Check the `config/species` directory in your AUGUSTUS installation to see all valid `SPECIES_NAME` options.

### Incorporating Extrinsic Evidence (Hints)
To improve accuracy using external data (e.g., RNA-Seq or protein alignments), use the hints mechanism:
*   **Hints File**: Evidence must be in GFF format.
*   **Extrinsic Config**: Use an `extrinsic.cfg` file to define the "bonus" or "penalty" for different types of evidence.
```bash
augustus --species=human --hintsfile=hints.gff --extrinsicCfgFile=extrinsic.cfg query.fasta
```

### Common Functional Flags
*   **UTR Prediction**: Enable 5' and 3' UTR prediction (if trained for the species): `--UTR=on`
*   **Alternative Splicing**: Report alternative transcripts: `--alternatives-from-evidence=true` or `--alternatives-from-sampling=true`
*   **Strand Specificity**: Predict genes on specific strands: `--strand=forward`, `--strand=backward`, or `--strand=both` (default).
*   **Complete Genes Only**: To ignore partial gene predictions at the sequence boundaries: `--genemodel=complete`

### Expert Tips
*   **Large Genomes**: For whole-genome annotation, split the genome into smaller chunks or individual chromosomes to parallelize the process, as AUGUSTUS is typically single-threaded per process.
*   **Output Redirection**: AUGUSTUS outputs to stdout by default. Always redirect to a GFF file for downstream analysis: `augustus --species=human query.fa > output.gff`
*   **Protein Profile Extension (PPX)**: Use the `--proteinprofile` flag when you have a block profile of a protein family to identify specific family members with high sensitivity.

## Reference documentation
- [AUGUSTUS Main Overview](./references/bioinf_uni-greifswald_de_augustus.md)
- [AUGUSTUS Datasets and Configuration](./references/bioinf_uni-greifswald_de_augustus_datasets.md)
- [AUGUSTUS Parameters and Options](./references/bioinf_uni-greifswald_de_augustus_submission.php.md)