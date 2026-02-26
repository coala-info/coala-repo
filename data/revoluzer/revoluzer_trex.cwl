cwlVersion: v1.2
class: CommandLineTool
baseCommand: trex
label: revoluzer_trex
doc: "trex method selection\n\nTool homepage: https://gitlab.com/Bernt/revoluzer/"
inputs:
  - id: alternative_bpscenario
    type:
      - 'null'
      - boolean
    doc: get alternative bpscenario for prime nodes
    inputBinding:
      position: 101
      prefix: -o
  - id: circular_genomes
    type:
      - 'null'
      - boolean
    doc: circular genomes
    inputBinding:
      position: 101
      prefix: -c
  - id: file
    type: File
    doc: file containing the genomes (and trees)
    inputBinding:
      position: 101
      prefix: -f
  - id: max_scenarios
    type:
      - 'null'
      - int
    doc: maximal number of rev+tdrl scenarios
    inputBinding:
      position: 101
      prefix: -m
  - id: parsimonious_weak_consistency
    type:
      - 'null'
      - boolean
    doc: parsimounious weak consistency method
    inputBinding:
      position: 101
      prefix: -W
  - id: strong_consistency
    type:
      - 'null'
      - boolean
    doc: strong consistency method
    inputBinding:
      position: 101
      prefix: -s
  - id: trees_file
    type:
      - 'null'
      - File
    doc: file containing the trees
    inputBinding:
      position: 101
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: level of verbosity
    inputBinding:
      position: 101
      prefix: -v
  - id: weak_consistency
    type:
      - 'null'
      - boolean
    doc: weak consistency method
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: dot_output_file
    type:
      - 'null'
      - File
    doc: file for dot output
    outputBinding:
      glob: $(inputs.dot_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
