cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toLower
label: ucsc-tolower_toLower
doc: "A tool to convert text to lowercase. (Note: The provided help text contains
  only system error messages and does not list specific arguments.)\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-tolower:482--h0b57e2e_0
stdout: ucsc-tolower_toLower.out
