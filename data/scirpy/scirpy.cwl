cwlVersion: v1.2
class: CommandLineTool
baseCommand: scirpy
label: scirpy
doc: "The provided text contains system error messages related to a container environment
  (Singularity/Docker) and does not contain the actual help documentation for the
  scirpy tool. As a result, no arguments could be extracted.\n\nTool homepage: https://icbi-lab.github.io/scirpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scirpy:0.23.0--pyhdfd78af_0
stdout: scirpy.out
