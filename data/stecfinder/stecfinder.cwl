cwlVersion: v1.2
class: CommandLineTool
baseCommand: stecfinder
label: stecfinder
doc: "A tool for identifying Shiga toxin-producing Escherichia coli (STEC) from genomic
  data.\n\nTool homepage: https://github.com/LanLab/STECFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stecfinder:1.1.2--pyhdfd78af_0
stdout: stecfinder.out
