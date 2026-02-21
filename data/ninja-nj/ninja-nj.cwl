cwlVersion: v1.2
class: CommandLineTool
baseCommand: ninja-nj
label: ninja-nj
doc: "A tool for Neighbor-Joining (NJ) tree construction. Note: The provided text
  is a container execution error log and does not contain help information or argument
  definitions.\n\nTool homepage: https://github.com/TravisWheelerLab/NINJA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ninja-nj:1.00--h9948957_1
stdout: ninja-nj.out
