---
name: ctat-lncrna
description: CTAT-lncRNA is a specialized utility within the Trinity Cancer Transcriptome Analysis Toolkit (CTAT) ecosystem.
homepage: https://github.com/NCIP/ctat-lncrna
---

# ctat-lncrna

## Overview
CTAT-lncRNA is a specialized utility within the Trinity Cancer Transcriptome Analysis Toolkit (CTAT) ecosystem. It automates the identification of novel lncRNAs from RNA-Seq data. By integrating the `slncky` toolset, it distinguishes between coding and non-coding transcripts through comparative genomics and coding potential assessment. Use this skill to guide the execution of lncRNA discovery workflows, ensuring proper input formatting and parameter selection for high-confidence non-coding transcript identification.

## Usage Guidelines

### Core Workflow
The tool typically requires a set of candidate transcripts (GTF format) and a reference genome. The primary objective is to filter out transcripts that show evidence of protein-coding potential or match known protein-coding genes.

### Common CLI Patterns
While specific flags may vary by version, the standard execution follows this pattern:
- **Input**: A GTF file containing reconstructed transcripts (e.g., from StringTie or Trinity/Cufflinks).
- **Reference Data**: Requires a CTAT genome resource bundle or specific slncky-formatted reference databases.
- **Command Structure**:
  ```bash
  ctat-lncrna --transcripts <transcripts.gtf> --genome_lib_dir <CTAT_GENOME_LIB> [options]
  ```

### Best Practices
- **Input Quality**: Ensure the input GTF has been properly merged if coming from multiple samples to provide a comprehensive transcript set.
- **Genome Resources**: Always use the matching CTAT Genome Resource Bundle (GRCh37 or GRCh38) to ensure chromosome naming consistency and annotation accuracy.
- **Filtering Logic**: CTAT-lncRNA uses `slncky` to perform:
    1. **Coding Potential Filtering**: Removing transcripts with significant ORFs or HMMER hits to Pfam.
    2. **Orthology Analysis**: Identifying conserved lncRNAs across species.
- **Output Interpretation**: Focus on the `*.lncRNA.gtf` output for downstream analysis, which contains the high-confidence novel lncRNA candidates.

### Expert Tips
- **Memory Management**: For large transcriptomes, ensure sufficient memory is allocated for the alignment steps (BLAST/Lastz) performed internally by the slncky component.
- **Novelty Check**: The tool is most effective when used on "novel" transcripts that do not overlap with existing GENCODE/Ensembl annotations.

## Reference documentation
- [ctat-lncrna Overview](./references/anaconda_org_channels_bioconda_packages_ctat-lncrna_overview.md)