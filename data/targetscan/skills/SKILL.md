---
name: targetscan
description: TargetScan predicts microRNA targets by identifying complementary sites between miRNA seed regions and mRNA sequences. Use when user asks to predict microRNA targets, rank potential biological targets based on biochemical efficacy, or calculate the probability of conserved targeting.
homepage: https://www.targetscan.org/vert_80/
---


# targetscan

## Overview
TargetScan is a specialized tool for the computational prediction of microRNA targets. It identifies regulatory sites by searching for complementarity between the miRNA seed region and mRNA 3' UTRs. This skill provides guidance on utilizing the TargetScan algorithm to rank potential biological targets based on biochemical efficacy (Context++ scores) and the probability of conserved targeting (PCT). It is essential for researchers performing functional genomics, transcriptomics, or molecular biology studies involving post-transcriptional gene regulation.

## Command Line Usage
The `targetscan` package (available via Bioconda) is typically used for large-scale, custom genomic analyses that exceed the capabilities of the web interface.

### Basic Execution
To run a target prediction analysis, you generally require two primary input files: a miRNA file (containing seed sequences) and a UTR file (containing the sequences to be searched).

```bash
targetscan_70.pl miRNA_file.txt UTR_sequences.txt output_file.txt
```

### Input File Formats
*   **miRNA File**: A tab-delimited file.
    *   Column 1: miRNA family name.
    *   Column 2: Seed sequence (nucleotides 2-8).
    *   Column 3: Species ID (Taxonomy ID).
*   **UTR File**: A tab-delimited file.
    *   Column 1: Gene/Transcript ID.
    *   Column 2: Species ID.
    *   Column 3: UTR sequence (gapped or ungapped depending on conservation analysis).

## Best Practices and Expert Tips
*   **Species Selection**: When working with mammals, use the default biochemical model (Release 8.0+) which incorporates convolutional neural networks to predict repression efficacy.
*   **Site Types**: Prioritize **8mer** and **7mer-m8** sites, as these typically show higher efficacy than 7mer-A1 or 6mer sites.
*   **Context++ Scores**: Always use the cumulative weighted context++ scores to rank targets. A more negative score indicates higher predicted repression efficacy.
*   **Conservation (PCT)**: Use the Probability of Conserved Targeting (PCT) to filter out noise. Sites with high PCT are more likely to be biologically relevant across different species (e.g., human, mouse, rat).
*   **ORF Targeting**: While TargetScan primarily focuses on 3' UTRs, remember that functional targeting can occur in Open Reading Frames (ORFs), though usually with lower efficacy.
*   **Distance from Stop Codon**: Be cautious of sites located within 15 nucleotides of the stop codon, as these are often ineffective due to interference from the translation machinery.

## Reference documentation
- [TargetScan Overview](./references/anaconda_org_channels_bioconda_packages_targetscan_overview.md)
- [TargetScan 8.0 Guide](./references/www_targetscan_org_vert_80.md)
- [TargetScan Help and Documentation](./references/www_targetscan_org_vert_80_docs_help.html.md)