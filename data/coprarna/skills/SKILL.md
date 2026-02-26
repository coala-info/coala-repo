---
name: coprarna
description: CopraRNA predicts regulatory targets of bacterial small RNAs by integrating comparative genomic data from multiple homologous sequences. Use when user asks to predict sRNA targets, identify bacterial small RNA interactions, or perform comparative target prediction across multiple organisms.
homepage: https://github.com/PatrickRWright/CopraRNA
---


# coprarna

## Overview
CopraRNA (Comparative Prediction of sRNA Targets) is a specialized bioinformatics tool that identifies potential regulatory targets of bacterial small RNAs. It works by combining individual whole-genome target predictions from IntaRNA across multiple homologous sRNA sequences. This comparative approach leverages evolutionary conservation to filter out false positives and highlight biologically relevant interactions.

## Usage Guidelines

### Input Requirements
*   **Homologs**: You must provide at least 3 homologous sRNA sequences from distinct organisms.
*   **FASTA Format**: Input sequences must be in FASTA format.
*   **RefSeq IDs**: The headers in your FASTA file must use exact NCBI Reference Sequence identifiers (e.g., `NC_000913` or `NZ_CP006698`). CopraRNA uses these IDs to fetch the corresponding genomic context.

### Basic Command Pattern
The primary executable is `CopraRNA2.pl`. A standard execution looks like this:

```bash
CopraRNA2.pl -srnaseq sRNAs.fa -region 5utr -ntup 200 -ntdown 100 -cores 4
```

### Key Parameters
*   `-region`: Defines the search space relative to the gene.
    *   `5utr`: Scans around the start codon (default).
    *   `3utr`: Scans around the stop codon.
    *   `cds`: Scans the entire transcript.
*   `-ntup` / `-ntdown`: Sets the number of nucleotides to include upstream and downstream of the chosen region.
*   `-cores`: Specifies the number of CPU cores for parallel processing. Given that CopraRNA runs multiple IntaRNA instances, increasing this is highly recommended for speed.
*   `-cons`: Controls consensus prediction.
    *   `0`: Off (default).
    *   `1`: Organism of interest based consensus.
    *   `2`: Overall consensus based prediction.

### Expert Tips and Best Practices
*   **Dedicated Directory**: Always run CopraRNA in a fresh, empty directory. The tool generates a large number of intermediate files and performs heavy I/O; running in a cluttered space can lead to unexpected behavior or file overwrites.
*   **Resource Allocation**: Ensure the system has at least 8 GB of RAM. For large genomes or many homologs, memory usage can spike during the aggregation phase.
*   **Execution Time**: Be prepared for long runtimes. Depending on the sRNA length and the number of organisms, a single prediction can take anywhere from a few hours to over 24 hours.
*   **RefSeq Compatibility**: If the tool fails to find an organism, verify that the RefSeq ID is current and present in the NCBI database. CopraRNA relies on these IDs to retrieve annotation and sequence data.

## Reference documentation
- [CopraRNA GitHub Repository](./references/github_com_PatrickRWright_CopraRNA.md)
- [CopraRNA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_coprarna_overview.md)