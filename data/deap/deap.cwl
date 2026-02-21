cwlVersion: v1.2
class: CommandLineTool
baseCommand: deap
label: deap
doc: "The provided text does not contain help information for the tool 'deap'. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build or pull the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/DEAP/deap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deap:1.0.2--py36_0
stdout: deap.out
