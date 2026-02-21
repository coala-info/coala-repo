cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr
label: longcallr_nn_longcallR_dp
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error indicating a failure to build the container
  image due to lack of disk space.\n\nTool homepage: https://github.com/huangnengCSU/longcallR-nn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py312h67e1f27_0
stdout: longcallr_nn_longcallR_dp.out
