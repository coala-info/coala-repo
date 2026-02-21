cwlVersion: v1.2
class: CommandLineTool
baseCommand: splicemap
label: splicemap
doc: "SpliceMap is a tool for detecting splice junctions from RNA-seq data.\n\nTool
  homepage: http://www.stanford.edu/group/wonglab/SpliceMap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splicemap:3.3.5.2--h9948957_7
stdout: splicemap.out
