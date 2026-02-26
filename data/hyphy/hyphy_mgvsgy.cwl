cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_mgvsgy
label: hyphy_mgvsgy
doc: "Choose Genetic Code\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: genetic_code
    type: int
    doc: Select a genetic code from the provided list. Options are numbered 1 
      through 22.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mgvsgy.out
