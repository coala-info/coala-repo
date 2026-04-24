cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks filter
label: kmtricks_filter
doc: "Filter existing matrix with a new sample.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: compressed_inputs
    type:
      - 'null'
      - boolean
    doc: compressed inputs.
    inputBinding:
      position: 101
      prefix: --cpr-in
  - id: compressed_outputs
    type:
      - 'null'
      - boolean
    doc: compressed outputs.
    inputBinding:
      position: 101
      prefix: --cpr-out
  - id: hard_min
    type:
      - 'null'
      - int
    doc: min abundance to keep a k-mer in --key.
    inputBinding:
      position: 101
      prefix: --hard-min
  - id: in_matrix
    type: Directory
    doc: kmtricks runtime directory which contains the matrix.
    inputBinding:
      position: 101
      prefix: --in-matrix
  - id: key
    type: File
    doc: filtering key (a kmtricks fof with only one sample).
    inputBinding:
      position: 101
      prefix: --key
  - id: out_types
    type:
      - 'null'
      - string
    doc: "output types: (comma separated, ex: --out-types k,m)\n                 \
      \    k: The set of k-mers which are present in the key but absent in the input
      matrix.\n                     m: A new matrix which is the intersection of the
      key and the input matrix.\n                        In count mode, the matrix
      contains an new column corresponding to the abundances\n                   \
      \     of k-mers from the key.\n                     v: A text vector (column)
      representing the abundances or presence/absence of k-mers\n                \
      \        from the key in the input matrix."
    inputBinding:
      position: 101
      prefix: --out-types
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level [debug|info|warning|error].
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
