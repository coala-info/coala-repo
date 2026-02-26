# bifidoannotator CWL Generation Report

## bifidoannotator_bifidoAnnotator

### Tool Description
Complete GH Annotation & Visualization Pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/bifidoannotator:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/nicholaspucci/bifidoAnnotator
- **Package**: https://anaconda.org/channels/bioconda/packages/bifidoannotator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bifidoannotator/overview
- **Total Downloads**: 205
- **Last updated**: 2025-10-09
- **GitHub**: https://github.com/nicholaspucci/bifidoAnnotator
- **Stars**: N/A
### Original Help Text
```text
================================================================================
Combined bifidoAnnotator: Complete GH Annotation & Visualization Pipeline
================================================================================
usage: bifidoAnnotator [-h] (-i INPUT_FILE | -d GENOME_DIRECTORY)
                       [-s SAMPLE_FILE] [-o OUTPUT_DIR] [--bifdb BIFDB]
                       [--mapping_file MAPPING_FILE]
                       [--annotations_file ANNOTATIONS_FILE]
                       [--threads THREADS] [--sensitivity SENSITIVITY]
                       [--gh-figsize GH_FIGSIZE GH_FIGSIZE]
                       [--cluster-figsize CLUSTER_FIGSIZE CLUSTER_FIGSIZE]
                       [--enzyme-figsize ENZYME_FIGSIZE ENZYME_FIGSIZE]
                       [-hc {red,blue}]

Combined bifidoAnnotator: Complete GH annotation and visualization pipeline with adaptive sizing

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Path to single input FASTA file
  -d, --genome_directory GENOME_DIRECTORY
                        Path to directory containing input FASTA files
  -s, --sample_file SAMPLE_FILE
                        Text file listing genome names for processing
                        (required with -d)
  -o, --output_dir OUTPUT_DIR
                        Output directory (default: bifidoAnnotator_output)
  --bifdb BIFDB         Path to MMseqs2 database (default: auto-download from
                        Zenodo on first run)
  --mapping_file MAPPING_FILE
                        Path to mapping file (default: packaged or downloaded
                        with database)
  --annotations_file ANNOTATIONS_FILE
                        TSV file with genome annotations for heatmap legends
  --threads THREADS     Number of threads for MMseqs2 (default: 4)
  --sensitivity SENSITIVITY
                        MMseqs2 sensitivity (default: 7.5)
  --gh-figsize GH_FIGSIZE GH_FIGSIZE
                        GH heatmap figure size (width height)
  --cluster-figsize CLUSTER_FIGSIZE CLUSTER_FIGSIZE
                        Cluster heatmap figure size (width height)
  --enzyme-figsize ENZYME_FIGSIZE ENZYME_FIGSIZE
                        Enzyme heatmap figure size (width height)
  -hc, --heatmap_col {red,blue}
                        Color scheme for heatmap and annotations (default:
                        blue)

Examples:
  # Single genome (database auto-downloaded on first run)
  bifidoAnnotator -i genome.fasta -o results

  # Batch processing
  bifidoAnnotator -d genomes_dir -s sample_list.txt -o results
  
  # With annotations
  bifidoAnnotator -i genome.fasta --annotations_file metadata.tsv -o results
  
  # Using custom database
  bifidoAnnotator -i genome.fasta --bifdb /custom/db --mapping_file /custom/mapping.tsv -o results

Note: On first run, the reference database (~350 MB) will be automatically 
downloaded from Zenodo. This only happens once.
```

