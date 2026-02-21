cwlVersion: v1.2
class: CommandLineTool
baseCommand: pulchra
label: pulchra
doc: "PULCHRA: Protein Reconstruction from Alpha-carbons. A tool for restoring full-atom
  protein models from reduced representations (C-alpha atoms).\n\nTool homepage: https://www.pirx.com/pulchra/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pulchra:3.06--h031d066_4
stdout: pulchra.out
