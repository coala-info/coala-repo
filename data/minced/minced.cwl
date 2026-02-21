cwlVersion: v1.2
class: CommandLineTool
baseCommand: minced
label: minced
doc: "MinCED is a program to find Clustered Regularly Interspaced Short Palindromic
  Repeats (CRISPRs) in full genomes or environmental datasets.\n\nTool homepage: https://github.com/ctSkennerton/minced"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minced:0.4.2--0
stdout: minced.out
