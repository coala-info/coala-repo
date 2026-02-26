cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_mcc
label: hyphy_mcc
doc: "Test for\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: test_type
    type: string
    doc: 'Type of test to perform. Options are: Mean branch length, Mean pairwise
      divergence.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mcc.out
