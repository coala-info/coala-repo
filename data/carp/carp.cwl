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
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: size_thresh
    type:
      - 'null'
      - string
    doc: Size threshold for nodes (nodes of lower sizes are discarded)
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
  - id: write_ancestor_path
    type:
      - 'null'
      - string
    doc: Path to write ancestral adjacencies to.
    inputBinding:
      position: 102
      prefix: --write-ancestor
  - id: write_measure_path
    type:
      - 'null'
      - string
    doc: Path to write the carp measure to.
    inputBinding:
      position: 103
      prefix: --write-measure
outputs:
  - id: stdout
    type: stdout
    doc: SCJ CARP measure printed to standard output
  - id: write_ancestor
    type:
      - 'null'
      - File
    doc: Path to write ancestral adjacencies to.
    outputBinding:
      glob: $(inputs.write_ancestor_path)
  - id: write_measure
    type:
      - 'null'
      - File
    doc: Path to write the carp measure to.
    outputBinding:
      glob: $(inputs.write_measure_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carp:0.1.1--h4349ce8_0
stdout: carp.out
