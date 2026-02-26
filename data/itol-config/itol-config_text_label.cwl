cwlVersion: v1.2
class: CommandLineTool
baseCommand: itol_config text_label
label: itol-config_text_label
doc: "Generates an iTOL text label configuration file from a CSV file.\n\nTool homepage:
  https://github.com/jodyphelan/itol-config"
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
outputs:
  - id: output
    type: File
    doc: Output file name for the iTOL configuration file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itol-config:0.1.0--pyhdfd78af_0
