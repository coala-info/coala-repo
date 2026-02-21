cwlVersion: v1.2
class: CommandLineTool
baseCommand: flumutdb
label: flumutdb
doc: "A tool for influenza mutation database management (Note: The provided text contains
  only container runtime error messages and no help documentation to parse arguments
  from).\n\nTool homepage: https://github.com/izsvenezie-virology/FluMutDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flumutdb:6.5--pyhdfd78af_0
stdout: flumutdb.out
