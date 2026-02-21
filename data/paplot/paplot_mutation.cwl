cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paplot
  - mutation
label: paplot_mutation
doc: "Generate mutation reports using paplot\n\nTool homepage: https://github.com/Genomon-Project/paplot.git"
inputs:
  - id: input
    type: File
    doc: input files path
    inputBinding:
      position: 1
  - id: project_name
    type: string
    doc: project name
    inputBinding:
      position: 2
  - id: config_file
    type:
      - 'null'
      - File
    doc: config file
    inputBinding:
      position: 103
      prefix: --config_file
  - id: ellipsis
    type:
      - 'null'
      - string
    doc: report file's ID
    inputBinding:
      position: 103
      prefix: --ellipsis
  - id: overview
    type:
      - 'null'
      - string
    doc: overview about report file
    inputBinding:
      position: 103
      prefix: --overview
  - id: remarks
    type:
      - 'null'
      - string
    doc: optional text
    inputBinding:
      position: 103
      prefix: --remarks
  - id: title
    type:
      - 'null'
      - string
    doc: report's title
    inputBinding:
      position: 103
      prefix: --title
outputs:
  - id: output_dir
    type: Directory
    doc: output file path
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paplot:0.5.6--pyh5e36f6f_0
