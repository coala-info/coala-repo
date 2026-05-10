cwlVersion: v1.2
class: CommandLineTool
baseCommand: gal2adf.pl
label: magetab-curation-scripts_gal2adf.pl
doc: "Converts a GAL file to an ADF file.\n\nTool homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs:
  - id: id_column
    type:
      - 'null'
      - int
    doc: column number containing database IDs
    inputBinding:
      position: 101
      prefix: -c
  - id: input_gal_file
    type: File
    doc: input gal file
    inputBinding:
      position: 101
      prefix: -i
  - id: error_log_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `error_log_file_path`
    inputBinding:
      position: 102
      prefix: --error-log-file
  - id: output_adf_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_adf_file_path`
    inputBinding:
      position: 103
      prefix: --output-adf-file
  - id: output_database_id_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_database_id_file_path`
    inputBinding:
      position: 104
      prefix: --output-database-id-file
  - id: warning_log_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `warning_log_file_path`
    inputBinding:
      position: 105
      prefix: --warning-log-file
outputs:
  - id: output_adf_file
    type:
      - 'null'
      - File
    doc: output adf file
    outputBinding:
      glob: $(inputs.output_adf_file_path)
  - id: output_database_id_file
    type:
      - 'null'
      - File
    doc: output database ID file
    outputBinding:
      glob: $(inputs.output_database_id_file_path)
  - id: error_log_file
    type:
      - 'null'
      - File
    doc: output error log file
    outputBinding:
      glob: $(inputs.error_log_file_path)
  - id: warning_log_file
    type:
      - 'null'
      - File
    doc: output warning log file
    outputBinding:
      glob: $(inputs.warning_log_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
