cwlVersion: v1.2
class: CommandLineTool
baseCommand: density-fitness
label: density-fitness
doc: "The provided text does not contain help documentation for the tool. It contains
  container runtime log messages and a fatal error indicating a failure to build the
  container image due to lack of disk space.\n\nTool homepage: https://github.com/PDB-REDO/density-fitness"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/density-fitness:1.2.0--h077b44d_0
stdout: density-fitness.out
