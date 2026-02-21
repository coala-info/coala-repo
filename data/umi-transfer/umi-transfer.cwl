cwlVersion: v1.2
class: CommandLineTool
baseCommand: umi-transfer
label: umi-transfer
doc: "The provided text does not contain help information for the tool; it appears
  to be a log of a failed container build or image fetch process.\n\nTool homepage:
  https://github.com/SciLifeLab/umi-transfer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umi-transfer:1.6.0--hc1c3326_0
stdout: umi-transfer.out
