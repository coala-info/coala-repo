---
name: reparation_blast
description: reparation_blast identifies functional open reading frames and their precise start sites in bacterial genomes using ribosome profiling data and BLAST homology searches. Use when user asks to improve bacterial genome annotation, predict protein-coding regions from Ribo-seq data, or identify translation start sites.
homepage: https://github.com/RickGelhausen/REPARATION_blast
---


# reparation_blast

## Overview
reparation_blast is a specialized bioinformatics pipeline designed to improve the annotation of bacterial genomes. By leveraging the high-resolution data provided by ribosome profiling, the tool identifies the precise locations where translation occurs. It traverses the genome to generate potential ORFs, creates a training set for a random forest model, and then predicts functional ORFs and their specific start sites. This version is an updated fork of the original REPARATION pipeline, modified to use the open-source BLAST tool for protein sequence searches and updated for compatibility with Python 3.6+.

## Execution Workflow
The pipeline is executed via a Perl wrapper script (`reparation.pl`) which coordinates various Python, R, and binary dependencies.

### Mandatory Parameters
To run a basic analysis, you must provide the following four inputs:
- `-sam`: The alignment file of Ribo-seq reads (must be in SAM format and aligned to the same genome provided in `-g`).
- `-g`: The genome sequence in FASTA format.
- `-db`: A FASTA database of curated bacterial protein sequences (used for BLAST homology searches).
- `-sdir`: The path to the REPARATION `scripts` directory.

### Common CLI Patterns
**Standard Run:**
```bash
./reparation.pl -sam ribo_data.sam -g genome.fasta -db uniprot_ref.fasta -sdir ./scripts -en my_experiment
```

**Customizing ORF Detection:**
If you need to adjust the sensitivity of the ORF detection (e.g., for very small proteins or specific codon usage):
```bash
./reparation.pl -sam data.sam -g gen.fa -db ref.fa -mo 60 -cdn ATG,GTG,TTG,TTT -pg 1
```
*Note: `-mo 60` sets the minimum ORF length to 60 nucleotides; `-cdn` specifies the allowed start codons.*

## Expert Tips and Best Practices
- **Alignment Consistency**: Ensure the SAM file was generated using the exact same FASTA file passed to the `-g` parameter. Mismatches in chromosome names or lengths will cause the pipeline to fail during P-site assignment.
- **P-site Strategy**: By default (`-p 1`), the tool uses `plastid` for P-site estimation. If your library has specific characteristics (e.g., 3' end mapping is more reliable), consider switching to `-p 3`.
- **Resource Management**: The introduction of BLAST instead of USEARCH increases runtime. Ensure your environment has sufficient CPU threads available, as BLAST and the Random Forest training (R) can be computationally intensive.
- **Binary Permissions**: If using the bundled versions of `prodigal` or `glimmer3` located in the scripts directory, ensure they have execute permissions (`chmod +x`).
- **Input Filtering**: Use `-mn` (minimum read length) and `-mx` (maximum read length) to filter out Ribo-seq noise. The default range is 22-40 nucleotides, which is standard for most bacterial datasets.

## Primary Outputs
- `_Predicted_ORFs.txt`: The main results file containing the list of predicted protein-coding regions.
- `_Predicted_ORFs.bed`: A browser-ready file for visualizing predicted ORFs in tools like IGV.
- `_predicted_ORFs.fasta`: The translated amino acid sequences of the predicted ORFs.
- `_PR_ROC_curve.pdf`: Performance metrics of the Random Forest model.



## Subcommands

| Command | Description |
|---------|-------------|
| blastp | Protein-Protein BLAST 2.7.1+ |
| glimmer3 | Read DNA sequences in <sequence-file> and predict genes in them using the Interpolated Context Model in <icm-file>. Output details go to file <tag>.detail and predictions go to file <tag>.predict |
| prodigal | PRODIGAL v2.6.3 [February, 2016] Univ of Tenn / Oak Ridge National Lab Doug Hyatt, Loren Hauser, et al. |
| reparation.pl | Performs BLAST analysis for bacterial protein sequence identification and ORF prediction. |
| samtools | Tools for alignments in the SAM format |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_RickGelhausen_REPARATION_blast.md)
- [Bioconda Package Information](./references/anaconda_org_channels_bioconda_packages_reparation_blast_overview.md)