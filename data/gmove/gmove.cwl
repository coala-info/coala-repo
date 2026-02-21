cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmove
label: gmove
doc: "G-MoVe (Gene Modeling using Various Evidence) is a tool for gene prediction
  and annotation. Note: The provided text is an error log and does not contain usage
  information or argument definitions.\n\nTool homepage: https://github.com/institut-de-genomique/Gmove"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmove:1.3--h9948957_0
stdout: gmove.out
