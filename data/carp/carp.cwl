cwlVersion: v1.2
class: CommandLineTool
baseCommand: carp
label: carp
doc: "Calculate SCJ CARP index\n\nTool homepage: https://github.com/gi-bielefeld/scj-carp"
inputs:
  - id: gfa
    type:
      - 'null'
      - File
    doc: Specify input as GFA file.
    inputBinding:
      position: 101
      prefix: --gfa
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use to calculate SCJ CARP index.
    default: 1
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: size_thresh
    type:
      - 'null'
      - string
    doc: Size threshold for nodes (nodes of lower sizes are discarded)
    default: '0'
    inputBinding:
      position: 101
      prefix: --size-thresh
  - id: unimog
    type:
      - 'null'
      - File
    doc: Specify input as unimog file.
    inputBinding:
      position: 101
      prefix: --unimog
outputs:
  - id: write_ancestor
    type:
      - 'null'
      - Directory
    doc: Path to write ancestral adjacencies to.
    outputBinding:
      glob: $(inputs.write_ancestor)
  - id: write_measure
    type:
      - 'null'
      - Directory
    doc: Path to write the carp measure to.
    outputBinding:
      glob: $(inputs.write_measure)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carp:0.1.1--h4349ce8_0
