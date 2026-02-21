cwlVersion: v1.2
class: CommandLineTool
baseCommand: frogs
label: frogs
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: frogs.out
