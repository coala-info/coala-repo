---
name: mtb-snp-it
description: mtb-snp-it classifies Mycobacterium tuberculosis complex isolates into specific species and lineages by analyzing single nucleotide polymorphisms. Use when user asks to identify MTBC species, determine lineage from VCF or FASTA files, or perform high-speed speciation of tuberculosis samples.
homepage: https://github.com/samlipworth/snpit
metadata:
  docker_image: "quay.io/biocontainers/mtb-snp-it:1.1--py_0"
---

# mtb-snp-it

## Overview
The `mtb-snp-it` tool (also known as SNP-IT) provides a high-speed method for classifying isolates within the *Mycobacterium tuberculosis* complex. By analyzing Single Nucleotide Polymorphisms (SNPs) against a curated library of markers, it identifies the specific species and lineage of a sample, providing a confidence percentage for the call. It is particularly useful in clinical microbiology and genomic epidemiology for distinguishing between closely related members of the MTBC.

## Command Line Usage

The primary executable for this tool is `snpit-run.py`.

### Basic Identification
To run speciation on a single VCF or FASTA file:
```bash
snpit-run.py --input sample.vcf
```

### Batch Processing
For high-throughput environments, use GNU Parallel to process multiple files and aggregate results into a single TSV:
```bash
ls *.fasta.gz | parallel -j 8 snpit-run.py {} > snpit_results.tsv
```

## Expert Tips and Best Practices

### Reference Alignment Requirement
The tool is strictly designed to work with files aligned to the **NC000962 (H37Rv)** reference genome. Using other reference strains may lead to incorrect SNP coordinates and unreliable classification.

### Lineage 4 Granularity
While the tool identifies all major MTBC lineages, detailed **sublineage** reporting is currently optimized and primarily available for **Lineage 4**. For other lineages, the tool will typically report the main lineage and the associated confidence score.

### Input Formats
- **VCF Files**: Ensure the VCF contains the necessary SNP calls.
- **FASTA Files**: The tool can process whole genome assemblies or aligned sequences.
- **Compression**: The tool natively supports gzipped files (`.fasta.gz` or `.vcf.gz`).

### Interpreting Results
The output typically follows the format: `[Filename] [Species/Lineage] [Confidence %]`.
- A high confidence percentage (e.g., >95%) indicates a strong match to the lineage markers.
- If a sample contains mixed lineages or significant contamination, the confidence score may drop, or the tool may fail to provide a definitive classification.

## Reference documentation
- [SNP-IT: Whole genome SNP based identification of members of the Mycobacterium tuberculosis complex](./references/anaconda_org_channels_bioconda_packages_mtb-snp-it_overview.md)
- [A tool for speciating M. tuberculosis isolates from WGS](./references/github_com_samlipworth_snpit.md)