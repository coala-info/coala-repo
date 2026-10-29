cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_star_printtable
label: relion_relion_star_printtable
doc: "Print the content of one data table of a STAR file, optionally only the given labels.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
inputs:
  - id: star_file
    type: File
    doc: Input STAR file
    inputBinding:
      position: 1
  - id: table_name
    type: string
    doc: Name of the data block, for example data_model_class_1
    inputBinding:
      position: 2
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Only print these labels (without the leading underscore)
    inputBinding:
      position: 3
outputs:
  - id: table
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_star_printtable.out
