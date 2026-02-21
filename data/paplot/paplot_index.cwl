cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paplot
  - index
label: paplot_index
doc: "Generate index for paplot output\n\nTool homepage: https://github.com/Genomon-Project/paplot.git"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: config file
    inputBinding:
      position: 101
      prefix: --config_file
  - id: remarks
    type:
      - 'null'
      - string
    doc: optional text
    inputBinding:
      position: 101
      prefix: --remarks
outputs:
  - id: output_dir
    type: Directory
    doc: output file path
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paplot:0.5.6--pyh5e36f6f_0
