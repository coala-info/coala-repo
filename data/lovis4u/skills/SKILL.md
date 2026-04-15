---
name: lovis4u
description: LoVis4u is a bioinformatics pipeline that transforms genomic data into high-quality comparative visualizations with homology links and sequencing signal tracks. Use when user asks to visualize genomic loci, compare multiple genomes with homology links, plot sequencing coverage profiles, or perform automated functional annotation of gene clusters.
homepage: https://art-egorov.github.io/lovis4u/
metadata:
  docker_image: "quay.io/biocontainers/lovis4u:0.1.7--pyh7e72e81_0"
---

# lovis4u

## Overview
LoVis4u is a specialized bioinformatics pipeline designed to transform genomic data (GFF3 or Genbank) into high-quality vector graphics. It excels at comparative genomics by automatically clustering proteomes to determine the optimal display order and drawing homology links between related genes. Beyond simple gene maps, it supports the integration of sequencing signal tracks (coverage profiles) and provides automated functional annotation workflows for identifying specialized biological systems like phage defense or antimicrobial resistance.

## Core Workflow and Initialization
Before running analysis, ensure the environment is properly initialized to access default configuration files and HMM models.

- **Initialize Data**: Run `lovis4u --data` to copy the `lovis4u_data` folder (containing configs and palettes) to your working directory.
- **Linux Setup**: If using Linux, you must run `lovis4u --linux` once to update internal paths for MMseqs2.
- **Download HMMs**: For functional annotation, run `lovis4u --get-hmms` to fetch databases for defense systems (DefenseFinder/PADLOC), virulence factors (VFDB), and AMR genes.

## Common CLI Patterns

### Basic Locus Visualization
To generate a standard map from a folder of GFF files (which must include the fasta sequence):
```bash
lovis4u -gff path/to/gff_folder -o output_directory
```

### Comparative Genomics with Homology Links
To compare multiple loci, show homology links, and color-code features by category:
```bash
lovis4u -gff path/to/gff_folder -hl --set-category-colour -c A4p2
```

### Visualizing Sequencing Coverage (Signal Tracks)
To plot bedGraph or bigWig data alongside a genomic locus (Note: coverage tracks are currently supported for single-locus visualizations only):
```bash
lovis4u -gff genome.gff -bg coverage.bedGraph -bgl "WT Coverage" -gc -gc_skew
```

### Automated Alignment and Windowing
- **Auto-align**: Use `-align` to automatically shift loci so they center on a shared conserved protein family.
- **Protein-based Window**: Use `-wp protein_id1 protein_id2` to define the visualization window based on specific flanking proteins across all loci.
- **Coordinate Window**: Use `-w locus_id:start:end:strand` for precise manual cropping.

## Expert Tips and Best Practices

- **Layout Selection**: Use the `-c` flag to match your publication target:
    - `A4p1`: Single-column portrait (90mm width).
    - `A4p2`: Two-column portrait (190mm width).
    - `A4L`: Landscape (240mm width).
- **Label Management**: By default, LoVis4u hides labels for common "hypothetical proteins." Use `--show-all-feature-labels` to override this, or `--show-first-feature-label-for conserved` to label only the first instance of a core gene group.
- **Functional Annotation**: Always include `--run-hmmscan` when analyzing unknown clusters to identify specialized cargo like Defense Systems or Anti-Defense proteins.
- **Reorientation**: If your input sequences are on different strands, use `--reorient_loci` to let the tool automatically flip them to maximize co-orientation of homologous genes.
- **Clustering Control**: If you want to maintain a specific input order rather than the similarity-based dendrogram, use `--clust_loci-off`.

## Reference documentation
- [Example-driven Guide](./references/art-egorov_github_io_lovis4u_ExampleDrivenGuide_cmd_guide.md)
- [Command-line Parameters](./references/art-egorov_github_io_lovis4u_Parameters_cmd_parameters.md)
- [Pipeline Description](./references/art-egorov_github_io_lovis4u_Pipeline_pipeline.md)
- [API Usage Examples](./references/art-egorov_github_io_lovis4u_API_usage_examples.md)