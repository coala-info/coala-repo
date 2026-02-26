cwlVersion: v1.2
class: CommandLineTool
baseCommand: kwip
label: kwip
doc: "Calculate kernel matrices and distance matrices from oxli Countgraph files.\n\
  \nTool homepage: https://github.com/kdmurray91/kWIP"
inputs:
  - id: hashes
    type:
      type: array
      items: File
    doc: Each sample's oxli Countgraph should be specified after arguments
    inputBinding:
      position: 1
  - id: calc_weights
    type:
      - 'null'
      - boolean
    doc: Calculate only the bin weight vector, not kernel matrix.
    inputBinding:
      position: 102
      prefix: --calc-weights
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Execute silently but for errors.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to utilise.
    inputBinding:
      position: 102
      prefix: --threads
  - id: unweighted
    type:
      - 'null'
      - boolean
    doc: Use the unweighted inner proudct kernel.
    default: false
    inputBinding:
      position: 102
      prefix: --unweighted
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity. May or may not acutally do anything.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: weights
    type:
      - 'null'
      - File
    doc: Bin weight vector file (input, or output w/ -C).
    inputBinding:
      position: 102
      prefix: --weights
outputs:
  - id: kernel_output
    type:
      - 'null'
      - File
    doc: Output file for the kernel matrix.
    outputBinding:
      glob: $(inputs.kernel_output)
  - id: distance_output
    type:
      - 'null'
      - File
    doc: Output file for the distance matrix.
    outputBinding:
      glob: $(inputs.distance_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kwip:0.2.0--hd28b015_0
