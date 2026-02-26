cwlVersion: v1.2
class: CommandLineTool
baseCommand: neurodocker
label: neurodocker_valid
doc: "neurodocker: error: argument subparser_name: invalid choice: 'valid' (choose
  from 'generate', 'reprozip')\n\nTool homepage: https://github.com/kaczmarj/neurodocker"
inputs:
  - id: verbose
    type:
      - 'null'
      - string
    doc: Set verbosity level (debug, info, warning, error, critical)
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neurodocker:0.5.0--py_0
stdout: neurodocker_valid.out
