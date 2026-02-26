---
name: kestrel
description: Kestrel identifies genetic variants in Illumina short-read data using a k-mer based approach and reference-guided local assembly. Use when user asks to call variants without traditional sequence alignment, detect patterns of variation using k-mers, or generate VCF files from FASTQ data.
homepage: https://github.com/paudano/kestrel
---


# kestrel

## Overview

Kestrel is a bioinformatics tool that identifies variants in Illumina short-read data using a k-mer based approach rather than traditional sequence alignment. By breaking reads into uniform fragments (k-mers) and comparing their frequencies against a reference set, Kestrel detects patterns of variation. It then employs a reference-guided local assembly method to reconstruct the altered regions and generate variant calls in VCF format. This approach is particularly useful for bypassing the biases and computational costs associated with mapping reads to a reference genome.

## Usage Patterns

### Basic Command Line Execution
The primary way to run Kestrel is through the provided wrapper script or directly via the Java Archive (JAR) file.

**Using the wrapper script:**
```bash
kestrel -r REFERENCE.fasta -o VARIANTS.vcf READS.fastq
```

**Using Java directly:**
```bash
java -Xmx4G -jar kestrel.jar -r REFERENCE.fasta -o VARIANTS.vcf READS.fastq
```

### Key Parameters
- `-r <file>`: Path to the reference genome in FASTA format.
- `-o <file>`: Path for the output variant calls in VCF format.
- `READS.fastq`: The input sequence data (supports standard FASTQ).

## Expert Tips and Best Practices

### Memory Management
Kestrel is a Java-based application. For large datasets, you must ensure the Java Virtual Machine (JVM) has enough heap memory allocated. Use the `-Xmx` flag to set the maximum memory (e.g., `-Xmx8G` or higher depending on the k-mer complexity and genome size).

### Installation Integrity
- **Do not separate files**: Kestrel relies on several dependency JAR files located in its library directory. If you move `kestrel.jar` away from its sibling JARs, it will fail to resolve file modules, often resulting in the error: "Could not automatically resolve a file type from the file name".
- **Symbolic Links**: If you need to call Kestrel from a different directory (like `/usr/local/bin`), create a symbolic link to the `kestrel` execution script rather than the JAR file itself.

### Input Requirements
- **Java Version**: Ensure Java 1.7 or later is installed in your environment.
- **Read Type**: Kestrel is specifically optimized for short-read Illumina data. It is not intended for long-read technologies (PacBio/Oxford Nanopore).

### Troubleshooting
If Kestrel fails to recognize input formats, verify that all bundled libraries are present in the `lib` folder relative to the JAR file. The mapping-free nature means that if the k-mer counts appear anomalous, you should check the quality of the input FASTQ files using a tool like FastQC before processing with Kestrel.

## Reference documentation
- [Kestrel Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_kestrel_overview.md)
- [Kestrel GitHub Repository](./references/github_com_paudano_kestrel.md)