cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_mss-ga-processor
label: hyphy_mss-ga-processor
doc: "Read an alignment (and, optionally, a tree) remove duplicate sequences, and
  prune the tree accordingly.\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: file_path
    type: File
    doc: Codon GA output .JSON file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mss-ga-processor.out
