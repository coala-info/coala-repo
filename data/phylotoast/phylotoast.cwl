cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylotoast
label: phylotoast
doc: "Phylotoast is a set of tools for analyzing and visualizing 16S rRNA gene sequencing
  data, often used in conjunction with QIIME.\n\nTool homepage: https://github.com/smdabdoub/phylotoast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
stdout: phylotoast.out
