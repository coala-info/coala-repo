cwlVersion: v1.2
class: CommandLineTool
baseCommand: itol_config binary_data
label: itol-config_binary_data
doc: "Generates an iTOL configuration file for binary data from a CSV input.\n\nTool
  homepage: https://github.com/jodyphelan/itol-config"
inputs:
  - id: colour_conf
    type:
      - 'null'
      - File
    doc: Colour configuration file
    inputBinding:
      position: 101
      prefix: --colour-conf
  - id: id
    type:
      - 'null'
      - string
    doc: Column name matching the sequence IDs used in the tree
    inputBinding:
      position: 101
      prefix: --id
  - id: input
    type: File
    doc: Input file containing a csv file with sequence metadata
    inputBinding:
      position: 101
      prefix: --input
  - id: symbol
    type:
      - 'null'
      - string
    doc: 'The symbol to use for the binary data (1: square, 2: circle, 3: star, 4:
      right triangle, 5: left triangle, 6: checkmark)'
    inputBinding:
      position: 101
      prefix: --symbol
outputs:
  - id: output
    type: File
    doc: Output file name for the iTOL configuration file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itol-config:0.1.0--pyhdfd78af_0
