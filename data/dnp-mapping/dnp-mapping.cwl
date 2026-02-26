cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-mapping
label: dnp-mapping
doc: "Mapping DNA sequence by pattern matrix CC\n\nTool homepage: https://github.com/erinijapranckeviciene/mapping_CC"
inputs:
  - id: input_pattern
    type:
      - 'null'
      - string
    doc: input pattern
    inputBinding:
      position: 101
      prefix: -m
  - id: input_sequence
    type:
      - 'null'
      - string
    doc: input sequence
    inputBinding:
      position: 101
      prefix: -s
  - id: sigma
    type:
      - 'null'
      - float
    doc: sigma (recomend 1 - 5, 0 average)
    inputBinding:
      position: 101
      prefix: -e
  - id: window_gaussian_smoothing
    type:
      - 'null'
      - int
    doc: window of gaussian smoothing (recomend odd 3 - 11)
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-mapping:1.0--h9948957_4
