cwlVersion: v1.2
class: CommandLineTool
baseCommand: virdig
label: virdig
doc: "A tool for viral discovery/genomics (Note: The provided text contains container
  build logs rather than CLI help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/Limh616/VirDiG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virdig:1.0.0--h5ca1c30_0
stdout: virdig.out
