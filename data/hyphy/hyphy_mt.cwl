cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_mt
label: hyphy_mt
doc: "RUNNING MODEL TESTING ANALYSIS Based on the program ModelTest\n\nTool homepage:
  http://hyphy.org/"
inputs:
  - id: data_file
    type: File
    doc: Please specify a nucleotide data file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mt.out
