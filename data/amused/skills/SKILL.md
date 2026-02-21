---
name: amused
description: AMUSED (Auditing Motifs Using Statistical Enrichment & Depletion) is a specialized tool for discovering DNA motifs by analyzing the frequency of k-mers within sequence data.
homepage: https://github.com/Carldeboer/AMUSED
---

# amused

## Overview
AMUSED (Auditing Motifs Using Statistical Enrichment & Depletion) is a specialized tool for discovering DNA motifs by analyzing the frequency of k-mers within sequence data. It excels at identifying both enriched and depleted motifs, with specific support for gapped k-mers—a feature often missing in standard k-mer counters. Use this skill to guide the execution of AMUSED for transcription factor binding site discovery, regulatory element analysis, or any task requiring statistical validation of sequence patterns against a background model.

## CLI Usage and Best Practices

### Core Command Patterns
The primary executable is `AMUSED`. Basic execution requires a query file and an output path.

*   **Standard Enrichment Analysis**:
    `AMUSED -q query.fasta -o results.txt`
*   **Background-Corrected Analysis**:
    `AMUSED -q query.fasta -b background.fasta -o results.txt`
*   **Double-Stranded Scan**:
    Use this when the orientation of the motif is unknown or irrelevant (e.g., most TF binding sites).
    `AMUSED -q query.fasta -o results.txt -ds`
*   **Compressed Output**:
    AMUSED automatically handles gzip compression if the file extension is provided.
    `AMUSED -q query.fasta -o results.txt.gz`

### Parameter Optimization
*   **K-mer Size (`-s`)**: The default is 8. While AMUSED can handle larger k-mers, the gap-addition step becomes computationally expensive as $k$ increases. It is recommended to keep $k < 10$.
*   **Thread Count (`-t`)**: AMUSED supports multi-threading primarily during the scanning phase. Increasing threads is most beneficial when using a large background file.
*   **Significance Filtering (`-z`)**: To reduce output noise and file size, set a minimum absolute Sub-Z-score. Only motifs exceeding this threshold will be reported.
*   **Input Formatting (`-1p`)**: If your input file contains one sequence per line without FASTA headers, you must include the `-1p` flag.

### Expert Tips
*   **Handling Masked Sequences**: If your sequences use lowercase letters for repeat masking and you wish to ignore them, use the `-nu` flag to prevent the tool from converting them to uppercase before scanning.
*   **Ungapped Analysis**: If you only care about contiguous k-mers, use `-ng` to disable gap insertion. This significantly speeds up the processing time.
*   **Super-Z Scores**: By default, AMUSED calculates Super-Z scores using $(k+1)$-mers. If you only need basic enrichment statistics and want to save time, disable this with `-nsz`.
*   **Base Content**: Use `-bc` to include A/T/G/C frequencies in the output, which is useful for checking if enrichment is simply a byproduct of high GC content.

## Reference documentation
- [AMUSED Overview](./references/anaconda_org_channels_bioconda_packages_amused_overview.md)
- [AMUSED GitHub Repository and Usage](./references/github_com_Carldeboer_AMUSED.md)