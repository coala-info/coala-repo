cwlVersion: v1.2
class: CommandLineTool
baseCommand: submission-excel2xml
label: submission-excel2xml
doc: "A tool for converting Excel files to XML format, typically used for metadata
  submissions in bioinformatics.\n\nTool homepage: https://github.com/ddbj/submission-excel2xml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/submission-excel2xml:3.6.2--hdfd78af_0
stdout: submission-excel2xml.out
