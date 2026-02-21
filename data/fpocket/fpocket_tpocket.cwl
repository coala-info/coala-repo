cwlVersion: v1.2
class: CommandLineTool
baseCommand: tpocket
label: fpocket_tpocket
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error related to a container runtime (Apptainer/Singularity)
  failing to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/Discngine/fpocket"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpocket:4.0.0
stdout: fpocket_tpocket.out
