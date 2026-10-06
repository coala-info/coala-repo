cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - validate-table
label: biom-format_validate_table
doc: "Test a file for adherence to the Biological Observation Matrix (BIOM) format specification.\n\
  \nTool homepage: http://www.biom-format.org"
inputs:
  - id: input_fp
    type: File
    doc: The input filepath to validate against the BIOM format specification
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: format_version
    type:
      - 'null'
      - string
    doc: The specific format version to validate against
    inputBinding:
      position: 101
      prefix: --format-version
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
stdout: biom-format_validate_table.out
