cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - tme_cluster
label: iobrpy_tme_cluster
doc: "Perform TME clustering on input data.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: features
    type:
      - 'null'
      - string
    doc: Feature columns to use, e.g. '1:22' if use cibersort(excluding the 
      sample column)
    inputBinding:
      position: 101
      prefix: --features
  - id: id
    type:
      - 'null'
      - string
    doc: 'Column name for sample IDs (default: first column)'
    default: first column
    inputBinding:
      position: 101
      prefix: --id
  - id: input_file
    type: File
    doc: Path to input file (CSV/TSV/TXT)
    inputBinding:
      position: 101
      prefix: --input
  - id: input_sep
    type:
      - 'null'
      - string
    doc: Field separator for input (auto-detect if not set)
    inputBinding:
      position: 101
      prefix: --input_sep
  - id: max_iter
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for the k-means algorithm
    inputBinding:
      position: 101
      prefix: --max_iter
  - id: max_nc
    type:
      - 'null'
      - int
    doc: Maximum number of clusters
    inputBinding:
      position: 101
      prefix: --max_nc
  - id: min_nc
    type:
      - 'null'
      - int
    doc: Minimum number of clusters
    inputBinding:
      position: 101
      prefix: --min_nc
  - id: no_scale
    type:
      - 'null'
      - boolean
    doc: Disable z-score scaling
    inputBinding:
      position: 101
      prefix: --no-scale
  - id: output_sep
    type:
      - 'null'
      - string
    doc: Field separator for output (auto-detect if not set)
    inputBinding:
      position: 101
      prefix: --output_sep
  - id: pattern
    type:
      - 'null'
      - string
    doc: Regex to select feature columns by name
    inputBinding:
      position: 101
      prefix: --pattern
  - id: print_result
    type:
      - 'null'
      - boolean
    doc: Print intermediate KL scores and cluster counts
    inputBinding:
      position: 101
      prefix: --print_result
  - id: scale
    type:
      - 'null'
      - boolean
    doc: 'Enable z-score scaling (default: True)'
    default: true
    inputBinding:
      position: 101
      prefix: --scale
  - id: tol
    type:
      - 'null'
      - float
    doc: Convergence tolerance for cluster center updates
    inputBinding:
      position: 101
      prefix: --tol
outputs:
  - id: output_file
    type: File
    doc: Path to save clustering results (CSV/TSV/TXT)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
