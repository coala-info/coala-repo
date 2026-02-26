---
name: slncky
description: "slncky is a tool for discovering and analyzing long non-coding RNAs from RNA-Seq data. Use when user asks to discover lncRNAs, find lncRNA orthologs, or assess lncRNA evolutionary conservation."
homepage: https://github.com/slncky/slncky
---


# slncky

yaml
name: slncky
description: |
  A tool for long non-coding RNA (lncRNA) discovery from RNA-Seq data.
  Use when you need to identify, characterize, and analyze lncRNAs,
  including finding orthologs and assessing evolutionary conservation.
  This skill is particularly useful for researchers working with genomic and transcriptomic data.
```
## Overview
slncky is a bioinformatics tool designed for the discovery and analysis of long non-coding RNAs (lncRNAs) from RNA sequencing data. It excels at filtering high-quality noncoding transcripts, identifying lncRNA orthologs across species, and characterizing the evolutionary conservation of these important molecules. This tool is valuable for researchers in genomics and molecular biology who are investigating the roles of lncRNAs in biological processes.

## Usage Instructions

slncky is a command-line tool. The primary workflow involves providing input files and specifying parameters to guide the discovery and analysis process.

### Core Functionality

The main purpose of slncky is to process RNA-Seq data to identify and characterize lncRNAs. This typically involves:

1.  **Filtering transcripts**: Identifying high-quality noncoding transcripts from a given set.
2.  **Discovering orthologs**: Finding corresponding lncRNAs in other species.
3.  **Characterizing conservation**: Assessing how conserved lncRNAs are across different evolutionary lineages.

### Key Dependencies

Ensure the following tools are installed and accessible in your PATH:

*   `bedtools` (version 2.17.0 or greater)
*   `liftOver`
*   `lastz`

### Basic Usage Pattern

While specific command structures can vary based on the exact analysis, a general approach involves specifying input files and output directories.

```bash
# Example: A hypothetical command structure (actual parameters may differ)
slncky --input_transcripts <path_to_transcripts.gtf> --output_dir <output_directory> --genome <genome_fasta>
```

### Important Considerations and Tips

*   **Input Data**: slncky typically requires transcript annotations (e.g., in GTF format) and genome sequences.
*   **Ortholog Discovery**: For ortholog discovery, you will likely need to provide reference genomes and annotations for the species you are comparing.
*   **Conservation Analysis**: This feature relies on comparative genomics tools and databases.
*   **Parameter Tuning**: Explore the available command-line arguments to fine-tune the filtering, ortholog discovery, and conservation analysis based on your specific research question and dataset. Refer to the tool's documentation for a comprehensive list of options.
*   **Error Handling**: Pay attention to the output messages for any warnings or errors, especially those related to dependencies like `bedtools` or `liftOver`.

## Reference documentation
- [slncky Overview](./references/anaconda_org_channels_bioconda_packages_slncky_overview.md)
- [slncky GitHub Repository](./references/github_com_slncky_slncky.md)
- [slncky Commits](./references/github_com_slncky_slncky_commits_master.md)
- [slncky Tags](./references/github_com_slncky_slncky_tags.md)