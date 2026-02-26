cwlVersion: v1.2
class: CommandLineTool
baseCommand: scepia
label: scepia
doc: "SCEPIA: Single-cell RNA sequencing data analysis pipeline\n\nTool homepage:
  https://github.com/vanheeringen-lab/scepia"
inputs:
  - id: input_file
    type: File
    doc: Input data file (e.g., AnnData, Loom, H5AD)
    inputBinding:
      position: 1
  - id: cluster_resolution
    type:
      - 'null'
      - float
    doc: Resolution for Louvain/Leiden clustering
    default: 0.5
    inputBinding:
      position: 102
      prefix: --cluster-resolution
  - id: marker_genes_method
    type:
      - 'null'
      - string
    doc: Method for finding marker genes (e.g., 'wilcoxon', 't-test')
    default: wilcoxon
    inputBinding:
      position: 102
      prefix: --marker-genes-method
  - id: n_components
    type:
      - 'null'
      - int
    doc: Number of components for dimensionality reduction
    default: 2
    inputBinding:
      position: 102
      prefix: --n-components
  - id: n_neighbors
    type:
      - 'null'
      - int
    doc: Number of neighbors for UMAP/t-SNE
    default: 15
    inputBinding:
      position: 102
      prefix: --n-neighbors
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Normalization method (e.g., 'log1p', 'scran')
    default: log1p
    inputBinding:
      position: 102
      prefix: --normalization-method
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save results
    default: .
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: qc_thresholds
    type:
      - 'null'
      - string
    doc: Comma-separated list of QC thresholds (e.g., 
      'n_genes_by_counts:100,pct_counts_mt:20')
    inputBinding:
      position: 102
      prefix: --qc-thresholds
  - id: run_all
    type:
      - 'null'
      - boolean
    doc: Run all analysis steps
    inputBinding:
      position: 102
      prefix: --run-all
  - id: skip_clustering
    type:
      - 'null'
      - boolean
    doc: Skip clustering step
    inputBinding:
      position: 102
      prefix: --skip-clustering
  - id: skip_dimensionality_reduction
    type:
      - 'null'
      - boolean
    doc: Skip dimensionality reduction step
    inputBinding:
      position: 102
      prefix: --skip-dimensionality-reduction
  - id: skip_marker_genes
    type:
      - 'null'
      - boolean
    doc: Skip marker gene identification
    inputBinding:
      position: 102
      prefix: --skip-marker-genes
  - id: skip_normalization
    type:
      - 'null'
      - boolean
    doc: Skip normalization step
    inputBinding:
      position: 102
      prefix: --skip-normalization
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: Skip quality control steps
    inputBinding:
      position: 102
      prefix: --skip-qc
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
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
    dockerPull: quay.io/biocontainers/scepia:0.5.1--pyhdfd78af_1
stdout: scepia.out
