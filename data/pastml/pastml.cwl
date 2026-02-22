cwlVersion: v1.2
class: CommandLineTool
baseCommand: pastml
label: pastml
doc: "Ancestral state reconstruction and visualization (Note: The provided text contains
  system error messages regarding disk space and container image retrieval rather
  than tool help documentation).\n\nTool homepage: https://pastml.pasteur.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
stdout: pastml.out
