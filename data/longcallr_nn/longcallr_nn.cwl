cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr_nn
label: longcallr_nn
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/huangnengCSU/longcallR-nn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py312h67e1f27_0
stdout: longcallr_nn.out
