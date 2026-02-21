cwlVersion: v1.2
class: CommandLineTool
baseCommand: biodiff
label: biodiff
doc: "A tool for comparing binary files (as indicated by the biodiff(1) reference).\n
  \nTool homepage: https://gitlab.com/LPCDRP/biodiff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biodiff:0.2.2--h7b50bb2_6
stdout: biodiff.out
