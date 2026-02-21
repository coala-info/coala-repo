cwlVersion: v1.2
class: CommandLineTool
baseCommand: kofamscan
label: kofamscan
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log related to a container execution failure
  (no space left on device).\n\nTool homepage: https://www.genome.jp/tools/kofamkoala/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kofamscan:1.3.0--1
stdout: kofamscan.out
