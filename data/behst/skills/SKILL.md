---
name: behst
description: BEHST performs genomic set enrichment analysis by integrating chromatin long-range interactions with gene regulatory regions. Use when user asks to identify enriched Gene Ontology terms based on input chromosome regions and Hi-C data, specifically focusing on regulatory regions of APPRIS genes.
homepage: https://bitbucket.org/hoffmanlab/behst/overview
metadata:
  docker_image: "quay.io/biocontainers/behst:3.8--0"
---

# behst

yaml
name: behst
description: Performs genomic set enrichment analysis by integrating chromatin long-range interactions with gene regulatory regions. Use when you need to identify enriched Gene Ontology terms based on input chromosome regions and Hi-C data, specifically focusing on regulatory regions of APPRIS genes.
```

## Overview
BEHST is a bioinformatics tool designed for advanced genomic analysis. It takes a set of chromosome regions as input and intersects them with Hi-C data to identify chromatin interactions. It then filters these regions to include only those within the regulatory areas of genes annotated by APPRIS. Finally, BEHST uses these identified genes to perform a gene set enrichment analysis via g:Profiler, outputting the most significant Gene Ontology terms. This is particularly useful for understanding the functional implications of genomic regions in the context of gene regulation and long-range chromatin interactions.

## Usage Instructions

BEHST operates via the command line. The core functionality involves providing an input file of chromosome regions and a Hi-C interaction dataset.

### Basic Usage

The fundamental command structure is:

```bash
behst -i <input_regions.bed> -c <hic_interactions.bed> -o <output_prefix>
```

- `-i <input_regions.bed>`: Specifies the input file containing chromosome regions. This file should be in BED format.
- `-c <hic_interactions.bed>`: Specifies the Hi-C interaction file. This file should also be in BED format, representing long-range chromatin interactions.
- `-o <output_prefix>`: Sets a prefix for the output files. BEHST will generate several output files, all starting with this prefix.

### Key Options and Parameters

While the basic usage covers the core functionality, BEHST offers several parameters to refine the analysis.

*   **Defining Regulatory Regions:**
    BEHST defines cis-regulatory regions based on the position of the nearest transcription start site (TSS) of APPRIS genes' principal transcripts, plus an upstream and downstream extension. The default extension is often sufficient, but understanding this mechanism is key to interpreting results.

*   **Gene Set Enrichment Analysis (g:Profiler):**
    The tool leverages g:Profiler for enrichment analysis. The output will include lists of significant Gene Ontology (GO) terms.

### Input File Formats

*   **Chromosome Regions (`-i`):** Standard BED format (chromosome, start, end).
*   **Hi-C Interactions (`-c`):** Standard BED format, representing pairs of interacting genomic loci.

### Output Files

The output prefix specified with `-o` will be used for all generated files. These typically include:
*   Files detailing the intersected regions.
*   Files listing genes found in regulatory regions.
*   The primary output containing the enriched GO terms and associated statistics.

### Expert Tips

*   **Data Quality:** Ensure your input BED files for regions and Hi-C interactions are properly formatted and accurately represent your genomic data. Errors in input format can lead to unexpected results or tool failure.
*   **Interpreting Results:** The output GO terms provide insights into the biological functions associated with the input regions and their interacting partners. Correlate these terms with known biological pathways relevant to your research.
*   **Parameter Tuning:** While not extensively documented for CLI, be aware that the upstream/downstream extension for defining regulatory regions can be a critical parameter if you need to adjust the definition of a gene's regulatory neighborhood. Consult the BEHST website for potential advanced configuration options if available.

## Reference documentation
- [BEHST Overview](https://behst.hoffmanlab.org/)