---
name: mobster
description: Mobster identifies mobile element insertions by analyzing discordant and clipped reads in BAM files. Use when user asks to identify mobile element insertions, characterize the transposon landscape of a genomic sample, or perform multi-sample germline subtraction.
homepage: https://github.com/jyhehir/mobster
metadata:
  docker_image: "quay.io/biocontainers/mobster:0.2.4.1--py36_0"
---

# mobster

## Overview
Mobster is a specialized bioinformatics tool that identifies mobile element insertions (MEIs) by analyzing discordant read pairs and "clipped" reads within BAM files. It leverages a "mobiome" reference and an aligner (typically MOSAIK or BWA) to validate potential insertion sites. This skill should be used when you need to characterize the transposon landscape of a genomic sample, particularly in human research involving GRCh37 or GRCh38 assemblies.

## Installation and Setup
The most efficient way to install Mobster is via Bioconda:
```bash
conda install bioconda::mobster
```
If building from source, ensure Java 8 and Maven are in your PATH, and use the provided `install.sh` to handle Git LFS resources and package the executable JAR.

## Core CLI Usage

### Single Sample Analysis
To run a standard analysis on a single BAM file:
```bash
java -Xmx8G -jar MobileInsertions.jar \
  -properties Mobster.properties \
  -in input.bam \
  -sn sample_name \
  -out output_prefix
```

### Multiple Sample (Trio/Cohort) Mode
To analyze multiple samples simultaneously (e.g., for germline subtraction or trio analysis):
1. Edit `Mobster.properties` and set `MULTIPLE_SAMPLE_CALLING=true`.
2. Provide comma-separated lists for inputs and sample names:
```bash
java -Xmx8G -jar MobileInsertions.jar \
  -properties Mobster.properties \
  -in child.bam,father.bam,mother.bam \
  -sn child,father,mother \
  -out trio_results
```

## Configuration and Best Practices

### Reference Genome Selection
Mobster defaults to GRCh37. To use GRCh38:
1. Unpack the compressed RepeatMasker resources:
   ```bash
   gunzip resources/repmask/alu_l1_herv_sva_other_grch38_accession_ucsc.rpmsk.gz
   ```
2. Update `Mobster.properties` to point to the GRCh38 file:
   `REPEATMASK_FILE=../resources/repmask/alu_l1_herv_sva_other_grch38_ucsc.rpmsk`

### Aligner Integration
* **MOSAIK**: The default aligner. Ensure it is in your PATH or specify the path in the properties file.
* **BWA MEM**: Supported by setting `MAPPING_TOOL=unspecified` (or `bwa` in newer versions) and ensuring the tool is accessible.
* **Anchor Quality**: The default `MINIMUM_MAPQ_ANCHOR` is 20. Keep this value to reduce false positives from multi-mapping reads.

### Sensitivity Tuning
* **PolyA Tail Detection**: To increase sensitivity for truncated insertions, lower `MINIMUM_POLYA_LENGTH` to 7 (default is usually higher).
* **Read Length**: Always verify the `READ_LENGTH` property matches your specific sequencing data to ensure accurate clustering.

## Troubleshooting Common Issues
* **Memory**: Mobster is memory-intensive. Always use the `-Xmx` flag (e.g., `-Xmx8G` or higher) to prevent OutOfMemory errors during the clustering phase.
* **Command Not Found**: If you encounter `MosaikBuild: command not found`, ensure the aligner is installed and the `MOBIOME_MAPPING_CMD` in your properties file correctly points to your aligner's executable.
* **Contig Names**: If your BAM uses "chr1" but your reference uses "1", use the property to optionally prepend "chr" to contig names to ensure compatibility.

## Reference documentation
- [Bioconda Mobster Overview](./references/anaconda_org_channels_bioconda_packages_mobster_overview.md)
- [Mobster GitHub Repository](./references/github_com_jyhehir_mobster.md)