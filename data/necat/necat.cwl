cwlVersion: v1.2
class: CommandLineTool
baseCommand: necat
label: necat
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error message regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
stdout: necat.out
