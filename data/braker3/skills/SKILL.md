---
name: braker3
description: BRAKER3 is the most advanced iteration of the BRAKER suite, designed to provide high-accuracy gene predictions by combining the strengths of GeneMark-ETP and AUGUSTUS.
homepage: https://github.com/Gaius-Augustus/BRAKER
---

# braker3

## Overview
BRAKER3 is the most advanced iteration of the BRAKER suite, designed to provide high-accuracy gene predictions by combining the strengths of GeneMark-ETP and AUGUSTUS. It is particularly effective when both RNA-seq data (as BAM files) and protein data (as FASTA files) are available. The pipeline automates the training of these tools and produces a consensus gene set supported by strong extrinsic evidence.

## Core CLI Usage

The pipeline is executed via the `braker.pl` script.

### Standard BRAKER3 Run (RNA-seq + Protein)
```bash
braker.pl --genome=genome.fa --bam=rnaseq.bam --prot_seq=proteins.fa --threads=8
```

### Fungal Genomes
Use the `--fungus` flag to adjust parameters for fungal gene density and structure.
```bash
braker.pl --genome=genome.fa --bam=rnaseq.bam --prot_seq=proteins.fa --fungus
```

### Using BUSCO for Training
To improve training quality, specify a BUSCO lineage.
```bash
braker.pl --genome=genome.fa --bam=rnaseq.bam --prot_seq=proteins.fa --busco_lineage=metazoa_odb10
```

## Expert Tips and Best Practices

### Genome Preparation
*   **Softmasking**: Always use softmasked genomes (repeats in lowercase, nucleotides in uppercase). BRAKER handles softmasking better than hardmasking (N's), which can disrupt gene structures.
*   **Scaffold Names**: Ensure scaffold names are simple (e.g., `>contig1`). Avoid special characters, spaces, or long descriptions in the FASTA headers, as these often cause failures in the underlying alignment tools.
*   **Assembly Quality**: Remove very short scaffolds/contigs before running. A high number of small fragments increases runtime significantly without improving prediction accuracy.

### Input Consistency
*   The scaffold names in your genome FASTA must exactly match the reference names in your BAM files and any other extrinsic evidence files.

### Resource Management
*   **Threads**: Use the `--threads` option to parallelize the run. GeneMark and AUGUSTUS training are computationally intensive.
*   **Existing Results**: If a run is interrupted, use `--useexisting` to attempt to skip steps that have already completed successfully.

### Output Interpretation
*   The primary output is `braker.gtf`, which contains the combined gene set from both GeneMark-ETP and AUGUSTUS, filtered for high extrinsic support.

## Reference documentation
- [BRAKER User Guide](./references/github_com_Gaius-Augustus_BRAKER.md)
- [BRAKER Wiki](./references/github_com_Gaius-Augustus_BRAKER_wiki.md)
- [BRAKER3 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_braker3_overview.md)