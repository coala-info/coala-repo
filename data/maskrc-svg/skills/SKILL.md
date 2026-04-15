---
name: maskrc-svg
description: maskrc-svg masks recombinant regions in bacterial multi-FASTA alignments using ClonalFrameML or Gubbins output and generates SVG visualizations of recombination events. Use when user asks to mask recombination in genomic alignments, visualize recombination hotspots, or create SVG maps of horizontal gene transfer.
homepage: https://github.com/kwongj/maskrc-svg
metadata:
  docker_image: "quay.io/biocontainers/maskrc-svg:0.5--0"
---

# maskrc-svg

## Overview
maskrc-svg is a specialized tool for bacterial genomics that cleans multi-FASTA alignments by masking regions identified as recombinant. Recombination can distort phylogenetic signals; this tool uses the positional data from ClonalFrameML or Gubbins to replace these regions with a masking character (like '?' or 'N'). Beyond masking, it provides a visual representation of recombination hotspots and distribution across different taxa via SVG output, allowing for a quick qualitative assessment of horizontal gene transfer within a dataset.

## Installation and Setup
The tool is available via Bioconda. Ensure your environment has the necessary dependencies (BioPython, ete3, bcbio-gff, and svgwrite).

```bash
conda install bioconda::maskrc-svg
```

## Common CLI Patterns

### Masking ClonalFrameML Output
To mask an alignment based on ClonalFrameML results, provide the prefix used during the ClonalFrameML run and the original alignment file.
```bash
maskrc-svg.py --aln input_alignment.fasta --out masked_output.aln cfml_results_prefix
```

### Masking Gubbins Output
When working with Gubbins, you must include the `--gubbins` flag.
```bash
maskrc-svg.py --gubbins --aln input_alignment.fasta --out masked_output.aln gubbins_results_prefix
```

### Generating Visualizations
To create an SVG map of recombination events, use the `--svg` flag. Adding `--consensus` helps identify recombination hotspots across the entire population.
```bash
maskrc-svg.py --aln input.fasta --svg recombination_map.svg --consensus cfml_prefix
```

## Expert Tips and Best Practices

*   **Masking Characters**: By default, the tool uses `?`. If your downstream phylogenetic software (like RAxML or IQ-TREE) or specific scripts prefer `N` or `-`, use the `--symbol` flag:
    ```bash
    maskrc-svg.py --aln input.fasta --symbol N cfml_prefix
    ```
*   **Coordinate Auditing**: Always use the `--regions` flag to output a tab-separated file of the masked coordinates. This is crucial for reproducibility and for verifying the extent of data loss due to masking.
*   **SVG Customization**:
    *   **Ordering**: Use `--svgorder taxa_list.txt` (one taxon per line) to match the SVG rows to the order of a phylogenetic tree for better visual correlation.
    *   **Color Coding**: Use `--svgcolour` with a HEX code (e.g., `#FF0000` for red) to highlight extant recombination. Note that ancestral recombination is automatically rendered in grey.
    *   **Sizing**: For large datasets with many taxa, increase the height in `--svgsize` (default 800x600) to prevent row compression.
*   **Input Consistency**: Ensure the `--aln` file is the exact same multi-FASTA alignment used as input for the recombination detection tool (ClonalFrameML/Gubbins) to avoid coordinate shifts.

## Reference documentation
- [maskrc-svg README](./references/github_com_kwongj_maskrc-svg_blob_master_README.md)
- [Bioconda maskrc-svg Overview](./references/anaconda_org_channels_bioconda_packages_maskrc-svg_overview.md)