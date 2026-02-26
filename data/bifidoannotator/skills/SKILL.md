---
name: bifidoannotator
description: Bifidoannotator provides hierarchical functional annotation and classification of glycoside hydrolases specifically for bifidobacterial genomes. Use when user asks to annotate protein sequences, classify enzymes into functional clusters, or generate comparative heatmaps of bifidobacterial metabolic capabilities.
homepage: https://github.com/nicholaspucci/bifidoAnnotator
---


# bifidoannotator

## Overview
The `bifidoannotator` tool is a specialized bioinformatics pipeline designed to provide fine-grained, hierarchical annotation of bifidobacterial glycoside hydrolases (GHs). While general tools often stop at broad GH family assignments, this tool uses a manually curated database of over 22,000 reference sequences to classify enzymes into 122 functional protein clusters. It is particularly useful for researchers studying infant gut microbiomes and the specific metabolic capabilities of *Bifidobacterium* species regarding human milk oligosaccharides.

## Core CLI Usage

### Single Genome Analysis
For a quick analysis of a single protein FASTA file:
```bash
bifidoAnnotator -i input_genome.faa -o output_directory
```

### Batch Processing
When analyzing multiple genomes, provide a directory and a text file listing the samples:
```bash
bifidoAnnotator -d /path/to/genomes/ -s sample_list.txt -o batch_results
```
*Note: The sample list should contain one genome name per line, matching the filenames in the directory (excluding extensions).*

### Enhanced Visualizations
To generate heatmaps with species names or isolation sources instead of just genome IDs, provide a metadata file:
```bash
bifidoAnnotator -i genome.faa --annotations_file metadata.tsv -o results
```

## Expert Tips and Best Practices

### Input Requirements
- **Sequence Type**: Ensure input files contain **amino acid sequences** (Protein FASTA). The tool is not designed for raw nucleotide reads or contigs.
- **Metadata Format**: The `--annotations_file` should be a TSV. The first column must match the genome names used in your analysis.

### Performance Tuning
- **Threading**: Use `--threads` to match your available CPU cores (default is 4).
- **Sensitivity**: The default MMseqs2 sensitivity is 7.5. If you are working with highly divergent or novel bifidobacterial species, you may want to increase this, though it will impact runtime.

### Customizing Publication Graphics
The tool generates both PNG and PDF heatmaps. If the default labels overlap or the image is too cramped:
- **GH Heatmap**: Use `--gh-figsize 16 20` (Width Height).
- **Cluster Heatmap**: Use `--cluster-figsize 18 22`.
- **Enzyme Heatmap**: Use `--enzyme-figsize 18 22`.
- **Color Schemes**: Toggle between 'blue' (default) and 'red' using `-hc red`.

### Quality Control Thresholds
The pipeline applies strict internal filters:
- **Coverage**: Minimum 50% alignment coverage.
- **Bit Score**: Minimum 200.
- **Identity**: Uses reference-specific identity thresholds defined in the internal mapping file to distinguish between closely related clusters.

## Output Interpretation
- **detailed_annotations.tsv**: The primary source for per-protein assignments.
- **matrix files**: Use the `gh_family_matrix.tsv` or `cluster_matrix.tsv` for direct input into R (e.g., phyloseq or vegan) for comparative genomics.
- **HMG-utilization**: Check the mapping results for the "HMG-utilization" status to quickly identify if a specific cluster is known to be involved in milk glycan breakdown.

## Reference documentation
- [github_com_nicholaspucci_bifidoAnnotator.md](./references/github_com_nicholaspucci_bifidoAnnotator.md)
- [anaconda_org_channels_bioconda_packages_bifidoannotator_overview.md](./references/anaconda_org_channels_bioconda_packages_bifidoannotator_overview.md)