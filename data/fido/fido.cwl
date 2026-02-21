cwlVersion: v1.2
class: CommandLineTool
baseCommand: fido
label: fido
doc: "Fido: A Bayesian Protein Identification Tool (Note: The provided text is a container
  runtime error log and does not contain CLI help information or argument definitions).\n
  \nTool homepage: https://github.com/pbatard/Fido"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fido:1.0--h9948957_8
stdout: fido.out
