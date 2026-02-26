cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem_summarise
label: singlem_summarise
doc: "Summarise single-cell RNA-seq data\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: input_file
    type: File
    doc: Input single-cell RNA-seq data file (e.g., .h5ad, .loom, .mtx)
    inputBinding:
      position: 1
  - id: min_cells
    type:
      - 'null'
      - int
    doc: Minimum number of cells a gene must be detected in to be included
    default: 3
    inputBinding:
      position: 102
      prefix: --min-cells
  - id: min_genes
    type:
      - 'null'
      - int
    doc: Minimum number of genes detected in a cell to be included
    default: 200
    inputBinding:
      position: 102
      prefix: --min-genes
  - id: n_top_genes
    type:
      - 'null'
      - int
    doc: Number of highly variable genes to identify
    default: 2000
    inputBinding:
      position: 102
      prefix: --n-top-genes
  - id: output_dir
    type: Directory
    doc: Directory to save the summary files
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: plot_pca
    type:
      - 'null'
      - boolean
    doc: Generate PCA plot
    inputBinding:
      position: 102
      prefix: --plot-pca
  - id: plot_scatter
    type:
      - 'null'
      - boolean
    doc: Generate scatter plots for QC metrics
    inputBinding:
      position: 102
      prefix: --plot-scatter
  - id: plot_tsne
    type:
      - 'null'
      - boolean
    doc: Generate t-SNE plot
    inputBinding:
      position: 102
      prefix: --plot-tsne
  - id: plot_umap
    type:
      - 'null'
      - boolean
    doc: Generate UMAP plot
    inputBinding:
      position: 102
      prefix: --plot-umap
  - id: plot_violin
    type:
      - 'null'
      - boolean
    doc: Generate violin plots for QC metrics
    inputBinding:
      position: 102
      prefix: --plot-violin
  - id: target_sum
    type:
      - 'null'
      - int
    doc: Target sum of counts per cell for normalization (if not specified, uses
      median)
    inputBinding:
      position: 102
      prefix: --target-sum
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_summarise.out
