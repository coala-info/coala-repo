---
name: psosp
description: PSOSP classifies prophages into SOS-dependent, SOS-independent, or SOS-uncertain categories by identifying LexA binding sites and calculating heterology indices. Use when user asks to predict prophage induction mechanisms, identify SOS-dependent phages, or determine appropriate induction agents for Gammaproteobacteria.
homepage: https://github.com/mujiezhang/PSOSP
---


# psosp

## Overview

PSOSP (Prophage SOS-dependency Predictor) is a specialized bioinformatics tool used to classify prophages into three categories: SOS-dependent (SdPs), SOS-independent (SiPs), and SOS-uncertain (SuP). It functions by identifying LexA protein binding sites and calculating a Heterology Index (HI) for potential SOS boxes within prophage promoter regions. This classification helps researchers choose the correct experimental induction agents—such as Mitomycin C (MMC) or UV for SOS-dependent phages, versus physical factors or specific chemical inducers for SOS-independent phages.

## Installation and Setup

The most reliable way to install PSOSP is via Conda:

```bash
conda create -n psosp psosp
conda activate psosp
```

If you require prophage quality assessment, you must also download the CheckV database:
```bash
checkv download_database ./
```

## Command Line Usage

### Basic Prediction
To run a standard analysis, provide the host genome and the phage genome(s):

```bash
psosp -hf host_genome.fasta -vf phage_genome.fasta -wd output_directory
```

### Parameters
- `-hf`: Path to the host genome in FASTA format.
- `-vf`: Path to the phage genome(s) in FASTA format.
- `-wd`: Working directory for result files.
- `-faa`: (Optional) Path to host protein sequences if already predicted.
- `-db`: (Optional) Path to the CheckV reference database for completeness assessment.

### Testing the Installation
Verify the tool is working correctly using the built-in test command:
```bash
psosp test
```

## Best Practices and Expert Tips

### Host and Phage Requirements
- **Taxonomic Scope**: PSOSP is optimized for **Gammaproteobacteria** (e.g., *Vibrio, Pseudomonas, Escherichia, Salmonella, Shigella, Klebsiella*). Results for hosts outside this class may be less reliable.
- **Genome Quality**: Use host genomes with >90% completeness (verified by CheckM2). Low-quality assemblies may miss the LexA protein, leading to false negatives.
- **Phage Completeness**: Predictions are most accurate for prophages with >=90% completeness according to CheckV.
- **Multi-Contig Hosts**: If the host genome is fragmented, ensure all contigs are provided in a single multi-contig FASTA file.

### Interpreting Results
The tool categorizes prophages based on the minimum Heterology Index ($HI_{min}$) found in the promoter regions:
- **SdP ($HI_{min} \leq HI_{c1}$)**: SOS-dependent. Use conventional agents like Mitomycin C or UV light for induction.
- **SiP ($HI_{min} \geq HI_{c2}$)**: SOS-independent. Consider alternative inducers such as EDTA, salinity changes, temperature shifts, or pH variations.
- **SuP ($HI_{c1} < HI_{min} < HI_{c2}$)**: SOS-uncertain. These require experimental screening with both SOS-dependent and independent methods.

### Workflow Optimization
- If you have already performed gene prediction on the host, providing the `-faa` file can significantly speed up the LexA identification step.
- Ensure the phage sequences provided are actually associated with the host; predicting regulatory relationships for mismatched pairs will yield meaningless results.

## Reference documentation
- [PSOSP Overview](./references/anaconda_org_channels_bioconda_packages_psosp_overview.md)
- [PSOSP GitHub Documentation](./references/github_com_mujiezhang_PSOSP.md)