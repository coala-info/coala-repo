cwlVersion: v1.2
class: CommandLineTool
baseCommand: biotradis
label: biotradis
doc: "The provided text is an error log indicating that the 'biotradis' executable
  was not found in the environment. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/sanger-pathogens/Bio-Tradis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotradis:1.4.5--0
stdout: biotradis.out
