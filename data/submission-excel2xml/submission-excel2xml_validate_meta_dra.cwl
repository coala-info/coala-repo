cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - submission-excel2xml
  - validate_meta_dra
label: submission-excel2xml_validate_meta_dra
doc: "Validate metadata for DRA (DDBJ Sequence Read Archive) by converting Excel to
  XML. Note: The provided help text contains only system logs and no usage information.\n
  \nTool homepage: https://github.com/ddbj/submission-excel2xml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/submission-excel2xml:3.6.2--hdfd78af_0
stdout: submission-excel2xml_validate_meta_dra.out
