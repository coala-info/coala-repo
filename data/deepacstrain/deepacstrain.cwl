cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepacstrain
label: deepacstrain
doc: "DeePaC-strain CLI for creating configuration templates and training models for
  strain-level classification.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run (templates or train)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
stdout: deepacstrain.out
