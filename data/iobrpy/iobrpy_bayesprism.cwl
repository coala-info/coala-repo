cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - bayesprism
label: iobrpy_bayesprism
doc: "BayesPrism is a tool for deconvolution of bulk RNA-seq data using single-cell
  RNA-seq data as a reference.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: cell_state_labels
    type:
      - 'null'
      - File
    doc: Custom cell_state_labels file (one label per line).
    inputBinding:
      position: 101
      prefix: --cell_state_labels
  - id: cell_type_labels
    type:
      - 'null'
      - File
    doc: Custom cell_type_labels file (one label per line).
    inputBinding:
      position: 101
      prefix: --cell_type_labels
  - id: input
    type: File
    doc: Bulk expression matrix (genes x samples). Rows=genes, cols=samples.
    inputBinding:
      position: 101
      prefix: --input
  - id: key
    type:
      - 'null'
      - string
    doc: Tumor key forwarded to prism.Prism.new. Required when using a custom 
      single-cell reference via --sc_dat; defaults to 'Malignant_cells' when the
      bundled reference is used.
    inputBinding:
      position: 101
      prefix: --key
  - id: sc_dat
    type:
      - 'null'
      - File
    doc: Custom single-cell count matrix (genes x cells).
    inputBinding:
      position: 101
      prefix: --sc_dat
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores for BayesPrism (n_cores).
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory for BayesPrism results (theta.csv, theta_cv.csv, 
      Z_tumor.csv).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
