cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbskera
label: pbskera
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to pull or build the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/PacificBiosciences/skera"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbskera:1.4.0--hdfd78af_0
stdout: pbskera.out
