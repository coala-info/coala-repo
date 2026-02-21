cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr
label: longcallr_longcallR-asj
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages indicating a failure to build a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/huangnengCSU/longcallR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py312h67e1f27_0
stdout: longcallr_longcallR-asj.out
