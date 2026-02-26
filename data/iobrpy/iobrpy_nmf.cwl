cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - nmf
label: iobrpy_nmf
doc: "Non-negative Matrix Factorization (NMF) for dimensionality reduction and deconvolution.\n\
  \nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: features
    type:
      - 'null'
      - string
    doc: Columns (cell types) to use, e.g. '2-10' or '1:5'. 1-based inclusive.
    inputBinding:
      position: 101
      prefix: --features
  - id: input_file
    type: File
    doc: Input matrix file (CSV or TSV). First column should be sample names 
      (index).
    inputBinding:
      position: 101
      prefix: --input
  - id: kmax
    type:
      - 'null'
      - int
    doc: Maximum k (inclusive).
    default: 8
    inputBinding:
      position: 101
      prefix: --kmax
  - id: kmin
    type:
      - 'null'
      - int
    doc: Minimum k (inclusive).
    default: 2
    inputBinding:
      position: 101
      prefix: --kmin
  - id: log1p
    type:
      - 'null'
      - boolean
    doc: Apply log1p transform to the input (useful for counts).
    inputBinding:
      position: 101
      prefix: --log1p
  - id: max_iter
    type:
      - 'null'
      - int
    doc: 'Maximum iterations for NMF (default: 1000)'
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-iter
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Apply L1 row normalization (each sample sums to 1).
    inputBinding:
      position: 101
      prefix: --normalize
  - id: random_state
    type:
      - 'null'
      - int
    doc: Random state passed to NMF
    inputBinding:
      position: 101
      prefix: --random-state
  - id: shift
    type:
      - 'null'
      - float
    doc: If input contains negatives, add a constant shift to make values 
      non-negative.
    inputBinding:
      position: 101
      prefix: --shift
  - id: skip_k_2
    type:
      - 'null'
      - boolean
    doc: 'Skip k=2 when searching for the best k (default: do not skip)'
    inputBinding:
      position: 101
      prefix: --skip_k_2
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory where results will be saved.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
