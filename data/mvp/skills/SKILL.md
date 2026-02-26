---
name: mvp
description: The Motif-Variant Probe quantifies the impact of sequence variation on functional motifs by identifying the gain or loss of specific binding sites. Use when user asks to analyze the functional impact of variants on motifs, determine if mutations disrupt or create binding sites, or prioritize non-coding variants based on motif changes.
homepage: https://gitlab.com/LPCDRP/motif-variants
---


# mvp

## Overview
The Motif-Variant Probe (mvp) is a specialized genomic tool used to quantify the impact of sequence variation on functional motifs. While standard variant calling identifies changes in the sequence, `mvp` determines if those changes specifically gain or loss functional sites. It is essential for epigenomics and regulatory genomics workflows where the biological consequence of a SNP or Indel is tied to the disruption or creation of a specific binding site or recognition sequence.

## Usage Guidelines

### Core Workflow
To use `mvp` effectively, you must provide three primary inputs:
1.  **Variants**: A VCF file containing the mutations to be analyzed.
2.  **Reference**: The corresponding reference genome/sequence.
3.  **Motifs**: A set of motifs (patterns) to search for.

### Command Line Interface
The basic execution pattern follows this structure:
```bash
mvp [options] --vcf <variants.vcf> --ref <reference.fa> --motifs <motifs.txt>
```

### Best Practices
- **Sequence Types**: `mvp` supports both nucleotide and amino acid sequences. Ensure your motif list matches the alphabet of your reference sequence.
- **Motif Definition**: Define motifs clearly in your input file. The tool identifies changes in the *count* of these occurrences per variant.
- **Functional Impact**: Use the output to filter variants that specifically disrupt known transcription factor binding sites (TFBS) or methylation sites, rather than just looking at proximity to genes.

### Expert Tips
- **Input Validation**: Ensure your VCF chromosome naming matches your reference FASTA (e.g., "chr1" vs "1") to avoid empty results.
- **Bioconda Installation**: The most reliable way to deploy `mvp` is via Bioconda: `conda install bioconda::mvp`.
- **Downstream Analysis**: The output is particularly useful for prioritizing non-coding variants in GWAS hits by identifying those that break or create regulatory motifs.

## Reference documentation
- [mvp Overview](./references/anaconda_org_channels_bioconda_packages_mvp_overview.md)
- [mvp Project Repository](./references/gitlab_com_LPCDRP_mvp.md)