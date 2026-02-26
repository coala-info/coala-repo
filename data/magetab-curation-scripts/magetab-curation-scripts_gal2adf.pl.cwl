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
outputs:
  - id: output_adf_file
    type:
      - 'null'
      - File
    doc: output adf file
    outputBinding:
      glob: $(inputs.output_adf_file)
  - id: output_database_id_file
    type:
      - 'null'
      - File
    doc: output database ID file
    outputBinding:
      glob: $(inputs.output_database_id_file)
  - id: error_log_file
    type:
      - 'null'
      - File
    doc: output error log file
    outputBinding:
      glob: $(inputs.error_log_file)
  - id: warning_log_file
    type:
      - 'null'
      - File
    doc: output warning log file
    outputBinding:
      glob: $(inputs.warning_log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
