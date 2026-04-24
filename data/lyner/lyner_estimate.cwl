cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - estimate
label: lyner_estimate
doc: "Estimate gene expression levels from RNA-Seq data.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Input gene expression matrix (e.g., counts, TPM).
    inputBinding:
      position: 1
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: Apply log transformation to the data.
    inputBinding:
      position: 102
      prefix: --log-transform
  - id: min_counts
    type:
      - 'null'
      - int
    doc: Minimum number of counts for a gene to be considered.
    inputBinding:
      position: 102
      prefix: --min-counts
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize the input matrix before estimation.
    inputBinding:
      position: 102
      prefix: --normalize
  - id: output_dir
    type: Directory
    doc: Directory to save the estimation results.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_estimate.out
