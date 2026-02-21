cwlVersion: v1.2
class: CommandLineTool
baseCommand: adptSim
label: gargammel-slim_adptSim
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
stdout: gargammel-slim_adptSim.out
