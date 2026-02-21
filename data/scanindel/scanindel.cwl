cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanindel
label: scanindel
doc: "ScanIndel is a tool for detecting insertions and deletions (indels) from next-generation
  sequencing (NGS) data.\n\nTool homepage: https://github.com/cauyrd/ScanIndel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanindel:1.3--py27_0
stdout: scanindel.out
