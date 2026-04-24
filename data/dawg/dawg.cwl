cwlVersion: v1.2
class: CommandLineTool
baseCommand: dawg
label: dawg
doc: "Copyright (C) 2004-2013  Reed A. Cartwright, PhD <cartwright@asu.edu>\n\nTool
  homepage: https://github.com/reedacartwright/dawg"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input dawg files
    inputBinding:
      position: 1
  - id: append
    type:
      - 'null'
      - string
    doc: append output to file
    inputBinding:
      position: 102
      prefix: --append
  - id: arg_file
    type:
      - 'null'
      - File
    doc: read arguments from file
    inputBinding:
      position: 102
      prefix: --arg-file
  - id: help_trick
    type:
      - 'null'
      - boolean
    doc: display description of common control variables
    inputBinding:
      position: 102
      prefix: --help-trick
  - id: label
    type:
      - 'null'
      - string
    doc: label each simulation with a unique id
    inputBinding:
      position: 102
      prefix: --label
  - id: reps
    type:
      - 'null'
      - int
    doc: the number of alignments to generate
    inputBinding:
      position: 102
      prefix: --reps
  - id: seed
    type:
      - 'null'
      - int
    doc: PRNG seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: split
    type:
      - 'null'
      - string
    doc: split output into separate files
    inputBinding:
      position: 102
      prefix: --split
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to this file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dawg:2.0.beta1--h81a73ca_1
