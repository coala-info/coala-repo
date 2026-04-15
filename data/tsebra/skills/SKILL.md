---
name: tsebra
description: TSEBRA refines genome annotations by selecting the most plausible transcripts from multiple gene predictions using extrinsic evidence. Use when user asks to refine genome annotations, combine gene predictions from multiple sources, improve gene set completeness, or manage gene isoforms.
homepage: https://github.com/Gaius-Augustus/TSEBRA
metadata:
  docker_image: "quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0"
---

# tsebra

## Overview
TSEBRA (Transcript Selector for BRAKER) is a bioinformatics tool used to refine genome annotations. It acts as a selector that compares various gene predictions against extrinsic evidence—such as RNA-seq data or protein homology—to identify the most biologically plausible transcripts. Its primary strength lies in its ability to combine the outputs of different BRAKER pipelines (e.g., BRAKER1 and BRAKER2) to produce a consensus gene set that is more accurate than any single input.

## Usage Instructions

### Basic Command Pattern
The core script is `tsebra.py`. It requires gene predictions in GTF format and hint files in GFF format.

```bash
tsebra.py -g predictions1.gtf,predictions2.gtf -e hints1.gff,hints2.gff -c default.cfg -o filtered_output.gtf
```

### Input Requirements
- **Gene Predictions (-g)**: Standard GTF format (standard output from AUGUSTUS or BRAKER). Multiple files must be comma-separated.
- **Hint Files (-e)**: GFF format. Must include the `src=` attribute in the last column to identify the evidence source (e.g., `src=E` for RNA-seq, `src=P` for protein).
- **Configuration (-c)**: A text file defining weights and thresholds.

### Configuration Best Practices
The configuration file controls how TSEBRA weights different evidence. Adjust these parameters based on your data quality:

1.  **Weights**: Increase the weight for your most reliable evidence source. If your protein database is from a distantly related species, increase the weight for RNA-seq hints (`E`).
2.  **Support Thresholds**:
    *   `intron_support`: Default is 0.8. If TSEBRA is being too aggressive and removing valid genes, lower this to 0.2.
    *   `stasto_support`: Controls required support for start/stop codons.
3.  **Overlap Rules (e_1 to e_6)**: These parameters (range 0-2) determine how strictly TSEBRA filters overlapping transcripts. Increasing these values will result in more transcripts being kept, including more alternative isoforms.

### Common Workflows
- **Combining BRAKER Runs**: The most common use case is merging `augustus.hints.gtf` from a BRAKER1 run (RNA-seq) and a BRAKER2 run (Protein).
- **Improving BUSCO Scores**: Use the `best_by_compleasm.py` script to re-run TSEBRA with parameters optimized to maximize the presence of Benchmarking Universal Single-Copy Orthologs (BUSCOs) in the final output.
- **Isoform Management**: Use `get_longest_isoform.py` if you require a simplified gene set with only one representative transcript per locus.

### Expert Tips
- **Format Consistency**: Ensure your GTF files use consistent `transcript_id` and `gene_id` attributes. TSEBRA relies on these for internal scoring.
- **Softmasking**: For best results, ensure the genome used for the initial predictions was properly repeat-masked, as this improves the quality of the input hints.
- **Evidence Sources**:
    *   `E`: RNA-seq hints.
    *   `C`: High-score protein hints.
    *   `P`: Lower-score protein hints.
    *   `M`: Manual/Enforced hints.

## Reference documentation
- [TSEBRA Main Documentation](./references/github_com_Gaius-Augustus_TSEBRA.md)
- [TSEBRA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tsebra_overview.md)