cwlVersion: v1.2
class: CommandLineTool
baseCommand: crispritz
label: crispritz
doc: "CRISPRitz is a suite of tools to perform a fully comprehensive search and evaluation
  of CRISPR/Cas off-targets.\n\nTool homepage: https://github.com/InfOmics/CRISPRitz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
stdout: crispritz.out
