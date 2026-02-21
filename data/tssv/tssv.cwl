cwlVersion: v1.2
class: CommandLineTool
baseCommand: tssv
label: tssv
doc: "Targeted Short Sequence Variation (TSSV) analysis tool. Note: The provided text
  appears to be a container build error log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tssv:1.1.2--py312h0fa9677_6
stdout: tssv.out
