---
name: hicexplorer
description: HiCExplorer is a comprehensive suite of tools for processing, normalizing, and analyzing Hi-C data to study 3D genomic interactions. Use when user asks to build contact matrices, normalize Hi-C data, detect Topologically Associating Domains, or identify A/B compartments.
homepage: https://github.com/deeptools/HiCExplorer
metadata:
  docker_image: "quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0"
---

# hicexplorer

## Overview
HiCExplorer is a comprehensive suite of tools designed to handle the complex requirements of 3D genome analysis. It facilitates a modular workflow that transforms raw sequencing reads into high-resolution contact matrices. Beyond simple matrix generation, the toolset allows for sophisticated downstream analyses, including the detection of Topologically Associating Domains (TADs), A/B compartment scoring, and the visualization of genomic interactions alongside other tracks like ChIP-seq or gene annotations.

## Core Workflow and CLI Patterns

### 1. Read Mapping
Hi-C reads often contain ligation sites, meaning they will not align end-to-end. Use local alignment and ensure read order is preserved for downstream pairing.

```bash
# Map mates individually using bowtie2
bowtie2 --local --reorder -x genome_index -U R1.fastq.gz 2>> R1.log | samtools view -Shb - > R1.bam
bowtie2 --local --reorder -x genome_index -U R2.fastq.gz 2>> R2.log | samtools view -Shb - > R2.bam
```

### 2. Identifying Restriction Sites
For restriction-fragment resolution matrices, you must first locate the enzyme motifs in the reference genome.

```bash
findRestSite --fasta genome.fa --searchPattern AAGCTT --outFile hindIII.bed
```

### 3. Building the Contact Matrix
Combine the aligned BAM files into a contact matrix. This step filters valid Hi-C pairs from artifacts like self-ligation or unligated fragments.

```bash
hicBuildMatrix \
    -s R1.bam R2.bam \
    --restrictionSequence AAGCTT \
    --restrictionCutFile hindIII.bed \
    --minDistance 400 \
    --maxDistance 800 \
    --outBam valid_pairs.bam \
    -o matrix.h5
```
*   **Expert Tip**: Set `--minDistance` to approximately half the fragment length and `--maxDistance` to the full fragment length used in library preparation.

### 4. Matrix Correction (Normalization)
Raw matrices contain biases (e.g., GC content, mappability). Use the Knight-Ruiz (KR) or iterative correction method to normalize the data.

```bash
hicCorrectMatrix diagnostic_plot -m matrix.h5 -o diagnostic.png
hicCorrectMatrix correct -m matrix.h5 --filterThreshold -1.5 5 -o matrix_corrected.h5
```

### 5. Structural Analysis
Once normalized, use specialized tools to find domains or compartments.

*   **TAD Detection**: `hicFindTADs --matrix matrix_corrected.h5 --outPrefix TADs --numberOfProcessors max`
*   **A/B Compartments**: `hicPCA --matrix matrix_corrected.h5 --outputFileName pca1.bw pca2.bw`

## Best Practices
- **Local Alignment**: Always use `--local` in your aligner (Bowtie2/BWA) to handle chimeric reads containing ligation junctions.
- **Format Conversion**: HiCExplorer supports multiple formats. Use `hicConvertFormat` to move between `.h5`, `.cool`, and `.mcool` for compatibility with other tools like Juicebox or HiGlass.
- **Quality Control**: Inspect the output of `--outBam` in `hicBuildMatrix`. High-quality libraries should show a distinct enrichment of reads near restriction sites.
- **Micro-C Support**: For Micro-C data, use `hicBuildMatrixMicroC` (available in version 3.7.6+) which is optimized for nucleosome-resolution data without specific restriction site requirements.

## Reference documentation
- [HiCExplorer GitHub Repository](./references/github_com_deeptools_HiCExplorer.md)
- [HiCExplorer Wiki/Tutorial](./references/github_com_deeptools_HiCExplorer_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hicexplorer_overview.md)