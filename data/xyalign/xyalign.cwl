cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyalign
label: xyalign
doc: "A tool for analyzing and correcting for sex chromosome complement in genomic
  data.\n\nTool homepage: https://github.com/WilsonSayresLab/XYalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xyalign:1.1.5--py_0
stdout: xyalign.out
