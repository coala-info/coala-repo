---
name: bcftools-gtc2vcf-plugin
description: This tool converts proprietary Illumina and Affymetrix microarray data formats into standard VCF files. Use when user asks to convert GTC or IDAT files to VCF, process Affymetrix CHP files, or generate BAF and LRR intensity metrics from array data.
homepage: https://github.com/freeseek/gtc2vcf
---


# bcftools-gtc2vcf-plugin

## Overview

The `bcftools-gtc2vcf-plugin` is a specialized extension for `bcftools` that enables the conversion of proprietary microarray data formats into standard genomic formats. It eliminates the need for Windows-only tools like Illumina GenomeStudio or Affymetrix Power Tools for basic VCF generation. Use this skill to process Illumina BeadChips and Affymetrix Axiom/SNP6.0 arrays, specifically when you need to generate VCFs containing intensity-based metrics (BAF/LRR) alongside genotypes.

## Core Workflows

### Illumina Data Conversion (+gtc2vcf)

The plugin handles both `.gtc` (genotype call files) and `.idat` (raw intensity files).

*   **Basic GTC to VCF**:
    `bcftools +gtc2vcf -f human_g1k_v37.fasta --gtcs sample.gtc -o sample.vcf`
*   **Full Conversion with Manifests**:
    To ensure correct genomic coordinates and cluster-based metrics, provide the BPM/CSV manifest and EGT cluster files.
    `bcftools +gtc2vcf -c GSA-24v3.csv -e GSA-24v3_ClusterFile.egt -f ref.fasta sample.gtc -o output.vcf`
*   **Processing IDATs directly**:
    Use the `-i` flag to input IDAT files.
    `bcftools +gtc2vcf -i sample_Grn.idat sample_Red.idat -f ref.fasta -o output.vcf`

### Affymetrix Data Conversion (+affy2vcf)

For Affymetrix platforms, the plugin typically requires CHP files or APT (Affymetrix Power Tools) output files.

*   **Standard CHP Conversion**:
    `bcftools +affy2vcf --csv GenomeWideSNP_6.na35.annot.csv --fasta-ref ref.fasta --chps cc-chp/ --output output.vcf`
*   **Using APT Output**:
    If you have run `apt-probeset-genotype`, you can combine the results:
    `bcftools +affy2vcf --csv manifest.csv --fasta-ref ref.fasta --calls calls.txt --confidences conf.txt --summary summary.txt --snp posteriors.txt -o output.vcf`

## Expert Tips and Best Practices

*   **Reference FASTA**: Always provide a reference FASTA file (`-f` or `--fasta-ref`). Without it, the plugin cannot verify the reference alleles, which may lead to incorrect VCF records or missing information.
*   **FORMAT Tags**: By default, the plugin exports a standard set of tags. Use `-l` to list available tags and `-t` to customize them. For mosaicism analysis, ensure `BAF` and `LRR` are included.
*   **Cluster Adjustment**: When processing Illumina data, use `--adjust-clusters` (requires `--bpm` and `--egt`) to recalculate cluster centers in (Theta, R) space, which significantly improves the quality of BAF and LRR values.
*   **Memory Management**: For large batches of GTC files, use the `--gtcs` option with a directory path or a file containing a list of paths rather than passing them all as individual arguments to avoid shell command length limits.
*   **Output Compression**: Use `-O z` for compressed VCF or `-O b` for BCF to save disk space, especially since array VCFs with intensity data can be quite large.
*   **Genome Build Updates**: If your manifest uses an older genome build (e.g., hg19/GRCh37), you can use `--sam-flank` with a SAM file of remapped probe sequences to update coordinates to GRCh38 during conversion.

## Reference documentation

- [bcftools-gtc2vcf-plugin Overview](./references/anaconda_org_channels_bioconda_packages_bcftools-gtc2vcf-plugin_overview.md)
- [gtc2vcf GitHub Repository](./references/github_com_freeseek_gtc2vcf.md)