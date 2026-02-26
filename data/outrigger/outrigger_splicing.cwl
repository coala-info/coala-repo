cwlVersion: v1.2
class: CommandLineTool
baseCommand: outrigger
label: outrigger_splicing
doc: "outrigger: error: invalid choice: 'splicing' (choose from 'index', 'validate',
  'psi')\n\nTool homepage: https://yeolab.github.io/outrigger"
inputs:
  - id: command
    type: string
    doc: Subcommand to run (index, validate, psi)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/outrigger:1.1.1--py35_0
stdout: outrigger_splicing.out
