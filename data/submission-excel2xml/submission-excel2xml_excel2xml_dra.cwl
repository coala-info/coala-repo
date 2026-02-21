cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - excel2xml_dra
label: submission-excel2xml_excel2xml_dra
doc: "A tool for converting Excel submission files to XML format, specifically for
  DRA (DDBJ Sequence Read Archive) submissions.\n\nTool homepage: https://github.com/ddbj/submission-excel2xml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/submission-excel2xml:3.6.2--hdfd78af_0
stdout: submission-excel2xml_excel2xml_dra.out
