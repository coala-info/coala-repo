cwlVersion: v1.2
class: CommandLineTool
baseCommand: ConSplice
label: consplice_ml
doc: "ConSplice: error: argument command: invalid choice: 'ml' (choose from 'ML',
  'constraint')\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: command
    type: string
    doc: Subcommand to run (ML or constraint)
    inputBinding:
      position: 1
  - id: config_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --config-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
stdout: consplice_ml.out
