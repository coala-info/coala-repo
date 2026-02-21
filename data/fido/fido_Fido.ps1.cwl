cwlVersion: v1.2
class: CommandLineTool
baseCommand: fido_Fido.ps1
label: fido_Fido.ps1
doc: "A tool for protein identification and inference. (Note: The provided input text
  contains system error messages regarding container image building and does not include
  usage instructions or argument definitions.)\n\nTool homepage: https://github.com/pbatard/Fido"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fido:1.0--h9948957_8
stdout: fido_Fido.ps1.out
