---
name: dnamarkmaker
description: DNAMarkMaker is a specialized bioinformatics pipeline designed to bridge the gap between Next-Generation Sequencing (NGS) data and laboratory-ready molecular markers.
homepage: https://github.com/SegawaTenta/DNAMarkMaker-CUI
---

# dnamarkmaker

## Overview
DNAMarkMaker is a specialized bioinformatics pipeline designed to bridge the gap between Next-Generation Sequencing (NGS) data and laboratory-ready molecular markers. It automates the identification of SNPs from alignment files and subsequently designs primers for Amplification Refractory Mutation System (ARMS) and Cleaved Amplified Polymorphic Sequence (CAPS) markers. This skill enables efficient marker development for various genomic states, including homozygous, heterozygous, and autotetraploid populations.

## Core Workflow and CLI Patterns

The tool operates through five distinct modules invoked by the `-w` (workflow) option. The standard progression begins with SNP selection, followed by primer preparation, and concludes with specific marker design.

### 1. Target SNP Selection
This is the mandatory first step to identify polymorphisms between two samples (A and B).

```bash
DNAMarkMaker -w target_SNP_selection \
  -reference /path/to/ref.fasta \
  -Abam /path/to/sampleA.bam \
  -Bbam /path/to/sampleB.bam \
  -position chr1:10000:50000 \
  -o output_dir
```

**Expert Tips for SNP Selection:**
*   **Ploidy Handling:** For autotetraploid plants (e.g., targeting simplex SNPs in B), use `-Bhetero yes` and provide a simulation file with `-Bsim`.
*   **Quality Control:** Adjust `-min_depth` (default 10) and `-minBQ` (default 13) to filter out low-confidence variants in noisy NGS data.
*   **Three-way Comparison:** Use `-Cbam` to include a third sample (e.g., an F1 hybrid) to validate that identified SNPs are correctly inherited.

### 2. ARMS Preparation
Before generating ARMS markers, you must run the preparation command to design the initial breed-specific primer candidates.

```bash
DNAMarkMaker -w ARMS_preparation -o output_dir
```
*   **Customization:** Use `-recipe` to provide a custom Primer3 configuration file if standard melting temperatures or GC content constraints are insufficient for your species.

### 3. Marker Design (ARMS and CAPS)
Once preparation is complete, choose the specific marker type required for your lab assay.

*   **Tri-ARMS (3 primers):**
    ```bash
    DNAMarkMaker -w tri_ARMS -o output_dir -PCR_min_size 100 -PCR_max_size 700
    ```
*   **Tetra-ARMS (4 primers):**
    ```bash
    DNAMarkMaker -w tetra_ARMS -o output_dir -first_size 100:500 -second_size 600:1000
    ```
*   **CAPS (Restriction-based):**
    ```bash
    DNAMarkMaker -w CAPS -o output_dir -restriction_enzyme enzymes.txt
    ```

## Best Practices and Troubleshooting

*   **Environment Setup:** Always ensure Python 3.9.13 or later is active. If using Conda, it is recommended to create a dedicated environment: `conda create -n DNAMarkMaker python=3.9.13 dnamarkmaker -c bioconda`.
*   **Input Requirements:**
    *   BAM files must be sorted and have corresponding `.bai` index files in the same directory.
    *   The `restriction_enzyme.txt` file for CAPS must contain space-separated enzyme names and their recognition sequences.
*   **Output Interpretation:** The tool generates HTML reports by default (`-make_html yes`). These are the most efficient way to visualize primer positions and expected band sizes for laboratory validation.
*   **Band Size Optimization:** For Tetra-ARMS, ensure the `-first_size` and `-second_size` ranges do not overlap significantly to allow for clear gel electrophoresis resolution.

## Reference documentation
- [DNAMarkMaker-CUI Main Documentation](./references/github_com_SegawaTenta_DNAMarkMaker-CUI.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dnamarkmaker_overview.md)