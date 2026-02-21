---
name: savont
description: Savont is a specialized bioinformatics tool designed for high-accuracy long-read amplicon sequencing data (>98% accuracy).
homepage: https://github.com/bluenote-1577/savont
---

# savont

## Overview
Savont is a specialized bioinformatics tool designed for high-accuracy long-read amplicon sequencing data (>98% accuracy). Unlike mapping-based approaches, Savont follows a "Reads -> ASV -> Classification" paradigm, providing high-resolution taxonomic profiles. It is particularly effective for researchers using ONT R10.4 (with SUP basecalling) or PacBio HiFi reads who require confident species-level classifications and better interpretability for downstream community analysis.

## Installation
Install via Bioconda for the most stable environment:
```bash
conda install -c bioconda savont
```

## Core Workflows

### 1. ASV Generation
The primary step is converting raw reads into high-quality ASVs.

*   **Standard 16S Full-Length:**
    ```bash
    savont asv input_reads.fastq.gz -o savont_output -t 20
    ```
*   **Full Bacterial rRNA Operons:**
    Use the `--rrna-operon` flag to adjust for the longer sequence length and complexity.
    ```bash
    savont asv operon_reads.fastq.gz -o savont_output -t 20 --rrna-operon
    ```
*   **Custom Amplicon Lengths:**
    If working with non-standard amplicons, manually define the expected range:
    ```bash
    savont asv amplicons.fq.gz -o output --min-read-length 1600 --max-read-length 2100
    ```

### 2. Database Preparation
Before classification, download the required reference database.
*   **EMU (Focused species classification):** `savont download --location databases --emu-db`
*   **SILVA (Broad coverage):** `savont download --location databases --silva-db`

### 3. Taxonomic Classification
Classify the generated ASVs against your chosen database.
```bash
# Using EMU database
savont classify -i savont_output -o class_results --emu-db databases/emu_default -t 20

# Using SILVA database
savont classify -i savont_output -o class_results --silva-db databases/silva_db -t 20
```

## Expert Tips and Best Practices

*   **Read Quality Requirement:** Savont is optimized for reads with >98% accuracy. Do not use R9.4 ONT data or HAC/FAST base-called data, as the error rates are too high for reliable ASV generation.
*   **Single-Stranded Protocols:** If your library preparation is single-stranded, you must include the `--single-strand` flag during the `asv` step to ensure correct clustering.
*   **Threshold Tuning:** You can refine classification sensitivity using `--species-threshold` (default is often 99.9 for EMU) and `--genus-threshold`.
*   **Quality Control:** Always inspect `asv_mappings.tsv` in the classification output. 
    *   Check the `depth` column; ASVs with <20 reads may be artifacts or extremely rare taxa.
    *   Review `alignment_identity` to ensure your ASVs match the reference database closely.
*   **Intermediate Files:** If a run fails or you need to debug, check the `temp/` directory created during the `asv` command for intermediate clustering and polishing files.

## Reference documentation
- [Savont GitHub Repository](./references/github_com_bluenote-1577_savont.md)
- [Savont Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_savont_overview.md)