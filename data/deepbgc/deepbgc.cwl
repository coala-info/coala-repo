cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbgc
label: deepbgc
doc: "DeepBGC: Biosynthetic Gene Cluster detection and classification (Note: The provided
  text is a system error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/Merck/DeepBGC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
stdout: deepbgc.out
