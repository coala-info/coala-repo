cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hamronize
  - resfams
label: hamronization_hamronize_resfams
doc: "Applies hAMRonization specification to output(s) from resfams (resfams.tblout)\n\nTool homepage: https://github.com/pha4ge/hAMRonization"
inputs:
  - id: report
    type:
      type: array
      items: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (tsv or json)
    inputBinding:
      position: 102
      prefix: --format
  - id: output_path
    type: string
    doc: Output location
    inputBinding:
      position: 103
      prefix: --output
  - id: analysis_software_version
    type: string
    doc: Input string containing the analysis_software_version for resfams
    inputBinding:
      position: 104
      prefix: --analysis_software_version
  - id: reference_database_version
    type: string
    doc: Input string containing the reference_database_version for resfams
    inputBinding:
      position: 105
      prefix: --reference_database_version
  - id: input_file_name
    type: string
    doc: Input string containing the input_file_name for resfams
    inputBinding:
      position: 106
      prefix: --input_file_name
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
