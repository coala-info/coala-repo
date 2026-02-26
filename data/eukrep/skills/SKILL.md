---
name: eukrep
description: EukRep classifies metagenomic contigs into eukaryotic or prokaryotic origins using k-mer frequencies and machine learning. Use when user asks to identify eukaryotic sequences in a metagenomic assembly, separate eukaryotic and prokaryotic contigs, or filter sequences for downstream eukaryotic analysis.
homepage: https://github.com/patrickwest/EukRep
---


# eukrep

## Overview
EukRep is a classification tool that utilizes k-mer frequencies and machine learning to identify the taxonomic origin of sequences in metagenomic assemblies. By separating eukaryotic contigs from prokaryotic ones, it enables targeted analysis of complex microbial communities. Use this skill when you have a fasta file of assembled contigs and need to isolate eukaryotic sequences for further study, gene prediction, or binning.

## Usage Patterns

### Basic Eukaryotic Identification
To extract only sequences predicted to be eukaryotic from an assembly:
`EukRep -i input_assembly.fasta -o eukaryotic_contigs.fasta`

### Simultaneous Classification
To sort the assembly into both eukaryotic and prokaryotic bins in a single pass:
`EukRep -i input_assembly.fasta -o euk_output.fasta --prokarya prok_output.fasta`

### Adjusting Classification Stringency
The `-m` (mode) flag controls the balance between the False Positive Rate (FPR) and False Negative Rate (FNR).
- **balanced (Default):** The standard setting for most metagenomic samples.
- **strict:** Minimizes false positives. Use this when high confidence in eukaryotic origin is required and you can afford to lose some eukaryotic sequences.
- **lenient:** Minimizes false negatives. Use this to capture the maximum amount of eukaryotic DNA, even if it includes some prokaryotic contamination.

Example of strict mode:
`EukRep -i input.fasta -o euk_strict.fasta -m strict`

## Expert Tips and Best Practices
- **Input Compatibility:** EukRep accepts standard FASTA format and supports gzipped (.gz) input files directly.
- **Contig Length Considerations:** While EukRep can process fragments as short as 5kb, classification accuracy improves significantly with longer contigs (e.g., 20kb+).
- **Handling False Positives:** In many metagenomes, eukaryotes are entirely absent. Because EukRep has a non-zero false positive rate, it may still produce output in these cases. Always validate eukaryotic bins with downstream taxonomic or phylogenomic markers.
- **Pipeline Workflow:** EukRep is designed as a filtering step. Once eukaryotic contigs are identified, they should be processed through eukaryotic-specific tools for gene prediction (like Augustus) and binning.
- **Dependency Management:** If you encounter `ModuleNotFoundError` or `ImportError` related to `sklearn`, ensure that `scikit-learn` is specifically version `0.19.2`, as the pre-trained models are version-dependent.

## Reference documentation
- [EukRep Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_eukrep_overview.md)
- [EukRep GitHub Repository](./references/github_com_patrickwest_EukRep.md)