cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast2q
label: fast2q
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/afombravo/2FAST2Q"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast2q:2.8.1--pyh7e72e81_0
stdout: fast2q.out
