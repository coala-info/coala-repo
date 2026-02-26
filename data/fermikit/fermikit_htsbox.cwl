cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsbox
label: fermikit_htsbox
doc: "A collection of htslib-based tools for sequence data manipulation.\n\nTool homepage:
  https://github.com/lh3/fermikit"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., samview, vcfview, tabix, etc.)
    inputBinding:
      position: 1
  - id: argument
    type: string
    doc: The argument for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_htsbox.out
