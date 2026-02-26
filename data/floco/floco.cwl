cwlVersion: v1.2
class: CommandLineTool
baseCommand: floco
label: floco
doc: "Calculate copy numbers from graph and alignments.\n\nTool homepage: https://github.com/hugocarmaga/floco"
inputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: The GAF file with sequence-to-graph alignments.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: bg_ploidy
    type:
      - 'null'
      - type: array
        items: int
    doc: Expected most common CN value in the graph (background ploidy of the 
      dataset).
    default: '[1, 2]'
    inputBinding:
      position: 101
      prefix: --bg-ploidy
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Set the bin size to use for the NB parameters estimation.
    default: 100
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: cheap_pen
    type:
      - 'null'
      - float
    doc: Probability for using the super edges when there is no other edge 
      available.
    default: -25
    inputBinding:
      position: 101
      prefix: --cheap-pen
  - id: complexity
    type:
      - 'null'
      - int
    doc: 'Model complexity (1-3): larger = slower and more accurate.'
    default: 2
    inputBinding:
      position: 101
      prefix: --complexity
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Produce additional files.
    inputBinding:
      position: 101
      prefix: --debug
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Epsilon value for adjusting CN0 counts to probabilities
    default: 0.02
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: expen_pen
    type:
      - 'null'
      - float
    doc: Probability for using the super edges when there are other edges 
      available.
    default: -10000
    inputBinding:
      position: 101
      prefix: --expen-pen
  - id: graph
    type: File
    doc: The GFA file with the graph.
    inputBinding:
      position: 101
      prefix: --graph
  - id: pickle
    type:
      - 'null'
      - File
    doc: Pickle dump with the data. Dump file can be produced with '--debug'.
    inputBinding:
      position: 101
      prefix: --pickle
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of computing threads to use by the ILP solver.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: The name for the output csv file with the copy numbers.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/floco:1.1.0--pyhdfd78af_0
