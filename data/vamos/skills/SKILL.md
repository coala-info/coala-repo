---
name: vamos
description: Vamos characterizes tandem repeat variation by encoding VNTR sequences into efficient motif sets using haplotype-resolved assemblies or aligned long reads. Use when user asks to annotate VNTR motifs, characterize tandem repeat variation, or generate motif-based VCFs from long-read alignments.
homepage: https://github.com/ChaissonLab/vamos
---


# vamos

## Overview
The `vamos` tool provides a specialized workflow for characterizing tandem repeat variation by encoding VNTR sequences into efficient motif sets. Unlike general-purpose variant callers, `vamos` uses an optimization routine to select a subset of motifs that reflect true biological variation rather than sequencing errors. It supports both haplotype-resolved assemblies and raw aligned reads, utilizing partial-order alignment (POA) to construct consensus sequences for annotation.

## Installation and Setup
The tool is available via bioconda or can be compiled from source.
```bash
# Conda installation
conda create --name vamos python=3.10
conda activate vamos
conda install -c bioconda htslib boost libdeflate
```

## Core Workflows

### 1. Annotating Haplotype-Resolved Assemblies
Use the `--contig` mode when you have BAM files representing individual haplotypes mapped to a reference genome (e.g., GRCh38 or CHM13).
```bash
vamos --contig -b assembly.hap1.mapped.bam -r motifs.tsv -s sample_name -o output.vcf -t 8
```

### 2. Annotating Aligned Reads
Use the `--read` mode for standard long-read BAM files. `vamos` will attempt to phase the reads using a max-cut heuristic if they are unphased, or respect existing `HA` SAM tags from tools like WhatsHap.
```bash
vamos --read -b aligned_reads.bam -r motifs.tsv -s sample_name -o output.vcf -t 8
```

## Motif Catalog Configuration
The reference motif file (`-r`) is a BED-like TSV. Ensure your catalog follows this schema:
- **Col 1-3**: Chromosome, Start, End.
- **Col 4**: Comma-separated motifs used for annotation.
- **Col 6**: Locus type (VNTR or STR).
- **Col 7**: Period size of the motif consensus.

Latest motif sets (v2.1+) for GRCh38 and CHM13 should be retrieved from Zenodo to ensure compatibility with the "efficient motif" selection logic.

## Interpreting VCF Output
The output VCF uses specific INFO fields to describe the repeat structure:
- `RU`: The list of all repeating units (motifs) found at the locus.
- `ALTANNO_H1/H2`: The sequence of motifs for each haplotype, represented as indices (starting at 0) pointing to the `RU` field.
- `LEN_H1/H2`: The total count of motifs in the allele.

**Example Interpretation:**
If `RU=ACTG,GGT` and `ALTANNO_H1=0,0,1`, the sequence is `ACTGACTGGGT`.

## Expert Tips
- **Phasing**: For the most accurate diploid calls in `--read` mode, pre-phase your BAM files using WhatsHap or HapCut2 to provide the `HA` tag.
- **Memory/Threads**: Use the `-t` flag to scale with available CPU cores; POA-based consensus construction is computationally intensive for long VNTRs.
- **Reference Matching**: Always ensure the motif catalog (`-r`) matches the reference genome version used for the BAM alignment (e.g., do not use GRCh38 motifs with a CHM13 BAM).



## Subcommands

| Command | Description |
|---------|-------------|
| vamos | Vamos is a tool for detecting tandem repeats in sequencing data. |
| vamos | Vamos is a tool for VNTR analysis. |
| vamos | Vamos is a tool for VNTR analysis. |

## Reference documentation
- [vamos README](./references/github_com_ChaissonLab_vamos_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vamos_overview.md)