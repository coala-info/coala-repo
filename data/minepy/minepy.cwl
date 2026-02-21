cwlVersion: v1.2
class: CommandLineTool
baseCommand: minepy
label: minepy
doc: "The minepy library provides a library for the Maximal Information Coefficient
  (MIC) and the Maximal Information-based Nonparametric Exploration (MINE) family
  of statistics.\n\nTool homepage: http://minepy.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minepy:1.2.3--py27h14c3975_0
stdout: minepy.out
