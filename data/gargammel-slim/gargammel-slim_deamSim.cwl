cwlVersion: v1.2
class: CommandLineTool
baseCommand: deamSim
label: gargammel-slim_deamSim
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
stdout: gargammel-slim_deamSim.out
